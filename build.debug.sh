#!/usr/bin/env sh

# -----------------------------------------------------------------------------
# Phase 1: Check script arguments

# Build script vars
COMMAND=$1
ACCEPTABLE_COMMANDS=("all" "app" "vendor")

print_usage() {
    echo ""
    echo "Use the following commands to build all or a portion of the project."
    echo "\tall    - (Re)Build all project components (the main app and vendored libraries)"
    echo "\tapp    - (Re)Build only the main app"
    echo "\tvendor - (Re)Build all or a specific vendor library"
    echo ""
    echo "Example usages:"
    echo "\t./build.debug.sh all"
    echo "\t./build.debug.sh app"
    echo "\t./build.debug.sh vendor"
    echo "\t./build.debug.sh vendor raylib"
}

if [[ ! "${ACCEPTABLE_COMMANDS[*]}" =~ "${COMMAND}" ]]; then
    echo "Invalid command given: ${COMMAND}"
    print_usage
    exit 1
fi

# Phase 1: Check script arguments
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Phase 2: Compile one or more components

# Tool vars
CC=cc
CPP=c++

# Program vars
EXE_NAME=jam-starter
GAME_LIB_NAME=jam-starter-game.dylib
BUILD_DIR=_build

# The following are relative to the build directory
SRC_DIR=../src
APP_SRC_DIR=${SRC_DIR}/code
VENDOR_SRC_DIR=${SRC_DIR}/vendor
ASSET_SRC_DIR=${SRC_DIR}/assets
RUNTIME_OUT_DIR=../app_runtime

# Compile options
INC_DIRS="-I ${VENDOR_SRC_DIR}/raylib/src"
LIBS="-ldl -framework CoreVideo -framework IOKit -framework Cocoa -framework GLUT -framework OpenGL ${VENDOR_SRC_DIR}/raylib/src/libraylib.a"

rm -fr ${BUILD_DIR}
mkdir -pv ${BUILD_DIR}
mkdir -pv ${RUNTIME_OUT_DIR}

pushd ${BUILD_DIR}

# Build game library
${CPP} -dynamiclib -std=c++14 ${INC_DIRS} ${LIBS} ${APP_SRC_DIR}/game.cpp -g -o ${GAME_LIB_NAME}

# Build platform layer
${CPP} -std=c++14 ${INC_DIRS} ${LIBS} ${APP_SRC_DIR}/main.cpp -g -o ${EXE_NAME}

popd

# Phase 2: Compile one or more components
# -----------------------------------------------------------------------------

