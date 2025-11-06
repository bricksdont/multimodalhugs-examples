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
    continue
    . $scripts/running/run_generic.sh

done

# one data worker only

dataloader_num_workers=1

for model_name in phoenix_1_workers_1 phoenix_2_workers_1 phoenix_3_workers_1; do
    continue
    . $scripts/running/run_generic.sh

done

# no fp16 training

dataloader_num_workers=2
fp16="false"

for model_name in phoenix_1_fp32 phoenix_2_fp32 phoenix_3_fp32; do
    continue
    . $scripts/running/run_generic.sh

done

# no fp16, single data worker

dataloader_num_workers=1
fp16="false"

for model_name in phoenix_1_fp32_workers_1 phoenix_2_fp32_workers_1 phoenix_3_fp32_workers_1; do

    . $scripts/running/run_generic.sh

done
