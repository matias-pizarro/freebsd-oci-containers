#!/bin/sh

cd $(dirname $(dirname "$0"))

stop_test_container() {
    echo ${1}
}

find $(pwd) -name run.sh -depth 3 -exec \
    egrep '^JAIL_NAME' {} \
\;

run_files=$(find $(pwd) -name run.sh -depth 3 -print)
find $(pwd) -name run.sh -depth 3 -print # | awk -F '=' 'aa{print $2}bb' 
# for run_file in "${run_files}"; do
#     echo "aa${run_file}bb"
# done
