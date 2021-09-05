#!/bin/bash
# Argument #1: Environment-Name
if [[ $# -eq 1 ]]
then
   python3 enjoy2.py --algo sac --env $1 --folder rl-trained-agents/ -n 100000 --tensorboard-log logs_enjoy --render-mode=episode --env-kwargs render_before_reset:True
elif [[ $# -eq 2 ]]
then
   python3 enjoy2.py --algo sac --env $1 --folder $2 -n 100000 --tensorboard-log logs_enjoy --render-mode=episode --env-kwargs render_before_reset:True
elif [[ $# -eq 3 ]]
then
   python3 enjoy2.py --algo sac --env $1 --folder $2 --exp-id $3 -n 100000 --tensorboard-log logs_enjoy --render-mode=episode --env-kwargs render_before_reset:True
else
  echo Usage:
  echo enjoy-jsb.sh envName
  echo enjoy-jsb.sh envName trainedAgentFolder
  echo enjoy-jsb.sh envName trainedAgentFolder experimentId
fi
