FROM blakeblackshear/frigate:stable-amd64
RUN apt-get -qq update \
    && apt-get -qq install --no-install-recommends -y \
        intel-media-va-driver-non-free \
    && export LIBVA_DRIVER_NAME=iHD \
    && (apt-get autoremove -y; apt-get autoclean -y)
