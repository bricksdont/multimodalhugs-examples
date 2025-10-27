#! /bin/bash

running_scripts=$(dirname "$0")
base=$running_scripts/../..
base=$(realpath $base)
scripts=$base/scripts

# set to "false" or "true":

dry_run="false"

# best hyperparams found so far

learning_rate="1e-5"
warmup_steps=500
label_smoothing_factor="0.1"
gradient_accumulation_steps=3

for model_name in phoenix_1 phoenix_2 phoenix_3; do

    . $scripts/running/run_generic.sh

done
