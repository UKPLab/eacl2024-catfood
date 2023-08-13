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
#"roberta-squad-t5-squad-cfs-seed-42" \
#"roberta-squad-t5-squad-cfs-seed-0" \
#"roberta-squad-t5-squad-cfs-seed-1" \
#"roberta-squad-gpt-jt-context-rel-seed-42" \
#"roberta-squad-gpt-jt-context-rel-seed-0" \
#"roberta-squad-gpt-jt-context-rel-seed-1" \
#"roberta-squad-gpt-neox-context-rel-seed-42" \
#"roberta-squad-gpt-neox-context-rel-seed-0" \
#"roberta-squad-gpt-neox-context-rel-seed-1" \
#"roberta-squad-llama-context-rel-seed-42" \
#"roberta-squad-llama-context-rel-seed-0" \
#"roberta-squad-llama-context-rel-seed-1" \
#"roberta-squad-alpaca-context-rel-seed-42" \
#"roberta-squad-alpaca-context-rel-seed-0" \
#"roberta-squad-alpaca-context-rel-seed-1" \
#"roberta-squad-flan-ul2-context-rel-noise-seed-42" \
#"roberta-squad-flan-ul2-context-rel-noise-seed-0" \
#"roberta-squad-flan-ul2-context-rel-noise-seed-1" \
#"roberta-squad-flan-t5-xxl-cn-filtered-cfs-seed-42" \
#"roberta-squad-flan-t5-xxl-cn-filtered-cfs-seed-0" \
#"roberta-squad-flan-t5-xxl-cn-filtered-cfs-seed-1" \
#"roberta-squad"  \
"roberta-squad-t5-squad-cfs-easy-seed-42" \
"roberta-squad-t5-squad-cfs-easy-seed-0" \
"roberta-squad-t5-squad-cfs-easy-seed-1" \
"roberta-squad-t5-squad-cfs-amb-seed-42" \
"roberta-squad-t5-squad-cfs-amb-seed-0" \
"roberta-squad-t5-squad-cfs-amb-seed-1" \
"roberta-squad-t5-squad-cfs-hard-seed-42" \
"roberta-squad-t5-squad-cfs-hard-seed-0" \
"roberta-squad-t5-squad-cfs-hard-seed-1" \
)

# Loop through the model names
for MODEL_NAME in "${models[@]}"
do
    echo "Running inference for model: ${MODEL_NAME}"

#    CUDA_LAUNCH_BLOCKING=1 python3 ${BASE_PATH}/shortcuts/inference.py --model_name "${MODEL_NAME}" --dataset "squad"
#    CUDA_LAUNCH_BLOCKING=1 python3 ${BASE_PATH}/shortcuts/inference.py --model_name "${MODEL_NAME}" --dataset "squad_adversarial"
#    CUDA_LAUNCH_BLOCKING=1 python3 ${BASE_PATH}/shortcuts/inference.py --model_name "${MODEL_NAME}" --dataset "trivia_qa"
#    CUDA_LAUNCH_BLOCKING=1 python3 ${BASE_PATH}/shortcuts/inference.py --model_name "${MODEL_NAME}" --dataset "hotpot_qa"
    CUDA_LAUNCH_BLOCKING=1 python3 ${BASE_PATH}/shortcuts/inference.py --model_name "${MODEL_NAME}" --dataset "news_qa"
#    CUDA_LAUNCH_BLOCKING=1 python3 ${BASE_PATH}/shortcuts/inference.py --model_name "${MODEL_NAME}" --dataset "natural_questions"
#    CUDA_LAUNCH_BLOCKING=1 python3 ${BASE_PATH}/shortcuts/inference.py --model_name "${MODEL_NAME}" --dataset "bioasq"

    echo "Finished inference for model: ${MODEL_NAME}"
done


#python ${BASE_PATH}/faithfulness.py --metric comp --model_name roberta-squad-flan-ul2-context-rel-noise-seed-42 --model_type flan_ul2_context_noise_rel --dataset trivia_qa
#python ${BASE_PATH}/faithfulness.py --metric comp --model_name roberta-squad-gpt-neox-context-rel-seed-42 --model_type gpt_neox_context_rel --dataset trivia_qa
#python ${BASE_PATH}/faithfulness.py --metric comp --model_name roberta-squad-llama-context-rel-seed-42 --model_type llama_context_rel --dataset trivia_qa
#python ${BASE_PATH}/faithfulness.py --metric comp --model_name roberta-squad-t5-squad-cfs-seed-42 --model_type rag --dataset trivia_qa
#python ${BASE_PATH}/faithfulness.py --metric comp --model_name roberta-squad --model_type base --dataset trivia_qa

#python ${BASE_PATH}/faithfulness_2.py --metric suff --model_name roberta-squad-flan-ul2-context-rel-noise-seed-42 --model_type flan_ul2_context_noise_rel --dataset trivia_qa
#python ${BASE_PATH}/faithfulness_2.py --metric suff --model_name roberta-squad-t5-squad-cfs-seed-42 --model_type rag --dataset trivia_qa

#python ${BASE_PATH}/faithfulness.py --metric suff --model_name roberta-squad-flan-ul2-context-rel-noise-seed-42 --model_type flan_ul2_context_noise_rel --dataset hotpot_qa
#python ${BASE_PATH}/faithfulness.py --metric suff --model_name roberta-squad-gpt-neox-context-rel-seed-42 --model_type gpt_neox_context_rel --dataset hotpot_qa
#python ${BASE_PATH}/faithfulness.py --metric suff --model_name roberta-squad-llama-context-rel-seed-42 --model_type llama_context_rel --dataset hotpot_qa
#python ${BASE_PATH}/faithfulness.py --metric suff --model_name roberta-squad-t5-squad-cfs-seed-42 --model_type rag --dataset hotpot_qa
#python ${BASE_PATH}/faithfulness.py --metric suff --model_name roberta-squad --model_type base --dataset hotpot_qa

#python ${BASE_PATH}/faithfulness_2.py --metric suff --model_name roberta-squad-flan-ul2-context-rel-noise-seed-42 --model_type flan_ul2_context_noise_rel --dataset trivia_qa
#python ${BASE_PATH}/faithfulness_2.py --metric suff --model_name roberta-squad-gpt-neox-context-rel-seed-42 --model_type gpt_neox_context_rel --dataset trivia_qa
#python ${BASE_PATH}/faithfulness_2.py --metric suff --model_name roberta-squad-llama-context-rel-seed-42 --model_type llama_context_rel --dataset trivia_qa
#python ${BASE_PATH}/faithfulness_2.py --metric suff --model_name roberta-squad-t5-squad-cfs-seed-42 --model_type rag --dataset trivia_qa
#python ${BASE_PATH}/faithfulness_2.py --metric suff --model_name roberta-squad --model_type base --dataset trivia_qa
