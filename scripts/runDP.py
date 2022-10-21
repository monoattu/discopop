# This file is part of the DiscoPoP software (http://www.discopop.tu-darmstadt.de)
#
# Copyright (c) 2020, Technische Universitaet Darmstadt, Germany
#
# This software may be modified and distributed under the terms of
# the 3-Clause BSD License. See the LICENSE file in the package base
# directory for details.

# author: Bertin Görlich,  Oktober 2022
# description:
#   This tool can be used to apply the discopop toolchain on a custom project.
#   Under the hood it uses gllvm to create a single-file bitcode representation of the project
#   Then we run discopop passes and instrumentation on it.
#   After that the discopop profiler is used to generate parallelization suggestions.


import argparse
from enum import Enum
import logging
import os
import subprocess
import sys

# TODO reduce amount of needed parameters
#   automatically detect as much as possible (go installation, gllvm installation, llvm installation, type of project, ...)
#   allow environment variables / config file

parser = argparse.ArgumentParser(description=
'''
This tool runs the DiscoPoP Toolchain for you.
''', formatter_class=argparse.RawDescriptionHelpFormatter)

parser.add_argument("--llvm_dir", metavar="<path>", required=True, help="path/to/llvm/build/bin")
parser.add_argument("--project_dir", metavar="<path>", required=True, help="path/to/project/source")
parser.add_argument("--project_configuration", metavar="<string>", required=True, help="used for the configure / cmake commands")
parser.add_argument("--project_libraries", metavar="<string>", required=True, help="we append these flags during linking to include libraries needed by your project")
parser.add_argument("--project_executable_name", metavar="<name>", required=True, help="name of the created executable")
parser.add_argument("--project_executable_arguments", metavar="<string>", required=True, help="run the executable with these arguments for instrumentation")

args = parser.parse_args()

class BuildType(Enum):
    CMake = 1
    Make = 2
    Autotools = 3

class config:
    project=args.project_dir

    # TODO: optional arguments, for now lets keep it simple
    cleanBuild=True
    installDeps=False
    buildType=BuildType.Autotools

    # TODO read LLVM_DIST_PATH of discopop build 
    llvm=args.llvm_dir


# exit if go is not installed
if os.path.exists("/usr/local/go/bin/go"):
    logging.debug("found go installation")
else:
    if config.installDeps:
        logging.info("installing go..."); sys.exit() # TODO
    else:
        logging.error("no working go installation found, please install go and gllvm before continuing")
        sys.exit()

# exit if gllvm is not installed
# go installs packages under $GOPATH or $HOME/go
if ("GOPATH" in os.environ and os.path.exists(os.environ("GOPATH") + "/bin/gclang") or
        os.path.exists(os.environ("HOME") + "/go/bin/gclang")):
    logging.debug("gllvm found")
else:
    if config.installDeps:
        logging.info("installing gllvm...")
    logging.error("gllvm not found, please install gllvm before continuing")
    sys.exit()

# clean build
if config.cleanBuild:
    if config.buildType is BuildType.Autotools:
        subprocess.run(["rm", "-rf", config.project + "/build"])
        subprocess.run(["mkdir", config.project + "/build"])
    elif config.buildType is BuildType.Make:
        pass # TODO
    elif config.buildType is BuildType.CMake:
        pass # TODO
    else:
        logging.warn("unknown build type")


# configure gllvm
os.environ["LLVM_COMPILER_PATH"] = config.llvm
os.environ["WLLVM_OUTPUT_LEVEL"] = "AUDIT"
os.environ["WLLVM_OUTPUT_FILE"] = config.project +"/build"

