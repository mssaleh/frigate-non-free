FROM blakeblackshear/frigate:stable-amd64
RUN apt-get -qq update \
    && apt-get -qq remove -y intel-media-va-driver \
    && apt-get -qq install --no-install-recommends -y \
        intel-media-va-driver-non-free \
    && (apt-get autoremove -y; apt-get autoclean -y)
