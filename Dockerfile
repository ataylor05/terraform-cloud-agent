FROM hashicorp/tfc-agent:latest

ARG KUBECTL_VERSION=1.22.0
ARG HELM_VERSION=3.6.3

USER root

RUN apt-get update \
&& apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        curl \
        jq \
        git \
        iputils-ping \
        lsb-release \
        nfs-common \
        tar \
        unzip \
        vim \
        wget \
        zip

COPY ca.crt /usr/local/share/ca-certificates/ca.crt
RUN update-ca-certificates

RUN curl -LO https://dl.k8s.io/release/v$KUBECTL_VERSION/bin/linux/amd64/kubectl \
    && chmod +x kubectl \
    && mv kubectl /usr/bin

RUN curl -LO https://get.helm.sh/helm-v$HELM_VERSION-linux-amd64.tar.gz \
    && tar -xzvf helm-v$HELM_VERSION-linux-amd64.tar.gz \
    && chmod +x linux-amd64/helm \
    && mv linux-amd64/helm /usr/bin \
    && rm helm-v$HELM_VERSION-linux-amd64.tar.gz \
    && rm -rf linux-amd64

USER tfc-agent

ENTRYPOINT ["/home/tfc-agent/bin/tfc-agent"]
