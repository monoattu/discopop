from typing import List, Tuple, Optional, cast

from discopop_explorer import PETGraphX
from discopop_explorer.PETGraphX import EdgeType as PETEdgeType, DepType
from discopop_validation.data_race_prediction.behavior_modeller.classes.Operation import Operation
from discopop_validation.data_race_prediction.behavior_modeller.classes.OperationModifierType import \
    OperationModifierType
from discopop_validation.data_race_prediction.parallel_construct_graph.classes.PCGraph import PCGraph
from discopop_validation.data_race_prediction.utils import get_pet_node_id_from_source_code_lines
from discopop_validation.memory_access_graph.AccessMetaData import AccessMetaData
from discopop_validation.memory_access_graph.MAGDataRace import MAGDataRace
from discopop_validation.memory_access_graph.MemoryAccessGraph import MemoryAccessGraph


def detect_data_races(ma_graph: MemoryAccessGraph, pc_graph: PCGraph, pet: PETGraphX) -> List[MAGDataRace]:
    """starts the detection of data races for each node of the graph"""
    if ma_graph.run_configuration.verbose_mode:
        print("#########")
        print("Detecting data races...")
        print("#########")
    data_races: List[MAGDataRace] = []
    # start data race detection for each node in the graph
    for node in ma_graph.graph.nodes:
        # get the set of incoming access edges for node
        incoming_accesses = ma_graph.graph.in_edges(node, keys=True)
        # create all possible pairs of incoming edges
        incoming_edge_pairs = ((i, j) for i in incoming_accesses for j in incoming_accesses if i != j)
        # check each pair for present data races
        for edge_1, edge_2 in incoming_edge_pairs:
            optional_data_race = __data_race_in_edge_pair(ma_graph, node, edge_1, edge_2, pc_graph, pet)
            if optional_data_race is not None:
                data_race_object = cast(MAGDataRace, optional_data_race)
                data_races.append(data_race_object)
    return data_races


def print_data_races(data_races: List[MAGDataRace], ma_graph: MemoryAccessGraph):
    buffer: List[MAGDataRace] = []
    print("### Detected data races: ###")
    for data_race in data_races:
        if data_race in buffer:
            # do not print duplicates
            continue
        print(data_race.operation_1, data_race.parent_node_id)
        print(data_race.operation_2, data_race.parent_node_id)
        if data_race.is_weak:
            print("\t==> Weak")
        print()
        buffer.append(data_race)


def __data_race_in_edge_pair(ma_graph: MemoryAccessGraph, ma_node, edge_1: Tuple[str, str, int], edge_2: Tuple[str, str, int], pc_graph: PCGraph,
                             pet: PETGraphX) -> Optional[MAGDataRace]:
    """checks the given pair of edges for data races.
    Returns True, if a data race has been found.
    Else, returns False.
    """
    # retrieve AccessMetaData objects of edges
    amd_1: AccessMetaData = ma_graph.graph.edges[edge_1]["data"]
    amd_2: AccessMetaData = ma_graph.graph.edges[edge_2]["data"]


    # requirement 1: both accesses happen within the same parallel unit
    # todo might require: both accesses happen within nested parallel units
    if amd_1.parallel_unit != amd_2.parallel_unit:
        return None

    # requirement 2: at least of the accesses must be a write
    if (not amd_1.access_mode == "w") and (not amd_2.access_mode == "w"):
        return None

    # requirement 3: edge_1 not a predecessor of edge_2 or vice-versa
    if __path_predecessor_relation_exists(amd_1.operation_path_id, amd_2.operation_path_id):
        # predecessor relation exists
        return None

    # requirement 4: check for PCGraph predecessor relations
    if __pcgraph_predecessor_relation(amd_1, amd_2, pc_graph):
        return None

    # requirement 5: check if the identified data race is backed up by a dependency edge in the PET Graph
    is_weak_data_race = False
    if not __pet_dependency_edge_exists(amd_1, amd_2, pet):
        is_weak_data_race = True

    # requirement 6: ignore data race if it originates from a reduction operation
    if __originate_from_reduction_operation(amd_1, amd_2):
        return None

    # requirement 7: ignore data race if at least one access originates from a critical section
    if __originate_from_critical_section(amd_1, amd_2):
        return None

    op_1: Operation = ma_graph.graph.edges[edge_1]["data"].operation
    op_2: Operation = ma_graph.graph.edges[edge_2]["data"].operation
    data_race_object = MAGDataRace(ma_node, op_1, op_2, is_weak_data_race)
    return data_race_object


