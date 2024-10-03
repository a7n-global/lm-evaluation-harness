

# lm_eval --model nemo_lm \
#     --model_args path=/mnt/project/llm/ckpt/experiments/xiaojian/llama3.1_8b_instruct \
#     --tasks mmlu,hellaswag,ifeval,gpqa,gsm8k \
#     --batch_size 32

export PYTHONPATH=$PYTHONPATH:/mnt/project/llm/users/xiaojian/code/lm-evaluation-harness

cd /mnt/project/llm/users/xiaojian/code/lm-evaluation-harness/
pip install -e .

pip install langdetect
pip install immutabledict
pip install nltk==3.9.1

# torchrun --nproc-per-node=8 \
#     --nnodes 1 \
#     --node_rank 0 \
#     --master_addr localhost \
#     --master_port 12345 \
#     /mnt/project/llm/users/xiaojian/code/lm-evaluation-harness/lm_eval/__main__.py \
#     --model nemo_lm \
#     --model_args path=/mnt/project/llm/ckpt/experiments/xiaojian/llama3.1_8b_instruct,devices=8,tensor_model_parallel_size=8,pipeline_model_parallel_size=1 \
#     --tasks mmlu,hellaswag,ifeval,gsm8k \
#     --batch_size 32 \
#     --output_path /mnt/project/llm/ckpt/experiments/xiaojian/llama3.1_8b_instruct/eval_results



        # --tasks mmlu,hellaswag,ifeval,gpqa,gsm8k \

torchrun --nproc-per-node=8 --no-python lm_eval \
    --model nemo_lm \
    --model_args path=/mnt/project/llm/ckpt/experiments/xiaojian/llama3.1_8b_instruct,devices=8,tensor_model_parallel_size=8,pipeline_model_parallel_size=1 \
    --tasks mmlu,hellaswag,ifeval,gsm8k \
    --batch_size 1 \
    --output_path /mnt/project/llm/ckpt/experiments/xiaojian/llama3.1_8b_instruct/eval_results
