#!/bin/bash

./enjoy-jsb.sh JSBSimv5_1_25seconds-v1 logs 1 &
./enjoy-jsb.sh JSBSimv5_2_5seconds-v1 logs 1
wait
./enjoy-jsb.sh JSBSimv5_10seconds-v1 logs 1 &
# ./enjoy-jsb.sh JSBSimv5_20seconds-v1 logs 1
./enjoy-jsb.sh JSBSimv5_vartime-v3 logs 1
wait
./enjoy-jsb.sh JSBSimv6_1_25seconds-v0 logs 1 &
./enjoy-jsb.sh JSBSimv6_2_5seconds-v0 logs 1
wait
./enjoy-jsb.sh JSBSimv6_10seconds-v0 logs 1
# ./enjoy-jsb.sh JSBSimv6_20seconds-v0 logs
./enjoy-jsb.sh JSBSimv6_vartime-v0 logs 1
wait
