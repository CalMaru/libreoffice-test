FROM asia-northeast3-docker.pkg.dev/qadev-378402/rag42-image-repository/qa-base:u22-p310-0.08

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    g++ \
    gfortran \
    libffi-dev \
    libssl-dev \
    libgl1 \
    libglib2.0-0 \
    vim \
    procps \
    less \
    poppler-utils \
    default-jre \
    libreoffice-core \
    libreoffice-writer \
    libreoffice-calc \
    libreoffice-impress \
    libreoffice-draw \
    libreoffice-common \
    libreoffice-java-common \
    libreoffice-script-provider-python \
    libgl1-mesa-glx \
    fonts-dejavu-core \
    fonts-liberation2 \
    fonts-nanum* \
    fonts-noto-cjk* \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV HOME=/app
WORKDIR ${HOME}

COPY --from=ghcr.io/astral-sh/uv:0.8.4 /uv /uvx /bin/

COPY pyproject.toml .
RUN uv venv .venv && uv sync --no-install-project --no-editable

COPY . .
