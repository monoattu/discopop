# This file is part of the DiscoPoP software (http://www.discopop.tu-darmstadt.de)
#
# Copyright (c) 2020, Technische Universitaet Darmstadt, Germany
#
# This software may be modified and distributed under the terms of
# the 3-Clause BSD License.  See the LICENSE file in the package base
# directory for details.

"""Discopop analyzer

Usage:
    graph_analyzer.py [--path <path>] [--cu-xml <cuxml>] [--dep-file <depfile>] [--plugins <plugs>] \
[--loop-counter <loopcount>] [--reduction <reduction>] [--json <json_out>] [--fmap <fmap>]

Options:
    --path=<path>               Directory with input data [default: ./]
    --cu-xml=<cuxml>            CU node xml file [default: Data.xml]
    --dep-file=<depfile>        Dependencies text file [default: dp_run_dep.txt]
    --loop-counter=<loopcount>  Loop counter data [default: loop_counter_output.txt]
    --reduction=<reduction>     Reduction variables file [default: reduction.txt]
    --fmap=<fmap>               File mapping [default: FileMapping.txt]
    --json=<json_out>           Json output
    --plugins=<plugs>           Plugins to execute
    -h --help                   Show this screen
    -v --version                Show version
"""
import json
import os
import sys
import time
from typing import List

from docopt import docopt
from pluginbase import PluginBase
from schema import Schema, Use, SchemaError

from PETGraphX import PETGraphX
from json_serializer import PatternInfoSerializer
from parser import parse_inputs
from pattern_detection import DetectionResult, PatternDetectorX

docopt_schema = Schema({
    '--path': Use(str),
    '--cu-xml': Use(str),
    '--dep-file': Use(str),
    '--loop-counter': Use(str),
    '--reduction': Use(str),
    '--fmap': Use(str),
    '--plugins': Use(str),
    '--json': Use(str),
})


def get_path(base_path: str, file_name: str) -> str:
    """Combines path and filename if it is not absolute

    :param base_path: path
    :param file_name: file name
    :return: path to file
    """
    return file_name if os.path.isabs(file_name) else os.path.join(base_path, file_name)


def run(cu_xml: str, dep_file: str, loop_counter_file: str, reduction_file: str, plugins: List[str]) \
        -> DetectionResult:
    cu_dict, dependencies, loop_data, reduction_vars = parse_inputs(cu_xml, dep_file,
                                                                    loop_counter_file, reduction_file)

    pet = PETGraphX(cu_dict, dependencies, loop_data, reduction_vars)
    # TODO add visualization
    # pet.show()

    plugin_base = PluginBase(package='plugins')

    plugin_source = plugin_base.make_plugin_source(
        searchpath=['./plugins'])

    for plugin_name in plugins:
        p = plugin_source.load_plugin(plugin_name)
        print("executing plugin before: " + plugin_name)
        pet = p.run_before(pet)

    pattern_detector = PatternDetectorX(pet)

    res: DetectionResult = pattern_detector.detect_patterns()

    for plugin_name in plugins:
        p = plugin_source.load_plugin(plugin_name)
        print("executing plugin after: " + plugin_name)
        pet = p.run_after(pet)

    return res


if __name__ == "__main__":
    arguments = docopt(__doc__, version='DiscoPoP analyzer 0.1')

    try:
        arguments = docopt_schema.validate(arguments)
    except SchemaError as e:
        exit(e)

    path = arguments['--path']

    cu_xml = get_path(path, arguments['--cu-xml'])
    dep_file = get_path(path, arguments['--dep-file'])
    loop_counter_file = get_path(path, arguments['--loop-counter'])
    reduction_file = get_path(path, arguments['--reduction'])
    file_mapping = get_path(path, 'FileMapping.txt')

    for file in [cu_xml, dep_file, loop_counter_file, reduction_file]:
        if not os.path.isfile(file):
            print(f"File not found: \"{file}\"")
            sys.exit()

    plugins = [] if arguments['--plugins'] == 'None' else arguments['--plugins'].split(' ')

    start = time.time()

    res = run(cu_xml, dep_file, loop_counter_file, reduction_file, plugins)

    end = time.time()

    if arguments['--json'] == 'None':
        print(str(res))
    else:
        with open(arguments['--json'], 'w') as f:
            json.dump(res, f, indent=2, cls=PatternInfoSerializer)

    print("Time taken for pattern detection: {0}".format(end - start))