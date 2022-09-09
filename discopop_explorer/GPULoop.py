from numpy import long  # type: ignore
from typing import List, Set

from .GPUMemory import getCalledFunctions, map_node, map_type_t, assignMapType
from .PETGraphX import PETGraphX, CUNode, NodeType, parse_id, DepType
from .utils import get_loop_iterations, is_scalar_val, is_loop_index2
from .utils import __get_variables as get_vars, __get_dep_of_type as get_dep_of_type
from .utils import is_written_in_subtree, is_func_arg, is_readonly, is_global, is_read_in_subtree, is_read_in_right_subtree, is_first_written, is_read_in_subtree
from .pattern_detectors.PatternInfo import PatternInfo
from .variable import Variable
from .pattern_detectors.do_all_detector import DoAllInfo


"""
def remove_duplicates(my_list: List) -> List:
    ""removes the duplicates of a given list

    :param my_list:
    :return:
    ""
    return list(dict.fromkeys(my_list))
"""


def fmt_vars(v: List[Variable]) -> str:
    """ inserts the elements of the VarID vector 'v' into 'ss';
        elements are separated by ','

    :param v:
    :return:
    """
    if not v:  # if (v.empty())
        return ""

    ss: str = v[0].name
    for i in range(1, len(v)):
        ss += ", " + v[i].name
    return ss


def omp_clause_str(name: str, args: List[str]) -> str:
    """ generates a json-string for omp clauses/constructs

    :param name:
    :param args:
    :return:
    """
    # name, converted std::ostringstream to str
    result: str = "{\"name\":\"" + name + "\","

    # args
    result += "\"args\":["
    if args:
        result += '"' + args[0] + '"'
        for i in range(1, len(args)):
            result += ",\"" + args[i] + '"'
    result += "]}"
    return result


def omp_construct_str(name: str, line: long, clauses: List[str]) -> str:
    """

    :param name:
    :param line:
    :param clauses:
    :return:
    """
    result: str = "{\"name\":\"" + name + "\","
    result += "\"line\":" + str(line) + ","
    result += "\"clauses\":["
    if clauses:
        result += clauses[0]
    for i in range(1, len(clauses)):
        result += "," + clauses[i]
    result += "]}"
    return result


