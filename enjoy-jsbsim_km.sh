#!/bin/bash

./enjoy-jsb.sh JSBSimv6_10km-v0 logs 1 &
./enjoy-jsb.sh JSBSimv6_20km-v0 logs 1
wait
./enjoy-jsb.sh JSBSimv6_40km-v0 logs 1
