# ===========================================
#
# THIS IS A GENERATED DOCKERFILE. DO NOT EDIT
#
# ===========================================

# Block SETUP_BENTO_BASE_IMAGE
FROM python:3.9-slim as base-container

ENV LANG=C.UTF-8

ENV LC_ALL=C.UTF-8

ENV PYTHONIOENCODING=UTF-8

ENV PYTHONUNBUFFERED=1



USER root

ENV DEBIAN_FRONTEND=noninteractive
RUN rm -f /etc/apt/apt.conf.d/docker-clean; echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
RUN set -eux && \
    apt-get update -y && \
    apt-get install -q -y --no-install-recommends --allow-remove-essential \
        ca-certificates gnupg2 bash build-essential curl 
RUN curl -LO https://astral.sh/uv/install.sh && \
    sh install.sh && rm install.sh && mv $HOME/.local/bin/uv /usr/local/bin/

# Block SETUP_BENTO_USER
ARG BENTO_USER=bentoml
ARG BENTO_USER_UID=1034
ARG BENTO_USER_GID=1034
RUN groupadd -g $BENTO_USER_GID -o $BENTO_USER && useradd -m -u $BENTO_USER_UID -g $BENTO_USER_GID -o -r $BENTO_USER
ARG BENTO_PATH=/home/bentoml/bento
ENV BENTO_PATH=$BENTO_PATH
ENV BENTOML_HOME=/home/bentoml/
ENV BENTOML_HF_CACHE_DIR=/home/bentoml/bento/hf-models

RUN mkdir $BENTO_PATH && chown bentoml:bentoml $BENTO_PATH -R
WORKDIR $BENTO_PATH


# Block SETUP_BENTO_COMPONENTS

RUN uv venv -p 3.9 /app/.venv
ENV VIRTUAL_ENV=/app/.venv

RUN uv pip install torch==2.5.1 ; exit 0
RUN uv pip install vllm==0.6.6.post1 ; exit 0
COPY --chown=bentoml:bentoml ./env/python ./env/python/
# install python packages with install.sh
RUN bash -euxo pipefail /home/bentoml/bento/env/python/install.sh
COPY --chown=bentoml:bentoml . ./

# Block SETUP_BENTO_ENTRYPOINT
RUN rm -rf /var/lib/{apt,cache,log}
# Default port for BentoServer
EXPOSE 3000

# Expose Prometheus port
EXPOSE 3001

RUN chmod +x /home/bentoml/bento/env/docker/entrypoint.sh
RUN chown bentoml:bentoml -R $VIRTUAL_ENV

USER bentoml

ENTRYPOINT [ "/home/bentoml/bento/env/docker/entrypoint.sh" ]


