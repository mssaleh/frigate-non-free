FROM blakeblackshear/frigate:stable-amd64
RUN apt-get update && apt-get install --no-install-recommends -y apt-utils gpg-agent wget && \
    wget -qO - https://repositories.intel.com/graphics/intel-graphics.key | apt-key add - && \
    echo "deb [arch=amd64] https://repositories.intel.com/graphics/ubuntu focal main" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install --no-install-recommends -y intel-opencl-icd libva-drm2 libva2 intel-level-zero-gpu level-zero vainfo \
    intel-media-va-driver-non-free libmfx1 libmfx-tools libgomp1 && \
    wget -q https://github.com/google-coral/pycoral/releases/download/v1.0.1/tflite_runtime-2.5.0-cp38-cp38-linux_x86_64.whl && \
    python3.8 -m pip install tflite_runtime-2.5.0-cp38-cp38-linux_x86_64.whl && \
    rm tflite_runtime-2.5.0-cp38-cp38-linux_x86_64.whl && \
    apt-get full-upgrade -y && apt-get autoremove -y && apt-get autoclean -y && apt-get clean
ENV FONTCONFIG_PATH=/usr/bin/fc-cache
ENV FONTCONFIG_FILE=/etc/fonts
RUN rm -rf /usr/local/lib/libfreetype.so.6 && apt-get update && apt-get install --no-install-recommends -y \
    linux-tools-generic pciutils psmisc tmux vainfo \
    asciidoc-base bison flex gcc g++ git \
    libwebpmux3 librsvg2-2 libx264-155 libx265-179 \
    libcairo-dev libdrm-dev libdw-dev libkmod-dev libmfx-dev libpciaccess-dev \
    libpixman-1-dev libprocps-dev libudev-dev libva-dev libx264-dev libx265-dev \
    libmp3lame-dev libopenjp2-7-dev librsvg2-dev libtheora-dev \
    libvidstab-dev libvorbis-dev libvpx-dev libwebp-dev libx265-dev libnuma-dev libssl-dev \
    libopus-dev librtmp-dev libxvidcore-dev libzmq3-dev ocl-icd-opencl-dev libfdk-aac-dev \
    libfdk-aac1 libmp3lame0 libopenjp2-7 libopus0 librsvg2-2 \
    libtheora0 libvidstab1.1 libvorbis0a libvpx6 libwebp6 libxvidcore4 libzmq5 librtmp1 \
    make pkg-config xsltproc yasm && \
    mkdir -p /opt/ffmpeg_sources && \
    cd /opt/ffmpeg_sources && \
    wget -O ffmpeg.tar.bz2 https://ffmpeg.org/releases/ffmpeg-4.3.2.tar.bz2 && \
    tar xjvf ffmpeg.tar.bz2 && \
    cd /opt/ffmpeg_sources/ffmpeg-4.3.2 && \
    ./configure \
    --bindir="/usr/local/bin" \
    --disable-doc \
    --disable-ffplay \
    --enable-vaapi \
    --enable-libmfx \
    --enable-gpl \
    --enable-libx264 \
    --enable-libx265 \
    --enable-version3 \
    --enable-libdrm \
    --enable-libfdk-aac \
    --enable-libmp3lame \
    --enable-libopenjpeg \
    --enable-libopus \
    --enable-librsvg \
    --enable-libtheora \
    --enable-libvidstab \
    --enable-libvorbis \
    --enable-libvpx \
    --enable-libwebp \
    --enable-libxvid \
    --enable-libzmq \
    --enable-nonfree \
    --enable-opencl \
    --enable-openssl \
    --enable-librtmp \
    --enable-static \
    --enable-swresample \
    --enable-swscale \
    --extra-cflags="-I/opt/ffmpeg/include" \
    --extra-libs="-lpthread -lm" \
    --extra-libs="-ldl" \
    --extra-ldflags="-L/opt/ffmpeg/lib" \
    --prefix="/opt/ffmpeg" \
    --toolchain=hardened && \
    export LIBVA_DRIVER_NAME=iHD &&\
    make && \
    make install && \
    #hash -r && \
    #groupadd -f render && \
    #usermod -aG video $USER && \
    apt purge -y comerr-dev flite1-dev frei0r-plugins-dev gir1.2-freedesktop \
    gir1.2-gdkpixbuf-2.0 gir1.2-harfbuzz-0.0 gir1.2-ibus-1.0 gir1.2-rsvg-2.0 \
    icu-devtools krb5-multidev ladspa-sdk libaom-dev libasound2-dev libass-dev \
    libauthen-sasl-perl libblkid-dev libbs2b-dev libcaca-dev libcairo2-dev \
    libcairo-dev libcairo-script-interpreter2 libcdio-cdda-dev libcdio-dev \
    libcdio-paranoia-dev libchromaprint-dev libcodec2-dev libdc1394-dev libdrm-dev \
    libdw-dev libegl1-mesa-dev libegl-dev libfdk-aac-dev libfile-listing-perl \
    libfindlib-ocaml libfindlib-ocaml-dev libfont-afm-perl libfontconfig1-dev \
    libfreetype6-dev libfreetype-dev libfrei0r-ocaml-dev libfribidi-dev \
    libgdk-pixbuf2.0-dev libgl1-mesa-dev libgl-dev libgles2-mesa-dev libgles-dev \
    libglib2.0-dev libglib2.0-dev-bin libglu1-mesa-dev libglvnd-dev libglx-dev \
    libgme-dev libgmp-dev libgmpxx4ldbl libgnutls28-dev libgnutls-openssl27 \
    libgnutlsxx28 libgraphite2-dev libgsm1-dev libgssrpc4 libharfbuzz-dev \
    libharfbuzz-gobject0 libharfbuzz-icu0 libhtml-format-perl libhtml-form-perl \
    libhtml-tree-perl libhttp-cookies-perl libhttp-daemon-perl libhttp-negotiate-perl \
    libibus-1.0-5 libibus-1.0-dev libice6 libice-dev libicu-dev libidn2-dev \
    libio-socket-ssl-perl libjack-dev libkadm5clnt-mit11 libkadm5srv-mit11 libkdb5-9 \
    libkmod-dev libkrb5-dev libladspa-ocaml libladspa-ocaml-dev liblilv-dev libltdl-dev \
    liblwp-protocol-https-perl libmailtools-perl libmfx-dev libmount-dev libmp3lame-dev \
    libmpg123-dev libmysofa-dev libnet-http-perl libnet-smtp-ssl-perl libnet-ssleay-perl \
    libnorm-dev libnuma-dev libogg-dev libomxil-bellagio0 libomxil-bellagio-dev \
    libopenal-dev libopengl-dev libopenjp2-7-dev libopenmpt-dev libopus-dev libout123-0 \
    libp11-kit-dev libpciaccess-dev libpcre16-3 libpcre2-16-0 libpcre2-32-0 libpcre2-dev \
    libpcre2-posix2 libpcre32-3 libpcre3-dev libpcrecpp0v5 libpgm-dev libpixman-1-dev \
    libpng-dev libprocps-dev libpthread-stubs0-dev libpulse-dev libraw1394-dev \
    librsvg2-dev librtmp-dev librubberband-dev libsdl2-dev libselinux1-dev libsepol1-dev \
    libserd-dev libset-scalar-perl libshine-dev libslang2-dev libsm6 libsm-dev \
    libsnappy-dev libsndio-dev libsodium-dev libsord-dev libsoxr-dev libspeex-dev \
    libsratom-dev libssh-dev libssl-dev libtasn1-6-dev libtasn1-doc libtheora-dev \
    libtry-tiny-perl libtwolame-dev libudev-dev libunbound8 libva-dev libva-glx2 \
    libvdpau-dev libvidstab-dev libvorbis-dev libvpx-dev libwayland-bin libwayland-dev \
    libwebp-dev libwww-perl libwww-robotrules-perl libx11-dev libx264-dev libx265-dev \
    libxau-dev libxcb1-dev libxcb-render0-dev libxcb-shape0-dev libxcb-shm0-dev \
    libxcb-xfixes0-dev libxcursor-dev libxdmcp-dev libxext-dev libxfixes-dev libxi-dev \
    libxinerama-dev libxkbcommon-dev libxml-parser-perl libxml-sax-expat-perl \
    libxrandr-dev libxrender-dev libxss-dev libxt6 libxt-dev libxv-dev libxvidcore-dev \
    libxxf86vm-dev libzmq3-dev libzvbi-dev lv2-dev nettle-dev ocaml-base-nox \
    ocaml-compiler-libs ocaml-findlib ocaml-interp ocaml-man ocaml-nox ocl-icd-opencl-dev \
    opencl-c-headers perl-openssl-defaults uuid-dev x11proto-core-dev x11proto-dev \
    x11proto-input-dev x11proto-randr-dev x11proto-scrnsaver-dev x11proto-xext-dev \
    x11proto-xf86vidmode-dev x11proto-xinerama-dev xorg-sgml-doctools xtrans-dev yasm && \
    rm -rf /opt/ffmpeg_sources && \
    apt update && apt full-upgrade -y && apt autoremove --purge -y && apt autoclean -y && apt clean
