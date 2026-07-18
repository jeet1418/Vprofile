FROM maven:3.9.9-eclipse-temurin-21-jammy

USER root

ARG TARGETARCH

# ------------------------------------------------------------
# Install required packages
# ------------------------------------------------------------
RUN apt-get update && \
    apt-get install -y \
        git \
        curl \
        unzip \
        ca-certificates \
        gnupg \
        lsb-release && \
    rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------
# Install Docker CLI
# ------------------------------------------------------------
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    chmod a+r /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo ${VERSION_CODENAME}) stable" \
    > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y docker-ce-cli && \
    rm -rf /var/lib/apt/lists/*

# ------------------------------------------------------------
# Install kubectl
# ------------------------------------------------------------
RUN curl -LO "https://dl.k8s.io/release/$(curl -Ls https://dl.k8s.io/release/stable.txt)/bin/linux/${TARGETARCH}/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl

# ------------------------------------------------------------
# Install Helm
# ------------------------------------------------------------
RUN curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# ------------------------------------------------------------
# Install AWS CLI v2
# ------------------------------------------------------------
RUN if [ "$TARGETARCH" = "arm64" ]; then \
        curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o awscliv2.zip; \
    else \
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip; \
    fi && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws awscliv2.zip

#------------------------------------------------------------
# Install yq
#------------------------------------------------------------

RUN wget -qO /usr/local/bin/yq \
    https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 \
    && chmod +x /usr/local/bin/yq

# ------------------------------------------------------------
# Verify installations
# ------------------------------------------------------------
RUN java -version && \
    mvn -version && \
    git --version && \
    docker --version && \
    kubectl version --client && \
    helm version && \
    aws --version

WORKDIR /workspace

CMD ["bash"]