#!/bin/bash

./enjoy-jsb.sh JSBSim-v0

./enjoy-jsb.sh JSBSim-v5 &
./enjoy-jsb.sh JSBSim-v6
wait 

./enjoy-jsb.sh JSBSim-v9 &
./enjoy-jsb.sh JSBSim-v13
wait

./enjoy-jsb.sh JSBSim-v14
./enjoy-jsb.sh JSBSim2D-v0
wait

./enjoy-jsb.sh JSBSim2D-v2 &
./enjoy-jsb.sh JSBSim2D-v4
wait

# ./enjoy-jsb.sh JSBSim2D-v1 &