# inherits from class ParallelPattern (=PatternInfo)
class GPULoopPattern(PatternInfo):
    # public:
    pet: PETGraphX
    called_functions: Set[str]
    map_type_to: List
    map_type_from: List
    map_type_tofrom: List
    map_type_alloc: List
    reduction_vars_str: List[str]
    reduction_vars_ids: List[Variable]
    iteration_count: int = 0
    has_scalar_reduction_var: bool
    nodeID: str
    # new
    nestedLoops: Set[str]
    nextLoop: str
    parentLoop: str
    collapse: int
    scheduling: str

    def __init__(self, pet: PETGraphX, nodeID: str, startLine, endLine,
                 iterationCount: int):
        node = map_node(pet, nodeID)
        super().__init__(node)  # PatternInfo(node)
        PatternInfo.iterations_count = iterationCount
        self.has_scalar_reduction_var = False  # copy.deepcopy(False)
        self.nodeID = nodeID
        self.startLine = startLine
        self.endLine = endLine
        self.iterationCount = iterationCount
        self.pet = pet
        # print("made new gpu_loop_pattern with ID " +
        #       nodeID + " at " + str(startLine))
        # explicitly initialize empty, else it will copy values of other patterns
        self.map_type_to = []
        self.map_type_tofrom = []
        self.map_type_alloc = []
        self.map_type_from = []
        # should also be done with all others? probably
        self.nestedLoops = set()
        self.called_functions = set()
        self.reduction_vars_str = []
        self.reduction_vars_ids = []
        self.iteration_count = 0
        self.nextLoop = ""
        self.parentLoop = ""
        self.collapse = 1
        self.scheduling = ""

    def toJson(self) -> str:
        """ Generates a json-string which contains the information about how to
            implement this pattern using OpenMP constructs

        :return:
        """
        json_output: str = "{"
        # == == Metadata == ==
        json_output += "\"id\":\"" + str(self.nodeID) + "\","
        json_output += "\"startline\":\"" + self.start_line + "\","
        json_output += "\"endline\":\"" + self.end_line + "\","

        # == == Type == ==
        json_type: str = "DoAll (GPU)" if not self.reduction_vars_str else "Reduction (GPU)"
        json_output += "\"type\":\"" + json_type + "\","

        # == == Constructs == ==
        json_output += "\"constructs\":["
        constructs: List[str] = []

        # == default construct ==
        clauses: List[str] = []
        var_names: List[str] = []
        if self.map_type_to:
            for var_id in self.map_type_to:
                var_names.append(var_id)
            clauses.append(omp_clause_str("map(to: args)", var_names))
            var_names = []

        if self.map_type_from:
            for var_id in self.map_type_from:
                var_names.append(var_id)
            clauses.append(omp_clause_str("map(from: args)", var_names))
            var_names = []

        if self.map_type_tofrom:
            for var_id in self.map_type_tofrom:
                var_names.append(var_id)
            clauses.append(omp_clause_str("map(tofrom: args)", var_names))
            var_names = []

        if self.map_type_alloc:
            for var_id in self.map_type_alloc:
                var_names.append(var_id)
            clauses.append(omp_clause_str("map(alloc: args)", var_names))
            var_names = []

        if self.reduction_vars_str:
            clauses.append(omp_clause_str("reduction(args)",
                                          self.reduction_vars_str))
            if self.has_scalar_reduction_var:
                clauses.append(omp_clause_str("defaultmap(tofrom:scalar)", []))

        constructs.append(omp_construct_str("#pragma omp target teams distribute parallel for",
                                            self.startLine, clauses))

        # == additional constructs ==
        for node_id in self.called_functions:
            fn_node: CUNode = map_node(self.pet, node_id)
            constructs.append(omp_construct_str("#pragma omp declare target",
                                                fn_node.start_line, []))
            constructs.append(omp_construct_str("#pragma omp end declare target",
                                                fn_node.end_line + 1, []))

        # add all constructs to the output string
        json_output += constructs[0]
        for i in range(1, len(constructs)):
            json_output += "," + constructs[i]

        json_output += "]}"
        return json_output

    def getDataStr(self) -> str:
        """ Generates a string which contains data that is used to rank this loop, e.g.
            the number of iterations and which variables have to be transferred etc.

        :return:
        """
        # The string begins with the type, the LID and the number of iterations.
        fileID = parse_id(self.nodeID)
        ss: str = str(fileID[0]) + ":"
        ss += self.startLine + " "
        ss += "0" if not self.reduction_vars_str else "1"
        ss += " " + str(self.iteration_count) + " "

        # This is followed by three arrays, each containing variable names separated
        # by spaces, e.g. [var_1 var_2 ... var_n].
        # The first array references the variables that have to be copied to the GPU,
        # the second array references the variables that have to be copied to host
        # memory, and the variable names in the third array correspond to the
        # variables that have to be copied to the GPU and then back to host memory.
        ss += "["
        ss += fmt_vars(self.map_type_to)
        ss += "] ["
        ss += fmt_vars(self.map_type_from)
        ss += "] ["
        tmp: List[Variable] = self.map_type_tofrom

        for va in self.reduction_vars_ids:
            tmp.append(va)
        ss += fmt_vars(tmp)
        ss += "]"

        # The final part of this string contains information about the loop's nested
        # loops including their iteration numbers.
        n: CUNode = map_node(self.pet, self.nodeID)
        total_i: long = n.loop_iterations
        for cn_id in self.pet.direct_children(n):
            if cn_id.type == 2:  # type loop
                ss += self.__add_sub_loops_rec(cn_id.id, total_i)
        return ss

    def classifyLoopVars(self, pet: PETGraphX, loop: CUNode) -> None:
        """ Classify the variables that are accessed in this loop, e.g. assign them
            to a map-type vector and find reduction variables

        :return:
        """
        reduction = []
        lst = pet.get_left_right_subtree(loop, False)
        rst = pet.get_left_right_subtree(loop, True)
        sub = pet.subtree_of_type(loop, NodeType.CU)

        raw = set()
        war = set()
        waw = set()
        rev_raw = set()

        dummyFunctions: Set[str] = set()
        self.called_functions.update(getCalledFunctions(
            self.pet, loop, self.called_functions, dummyFunctions))

        for sub_node in sub:
            raw.update(get_dep_of_type(pet, sub_node, DepType.RAW, False))
            war.update(get_dep_of_type(pet, sub_node, DepType.WAR, False))
            waw.update(get_dep_of_type(pet, sub_node, DepType.WAW, False))
            rev_raw.update(get_dep_of_type(pet, sub_node, DepType.RAW, True))

        vars = pet.get_undefined_variables_inside_loop(loop)

        for var in vars:

            if is_scalar_val(var):
                continue
            if is_loop_index2(pet, loop, var.name):
                continue
            elif loop.reduction and pet.is_reduction_var(loop.start_position(), var.name):
                var.operation = pet.get_reduction_sign(
                    loop.start_position(), var.name)
                reduction.append(var)
            # TODO grouping
            if (is_written_in_subtree(var.name, raw, waw, lst)
                    or is_func_arg(pet, var.name, loop)):
                if is_readonly(var.name, war, waw, rev_raw):
                    self.map_type_to.append(var.name)
                elif is_read_in_right_subtree(var.name, rev_raw, sub):
                    self.map_type_tofrom.append(var.name)
                elif is_written_in_subtree(var.name, raw, waw, sub):
                    self.map_type_alloc.append(var.name)
            elif is_first_written(var.name, raw, war, sub):
                # TODO simplify
                if is_read_in_subtree(var.name, rev_raw, rst):
                    self.map_type_from.append(var.name)
                else:
                    self.map_type_alloc.append(var.name)

    def setParentLoop(self, pl: str) -> None:
        """

        :param pl:
        :return:
        """
        self.parentLoop = pl

    def getNestedLoops(self, node_id: str) -> None:
        """

        :param node_id:
        :return:
        """
        # calculate the number of iterations of this loop relative to the top loop
        n = map_node(self.pet, node_id)

        # extend the string stream with this information and scan all child nodes to
        # identify and process further nested loops
        for cn_id in self.pet.direct_children(n):
            if cn_id.type == 2:  # type loop
                self.nestedLoops.add(cn_id.id)
                self.getNestedLoops(cn_id.id)

    def getNextLoop(self, node_id: str) -> None:
        """

        :param node_id:
        :return:
        """
        n = map_node(self.pet, node_id)
        endLine = 0
        for children in self.pet.direct_children(n):
            if children.end_line > endLine:
                endLine = children.end_line

    def setCollapseClause(self, node_id: str):
        """

        :param node_id:
        :return:
        """
        # calculate the number of iterations of this loop relative to the top loop
        n: CUNode = map_node(self.pet, node_id)

        for cn_id in self.pet.direct_children(n):
            if cn_id.type == 2:
                if cn_id.end_line == n.end_line:
                    self.collapse += 1
                    self.setCollapseClause(cn_id.id)

    def findMappedVar(self, direction: str, var: Variable) -> bool:
        """

        :param var:
        :param direction:
        :return:
        """
        if direction == "alloc":
            for v in self.map_type_alloc:
                if v == var:
                    return True
        elif direction == "to":
            for v in self.map_type_to:
                if v == var:
                    return True
        elif direction == "from":
            for v in self.map_type_from:
                if v == var:
                    return True
        elif direction == "tofrom":
            for v in self.map_type_tofrom:
                if v == var:
                    return True
        return False

    def printGPULoop(self) -> None:
        """

        :return:
        """
        print("#pragma omp target data ")
        print(self.node_id + " = " + self.start_line + " " + self.end_line)
        # long ll = determineLineNumber(firstGPULoop.getStartLine());
        print("map_type_alloc: ")
        for k in self.map_type_alloc:
            print("    " + k)
        print("map_type_to: ")
        for k in self.map_type_to:
            print("    " + k)
        print("map_type_from: ")
        for k in self.map_type_from:
            print("    " + k)
        print("map_type_tofrom: ")
        for k in self.map_type_tofrom:
            print("    " + k)

    def __add_sub_loops_rec(self, node_id: str, top_loop_iterations: long) -> str:
        """ This function adds information about the loop's child loops to the string
            stream 'ss'. This information contains the child loop's line number and
            its number of iterations divided by the number of iterations of the top loop.
            For each loop, the string is extended with " line_number iteration_count".

        :param node_id:
        :param top_loop_iterations:
        :return:
        """
        # calculate the number of iterations of this loop relative to the top loop
        n = map_node(self.pet, node_id)
        ll = n.start_line
        total_i = get_loop_iterations(str(n.start_line))
        i_cnt = 0 if top_loop_iterations == 0 else total_i / top_loop_iterations

        # extend the string stream with this information and scan all child nodes to
        # identify and process further nested loops
        ss: str = " " + str(ll) + "-" + i_cnt
        for cn_id in self.pet.direct_children(n):
            if cn_id.type == 2:
                ss += self.__add_sub_loops_rec(cn_id.id, top_loop_iterations)
        return ss