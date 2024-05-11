#!/bin/bash

PARAM_NAME=$1
COMPILE="/* gcc -std=c99 -c -g -O0 -pedantic -Wall -Wextra -Wshadow ${PARAM_NAME} */"
LINKER="/* gcc ${PARAM_NAME:0:-2}.o -o program -lm */"


awk 'NR==1 {print "'"${COMPILE}"'"; print "'"${LINKER}"'"} {print}' "${PARAM_NAME}" \
	> temp && mv -v temp "${PARAM_NAME}"

echo
echo -e "Changes written to the head of the file: ${PARAM_NAME}"
echo -e "Compile command:\n${COMPILE}"
echo -e "Linker command:\n${LINKER}\n"


#eval "awk 'NR==1 {print \"${COMPILE}\"; print \"${LINKER}\"} {print}' $PARAM_NAME"

