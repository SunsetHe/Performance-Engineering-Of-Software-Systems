#!/bin/bash

echo
echo start: $(date "+%y%m%d.%H%M%S.%3N")
echo

# TODO list
source /opt/intel/oneapi/setvars.sh > /dev/null 2>&1
dpcpp gemm_basic.cpp -o gemm_basic
if [ $? -eq 0 ]; then ./gemm_basic; fi

echo
echo stop:  $(date "+%y%m%d.%H%M%S.%3N")
echo