def __path_predecessor_relation_exists(path_1: List[int], path_2: List[int]) -> bool:
    """checks whether a predecessor relation between path_1 and path_2 exists.
    The check considers both orderings.
    Returns True, if a predecessor relation exists.
    Returns False, otherwise."""

    def check_precedence(inner_path_1: List[int], inner_path_2: List[int]) -> bool:
        for idx, elem in enumerate(inner_path_1):
            if idx == len(inner_path_1) - 1:
                # last element of the list
                # the last element of the list is the only one which may not be matching -> no check required
                return True
            else:
                # regular list element

                # check if element with index idx exists in inner_path_2.
                # If not, inner_path_2 is a predecessor of inner_path_1
                if idx > len(inner_path_2):
                    return True

                # check if elements at index idx in both lists are equivalent
                if inner_path_1[idx] != inner_path_2[idx]:
                    return False

    # consider both potential precedence relations
    if check_precedence(path_1, path_2) or check_precedence(path_2, path_1):
        return True
    return False


def __pcgraph_predecessor_relation(amd_1: AccessMetaData, amd_2: AccessMetaData, pc_graph: PCGraph):
    """Check if a Taskwait or Barrier is encountered on the path from amd_1.origin_bhv_node
    to amd_2.origin_bhv_node or vice versa.
    Returns True, if a Taskwait or Barrier lies between both origin_bhv_nodes.
    Reutrns False, else
    """
    # check both directions
    result = False
    result = result or pc_graph.is_successor_with_encountered_barrier_or_taskwait(amd_1.origin_bhv_node.node_id,
                                                                                  amd_2.origin_bhv_node.node_id)

    result = result or pc_graph.is_successor_with_encountered_barrier_or_taskwait(amd_2.origin_bhv_node.node_id,
                                                                                  amd_1.origin_bhv_node.node_id)
    return result


def __pet_dependency_edge_exists(amd_1: AccessMetaData, amd_2: AccessMetaData, pet: PETGraphX):
    """
    Checks if the supposed data race is backed up by a corresponding dependency edge in the PET graph.
    """
    pet_node_id_amd_1 = get_pet_node_id_from_source_code_lines(pet, int(amd_1.operation.file_id),
                                                               amd_1.operation.line, amd_1.operation.line)
    pet_node_id_amd_2 = get_pet_node_id_from_source_code_lines(pet, int(amd_2.operation.file_id),
                                                               amd_2.operation.line, amd_2.operation.line)
    out_dependencies_node_1 = pet.out_edges(pet_node_id_amd_1, PETEdgeType.DATA)
    # filter dependencies, only conserve dependencies from pet_node_id_amd_1 to pet_node_id_amd_2
    dependencies_1_2 = [dep for dep in out_dependencies_node_1 if
                        dep[0] == pet_node_id_amd_1 and dep[1] == pet_node_id_amd_2]

    out_dependencies_node_2 = pet.out_edges(pet_node_id_amd_2, PETEdgeType.DATA)
    # filter dependencies, only conserve dependencies from pet_node_id_amd_2 to pet_node_id_amd_1
    dependencies_2_1 = [dep for dep in out_dependencies_node_2 if
                        dep[0] == pet_node_id_amd_2 and dep[1] == pet_node_id_amd_1]

    # combine sets of dependencies
    dependencies = dependencies_1_2
    dependencies += [dep for dep in dependencies_2_1 if dep not in dependencies]

    # ignore INIT type dependencies
    dependencies = [dep for dep in dependencies if dep[2].dtype != DepType.INIT]

    # filter dependencies for variables used in amd_1 and amd_2
    dependencies = [dep for dep in dependencies if
                    dep[2].var_name in [amd_1.operation.target_name, amd_2.operation.target_name]]

    # if the set of dependencies is not empty, a real dependency exists and thus a potential data race
    if len(dependencies) > 0:
        # ==> potential data race backed up by dependency edge
        return True

    return False


def __originate_from_reduction_operation(amd_1: AccessMetaData, amd_2: AccessMetaData):
    """Check whether both accesses originate from the same reduction operation."""
    op_1_modifiers = amd_1.operation.modifiers
    op_2_modifiers = amd_2.operation.modifiers
    # determine overlapping modifiers
    overlapping_modifiers = [modifier for modifier in op_1_modifiers if modifier in op_2_modifiers]
    # check for reduction modifiers. Key can be ignored
    for modifier_type, _ in overlapping_modifiers:
        if modifier_type == OperationModifierType.REDUCTION_OPERATION:
            return True
    return False


def __originate_from_critical_section(amd_1: AccessMetaData, amd_2: AccessMetaData):
    """Check whether at least one access originates from a critical section"""
    # check if amd_1 or amd_2 is contained in a critical section
    for modifier, _ in amd_1.operation.modifiers + amd_2.operation.modifiers:
        if modifier == OperationModifierType.CRITICAL_SECTION_OPERATION:
            return True
    return False


