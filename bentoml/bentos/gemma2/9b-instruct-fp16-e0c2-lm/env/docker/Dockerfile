# ===========================================
#
# THIS IS A GENERATED DOCKERFILE. DO NOT EDIT
#
# ===========================================

# Block SETUP_BENTO_BASE_IMAGE
FROM python:3.11-slim AS base-container

ENV LANG=C.UTF-8

ENV LC_ALL=C.UTF-8

ENV PYTHONIOENCODING=UTF-8

ENV PYTHONUNBUFFERED=1

<<<<<<<< HEAD:bentoml/bentos/gemma2/9b-instruct-fp16-e0c2-lm/env/docker/Dockerfile


USER root

ENV DEBIAN_FRONTEND=noninteractive
RUN rm -f /etc/apt/apt.conf.d/docker-clean; echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
RUN set -eux && \
    apt-get update -y && \
    apt-get install -q -y --no-install-recommends --allow-remove-essential \
        ca-certificates gnupg2 bash build-essential curl 
ENV UV_SYSTEM_PYTHON=1
RUN curl -LO https://astral.sh/uv/install.sh && \
    sh install.sh && rm install.sh && mv $HOME/.cargo/bin/uv /usr/local/bin/

# Block SETUP_BENTO_USER
|||||||| 5faca8d8:bentoml/bentos/gemma2/27b-instruct-fp16-376d/env/docker/Dockerfile


USER root

ENV DEBIAN_FRONTEND=noninteractive
RUN rm -f /etc/apt/apt.conf.d/docker-clean; echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
RUN set -eux && \
    apt-get update -y && \
    apt-get install -q -y --no-install-recommends --allow-remove-essential \
        ca-certificates gnupg2 bash build-essential curl 
ENV UV_SYSTEM_PYTHON=1
RUN curl -LO https://astral.sh/uv/install.sh && \
    sh install.sh && rm install.sh && mv $HOME/.local/bin/uv /usr/local/bin/

# Block SETUP_BENTO_USER
========
>>>>>>>> bento/feat/support-gemma-3:bentoml/bentos/llama3.2/1b-instruct-a0b9/env/docker/Dockerfile
ARG BENTO_USER=bentoml
ARG BENTO_USER_UID=1034
ARG BENTO_USER_GID=1034
RUN groupadd -g $BENTO_USER_GID -o $BENTO_USER && useradd -m -u $BENTO_USER_UID -g $BENTO_USER_GID -o -r $BENTO_USER


ARG BENTO_PATH=/home/bentoml/bento
ENV BENTO_PATH=$BENTO_PATH
ENV BENTOML_HOME=/home/bentoml/
ENV BENTOML_HF_CACHE_DIR=/home/bentoml/bento/hf-models
ENV BENTOML_CONTAINERIZED=true

ARG HF_TOKEN
ENV HF_TOKEN=$HF_TOKEN
ARG UV_NO_PROGRESS=1
ENV UV_NO_PROGRESS=$UV_NO_PROGRESS
ARG HF_HUB_DISABLE_PROGRESS_BARS=1
ENV HF_HUB_DISABLE_PROGRESS_BARS=$HF_HUB_DISABLE_PROGRESS_BARS
ARG VLLM_LOGGING_CONFIG_PATH=/tmp/tmpebdpbhge/logging-config.json
ENV VLLM_LOGGING_CONFIG_PATH=$VLLM_LOGGING_CONFIG_PATH

RUN mkdir $BENTO_PATH && chown bentoml:bentoml $BENTO_PATH -R
WORKDIR $BENTO_PATH

<<<<<<<< HEAD:bentoml/bentos/gemma2/9b-instruct-fp16-e0c2-lm/env/docker/Dockerfile

# Block SETUP_BENTO_COMPONENTS

RUN uv pip install torch==2.4.0 ; exit 0
RUN uv pip install vllm==0.6.2 ; exit 0
|||||||| 5faca8d8:bentoml/bentos/gemma2/27b-instruct-fp16-376d/env/docker/Dockerfile

# Block SETUP_BENTO_COMPONENTS

RUN uv pip install torch==2.4.0 ; exit 0
RUN uv pip install vllm==0.6.3.post1 ; exit 0
========
COPY --chown=bentoml:bentoml ./env/docker ./env/docker/
RUN export UV_COMPILE_BYTECODE=1
RUN apt-get update && apt-get install -q -y --no-install-recommends --allow-remove-essential ca-certificates gnupg2 bash build-essential git
RUN command -v uv >/dev/null || pip install uv
RUN UV_PYTHON_INSTALL_DIR=/app/python/ uv venv --python 3.11 /app/.venv && \
    chown -R bentoml:bentoml /app/.venv
ENV VIRTUAL_ENV=/app/.venv
ENV UV_COMPILE_BYTECODE=1
RUN uv pip install vllm==0.7.3 ; exit 0
>>>>>>>> bento/feat/support-gemma-3:bentoml/bentos/llama3.2/1b-instruct-a0b9/env/docker/Dockerfile
COPY --chown=bentoml:bentoml ./env/python ./env/python/
# install python packages
RUN uv pip install -r ./env/python/requirements.txt

RUN uv pip install --compile-bytecode flashinfer-python --find-links https://flashinfer.ai/whl/cu124/torch2.5

COPY --chown=bentoml:bentoml . ./

# Block SETUP_BENTO_ENTRYPOINT
# Default port for BentoServer
EXPOSE 3000

# Expose Prometheus port
EXPOSE 3001

RUN chmod +x /home/bentoml/bento/env/docker/entrypoint.sh

USER bentoml

ENTRYPOINT [ "/home/bentoml/bento/env/docker/entrypoint.sh" ]

