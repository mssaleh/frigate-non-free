FROM blakeblackshear/frigate:stable-amd64
RUN apt-get update && apt-get install --no-install-recommends -y gpg-agent wget \
    && wget -qO - https://repositories.intel.com/graphics/intel-graphics.key | apt-key add - \
    && apt-add-repository 'deb [arch=amd64] https://repositories.intel.com/graphics/ubuntu focal main' \
    && apt-get update \
    && apt-get install --no-install-recommends -y intel-opencl-icd libva-drm2 libva2 intel-level-zero-gpu level-zero vainfo \
       intel-media-va-driver-non-free libmfx1 libmfx-tools libgomp1 \
    && wget -q https://github.com/google-coral/pycoral/releases/download/v1.0.1/tflite_runtime-2.5.0-cp38-cp38-linux_x86_64.whl \
    && python3.8 -m pip install tflite_runtime-2.5.0-cp38-cp38-linux_x86_64.whl \
    && rm tflite_runtime-2.5.0-cp38-cp38-linux_x86_64.whl \
    && (apt-get autoremove -y; apt-get autoclean -y; apt-get clean)


