##!/usr/bin/env bash
#
##SBATCH --job-name=eval
##SBATCH --mail-user=sachdeva@ukp.informatik.tu-darmstadt.de
##SBATCH --output=/ukp-storage-1/sachdeva/job-%j
##SBATCH --mail-type=ALL
##SBATCH --time=72:00:00
##SBATCH --partition=ukp
##SBATCH --cpus-per-task=4
##SBATCH --ntasks=1
##SBATCH --mem=32GB
##SBATCH --gres=gpu:1
##SBATCH --constraint="gpu_mem:32gb"
#
#if [ -f .env ]; then
#  export $(echo $(cat .env | sed 's/#.*//g'| xargs) | envsubst)
#fi

BASE_PATH="/storage/ukp/work/sachdeva/research_projects/exp_calibration/src"

# List of model names
models=(
"roberta-squad-llama2-gpt-jt-cfs-seed-42" \
"roberta-squad-llama2-llama-13b-cfs-seed-42" \
"roberta-squad-llama2-gpt-neox-cfs-seed-42" \
"roberta-squad-llama2-flan-ul2-cfs-seed-42" \
)

# Loop through the model names
for MODEL_NAME in "${models[@]}"
do
    echo "Running inference for model: ${MODEL_NAME}"
    CUDA_LAUNCH_BLOCKING=1 python3 ${BASE_PATH}/calibration/baseline/inference.py --model_name "${MODEL_NAME}" --dataset "squad_adversarial"
    CUDA_LAUNCH_BLOCKING=1 python3 ${BASE_PATH}/calibration/baseline/inference.py --model_name "${MODEL_NAME}" --dataset "trivia_qa"
    CUDA_LAUNCH_BLOCKING=1 python3 ${BASE_PATH}/calibration/baseline/inference.py --model_name "${MODEL_NAME}" --dataset "hotpot_qa"

    echo "Finished inference for model: ${MODEL_NAME}"
done