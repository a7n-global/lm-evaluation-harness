

# lm_eval --model nemo_lm \
#     --model_args path=/mnt/project/llm/ckpt/experiments/xiaojian/llama3.1_8b_instruct \
#     --tasks mmlu,hellaswag,ifeval,gpqa,gsm8k \
#     --batch_size 32


# export PYTHONPATH=$PYTHONPATH:/mnt/project/llm/users/xiaojian/code/lm-evaluation-harness

cd ~
pwd
cp -r /mnt/project/llm/users/xiaojian/code/lm-evaluation-harness lm-evaluation-harness
ls
cd lm-evaluation-harness
ls
pip install -e .
export PATH=$PATH:/mnt/project/llm/users/xiaojian/packages

echo "gpu num: $PET_NPROC_PER_NODE"
echo "node num: $PET_NNODES"
echo "process num: $(expr ${PET_NNODES} \* ${PET_NPROC_PER_NODE})"
echo "rank: $PET_NODE_RANK"

pip install langdetect
pip install immutabledict
pip install nltk==3.9.1


# 定义参数
# nproc_per_node=$PET_NPROC_PER_NODE
# nnodes=$PET_NNODES
# node_rank=$PET_NODE_RANK
# master_addr=$PET_MASTER_ADDR
# master_port=$PET_MASTER_PORT
# trainer_num_nodes=$PET_NNODES
# pipeline_model_parallel_size=$PET_NNODES
# batch_size=4

# export these two parameters
# param_pipeline_parallel_size
# param_batch_size
# param_model_path
# param_output_path

# torchrun --nproc_per_node=$nproc_per_node \
#     --nnodes=$nnodes \
#     --node_rank=$node_rank \
#     --master_addr=$master_addr \
#     --master_port=$master_port lm_eval \
#     --model nemo_lm \
#     --model_args path=$param_model_path,devices=8,tensor_model_parallel_size=8,pipeline_model_parallel_size=$pipeline_model_parallel_size \
#     --tasks mmlu,hellaswag,ifeval,gsm8k \
#     --batch_size $param_batch_size \
#     --output_path $param_output_path



torchrun --nproc_per_node=8 --no-python lm_eval\
    --model nemo_lm \
    --model_args path=$param_model_path,devices=8,tensor_model_parallel_size=8,pipeline_model_parallel_size=$param_pipeline_parallel_size \
    --tasks mmlu,hellaswag,ifeval,gsm8k \
    --batch_size $param_batch_size \
    --output_path $param_output_path