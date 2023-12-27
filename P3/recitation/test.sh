#!/bin/bash

for ((u = 10; u <= 10000000; u *= 10)); do
  for ((n = 10; n <= 100000000; n *= 10)); do
    
    valgrind_cmd="valgrind --tool=cachegrind --branch-sim=yes ./sum $u $n"

    
    $valgrind_cmd 2>&1 | tee temp_result.txt

    
    echo "U: $u" >> result_u.txt
    echo "N: $n" >> result_u.txt
    sed -n '22p' temp_result.txt >> result_u.txt
    sed -n '23p' temp_result.txt >> result_u.txt
    echo -e "\n " >> result_u.txt

    rm temp_result.txt
  done
done
