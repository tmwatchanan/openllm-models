
CONSTANT_YAML = '''
alias:
- latest
- 3.8b
- instruct
- mini
engine_config:
  dtype: half
  max_model_len: 4096
  model: microsoft/Phi-3-mini-4k-instruct
project: vllm-chat
prompt:
  body: '<|user|>

    {user_prompt}<|end|>

    <|assistant|>'
  head: null
service_config:
  name: phi3
  resources:
    gpu: 1
    gpu_type: nvidia-tesla-t4
  traffic:
    timeout: 300

'''
