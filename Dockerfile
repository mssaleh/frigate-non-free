FROM blakeblackshear/frigate:stable-amd64

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    ca-certificates \
    curl \
    gpg-agent \
    software-properties-common

ARG APT_GRAPHICS_REPO="https://repositories.intel.com/graphics/ubuntu focal main"
RUN curl -fsSL https://repositories.intel.com/graphics/intel-graphics.key | apt-key add -
RUN apt-add-repository "deb $APT_GRAPHICS_REPO"

RUN apt-get update && apt-get install -y --no-install-recommends \
    intel-opencl-icd \
    intel-media-va-driver-non-free \
    libmfx1 \
    libva-drm2 \
    && apt-get full-upgrade -y && apt autoremove --purge -y && apt autoclean -y && apt clean \
    && rm -rf /var/lib/apt/lists/*
