#!/usr/bin/env bash

GCC_REL=9.2-2019.12
SOURCES=$(find $(git rev-parse --show-toplevel) | egrep "\.(cpp|h)\$" | egrep -v "gcc-arm-${GCC_REL}-x86_64-aarch64-none-linux-gnu|gcc-arm-${GCC_REL}-x86_64-arm-none-linux-gnueabihf")

set -x

for file in ${SOURCES};
do
    clang-format-6.0 ${file} > expected-format
    diff -u -p --label="${file}" --label="expected coding style" ${file} expected-format
done
exit $(clang-format-6.0 --output-replacements-xml ${SOURCES} | egrep -c "</replacement>")
