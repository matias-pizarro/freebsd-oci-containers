#!/bin/sh

cd $(dirname $(dirname "$0"))

find $(pwd) -name run.sh -depth 3 -exec {} \;
