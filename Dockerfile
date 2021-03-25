FROM blakeblackshear/frigate:stable-amd64

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    ca-certificates \
    curl \
    gpg-agent \
    software-properties-common

ARG APT_GRAPHICS_REPO="https://repositories.intel.com/graphics/ubuntu focal main"
RUN curl -fsSL https://repositories.intel.com/graphics/intel-graphics.key | apt-key add -
RUN apt-add-repository "deb ${APT_GRAPHICS_REPO}"

RUN apt-get update && apt-get install -y --no-install-recommends \
    intel-media-va-driver-non-free \
    libmfx1 \
    libva-drm2 \
    && apt-get full-upgrade -y && apt autoremove --purge -y && apt autoclean -y && apt clean \
    && rm -rf /var/lib/apt/lists/*

# RUN export LIBVA_DRIVER_NAME=iHD

# ENV FONTCONFIG_PATH=/usr/bin/fc-cache
# ENV FONTCONFIG_FILE=/etc/fonts
# RUN rm -rf /usr/local/lib/libfreetype.so.6

# RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
#     gcc \
#     g++ \
#     git \
#     libass-dev \
#     libdrm-dev \
#     libdw-dev \
#     libkmod-dev \
#     libmfx-dev \
#     libpciaccess-dev \
#     libpixman-1-dev \
#     libprocps-dev \
#     libtool \
#     libudev-dev \
#     libva-dev \
#     libx264-dev \
#     libx265-dev \
#     make \
#     meson \
#     pkg-config \
#     sudo \
#     xsltproc \
#     yasm \
#     zlib1g-dev \
#     libmp3lame-dev \
#     libopenjp2-7-dev \
#     librsvg2-dev \
#     libvidstab-dev \
#     libvorbis-dev \
#     libvpx-dev \
#     libwebp-dev \
#     libnuma-dev libssl-dev \
#     librtmp-dev \
#     libxvidcore-dev \
#     libzmq3-dev \
#     ocl-icd-opencl-dev \
#     libfdk-aac-dev

# ARG FFMPEG_VERSION=4.3.2
# ARG PREFIX=/opt/ffmpeg
# ARG FFMPEG_SRC=/opt/ffmpeg_sources

# RUN mkdir -p ${FFMPEG_SRC} \
#     && wget -O ${FFMPEG_SRC}/ffmpeg.tar.bz2 https://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.bz2 \
#     && cd ${FFMPEG_SRC} && tar xjvf ffmpeg.tar.bz2

# RUN cd ${FFMPEG_SRC}/ffmpeg-${FFMPEG_VERSION} \
#     && ./configure \
#     --bindir="/usr/local/bin" \
#     --prefix=${PREFIX} \
#     --disable-static \
#     --disable-ffplay \
#     --disable-doc \
#     --enable-shared \
#     --enable-vaapi \
#     --enable-libmfx \
#     --enable-gpl \
#     --enable-libx264 \
#     --enable-libx265 \
#     --enable-version3 \
#     --enable-nonfree \
#     --enable-librtmp \
#     --enable-opencl \
#     --enable-libfdk-aac \
#     --enable-libopenjpeg \
#     --enable-librsvg \
#     --enable-libmp3lame \
#     --enable-libvpx \
#     --enable-libzmq \
#     --enable-libwebp \
#     --enable-swresample \
#     --enable-swscale \
#     --enable-openssl \
#     --enable-libvorbis \
#     --enable-libdrm \
#     --enable-libvidstab \
#     --enable-libxvid \
#     --extra-cflags="-I$PREFIX/include" \
#     --extra-libs="-lpthread -lm" \
#     --extra-libs="-ldl" \
#     --extra-ldflags="-L$PREFIX/lib" \
#     --prefix="$PREFIX" \
#     --toolchain=hardened \
#     && make -j $(nproc --all) \
#     && make install \
#     && mkdir -p ${PREFIX}/bin/ \
#     && make tools/zmqsend && cp tools/zmqsend ${PREFIX}/bin/ \
#     && make distclean \
#     && hash -r \
#     && cd ${FFMPEG_SRC}/ffmpeg-${FFMPEG_VERSION}/tools \
#     && make qt-faststart && cp qt-faststart ${PREFIX}/bin/ \
#     && cp ${PREFIX}/bin/* /usr/local/bin/ \
#     && cp -a ${PREFIX}/lib/* /usr/local/lib/ \
#     && LD_LIBRARY_PATH=/usr/local/lib ffmpeg -buildconf \
#     && cp -r ${PREFIX}/include/* /usr/local/include/ \
#     && cp -r ${PREFIX}/share/ffmpeg /usr/local/share/ \
#     && mkdir -p /usr/local/lib/pkgconfig \
#     && for pc in ${PREFIX}/lib/pkgconfig/libav*.pc ${PREFIX}/lib/pkgconfig/libpostproc.pc ${PREFIX}/lib/pkgconfig/libsw*.pc; do \
#        sed 's:${PREFIX}:/usr/local:g' <"$pc" >/usr/local/lib/pkgconfig/"${pc##*/}"; done \
#     && ldconfig \
#     && rm -rf ${FFMPEG_SRC}

# RUN apt purge -y comerr-dev flite1-dev frei0r-plugins-dev gir1.2-freedesktop \
#     gir1.2-gdkpixbuf-2.0 gir1.2-harfbuzz-0.0 gir1.2-ibus-1.0 gir1.2-rsvg-2.0 \
#     icu-devtools krb5-multidev ladspa-sdk libaom-dev libasound2-dev libass-dev \
#     libauthen-sasl-perl libblkid-dev libbs2b-dev libcaca-dev libcairo2-dev \
#     libcairo-dev libcairo-script-interpreter2 libcdio-cdda-dev libcdio-dev \
#     libcdio-paranoia-dev libchromaprint-dev libcodec2-dev libdc1394-dev libdrm-dev \
#     libdw-dev libegl1-mesa-dev libegl-dev libfdk-aac-dev libfile-listing-perl \
#     libfindlib-ocaml libfindlib-ocaml-dev libfont-afm-perl libfontconfig1-dev \
#     libfreetype6-dev libfreetype-dev libfrei0r-ocaml-dev libfribidi-dev \
#     libgdk-pixbuf2.0-dev libgl1-mesa-dev libgl-dev libgles2-mesa-dev libgles-dev \
#     libglib2.0-dev libglib2.0-dev-bin libglu1-mesa-dev libglvnd-dev libglx-dev \
#     libgme-dev libgmp-dev libgmpxx4ldbl libgnutls28-dev libgnutls-openssl27 \
#     libgnutlsxx28 libgraphite2-dev libgsm1-dev libgssrpc4 libharfbuzz-dev \
#     libharfbuzz-gobject0 libharfbuzz-icu0 libhtml-format-perl libhtml-form-perl \
#     libhtml-tree-perl libhttp-cookies-perl libhttp-daemon-perl libhttp-negotiate-perl \
#     libibus-1.0-5 libibus-1.0-dev libice6 libice-dev libicu-dev libidn2-dev \
#     libio-socket-ssl-perl libjack-dev libkadm5clnt-mit11 libkadm5srv-mit11 libkdb5-9 \
#     libkmod-dev libkrb5-dev libladspa-ocaml libladspa-ocaml-dev liblilv-dev libltdl-dev \
#     liblwp-protocol-https-perl libmailtools-perl libmfx-dev libmount-dev libmp3lame-dev \
#     libmpg123-dev libmysofa-dev libnet-http-perl libnet-smtp-ssl-perl libnet-ssleay-perl \
#     libnorm-dev libnuma-dev libogg-dev libomxil-bellagio0 libomxil-bellagio-dev \
#     libopenal-dev libopengl-dev libopenjp2-7-dev libopenmpt-dev libopus-dev libout123-0 \
#     libp11-kit-dev libpciaccess-dev libpcre16-3 libpcre2-16-0 libpcre2-32-0 libpcre2-dev \
#     libpcre2-posix2 libpcre32-3 libpcre3-dev libpcrecpp0v5 libpgm-dev libpixman-1-dev \
#     libpng-dev libprocps-dev libpthread-stubs0-dev libpulse-dev libraw1394-dev \
#     librsvg2-dev librtmp-dev librubberband-dev libsdl2-dev libselinux1-dev libsepol1-dev \
#     libserd-dev libset-scalar-perl libshine-dev libslang2-dev libsm6 libsm-dev \
#     libsnappy-dev libsndio-dev libsodium-dev libsord-dev libsoxr-dev libspeex-dev \
#     libsratom-dev libssh-dev libssl-dev libtasn1-6-dev libtasn1-doc libtheora-dev \
#     libtry-tiny-perl libtwolame-dev libudev-dev libunbound8 libva-dev libva-glx2 \
#     libvdpau-dev libvidstab-dev libvorbis-dev libvpx-dev libwayland-bin libwayland-dev \
#     libwebp-dev libwww-perl libwww-robotrules-perl libx11-dev libx264-dev libx265-dev \
#     libxau-dev libxcb1-dev libxcb-render0-dev libxcb-shape0-dev libxcb-shm0-dev \
#     libxcb-xfixes0-dev libxcursor-dev libxdmcp-dev libxext-dev libxfixes-dev libxi-dev \
#     libxinerama-dev libxkbcommon-dev libxml-parser-perl libxml-sax-expat-perl \
#     libxrandr-dev libxrender-dev libxss-dev libxt6 libxt-dev libxv-dev libxvidcore-dev \
#     libxxf86vm-dev libzmq3-dev libzvbi-dev lv2-dev nettle-dev ocaml-base-nox \
#     ocaml-compiler-libs ocaml-findlib ocaml-interp ocaml-man ocaml-nox ocl-icd-opencl-dev \
#     opencl-c-headers perl-openssl-defaults uuid-dev x11proto-core-dev x11proto-dev \
#     x11proto-input-dev x11proto-randr-dev x11proto-scrnsaver-dev x11proto-xext-dev \
#     x11proto-xf86vidmode-dev x11proto-xinerama-dev xorg-sgml-doctools xtrans-dev yasm \
#     libass-dev libdrm-dev libdw-dev libkmod-dev libmfx-dev libpciaccess-dev libpixman-1-dev \
#     libprocps-dev libudev-dev libva-dev libx264-dev libx265-dev make meson yasm zlib1g-dev \
#     libmp3lame-dev libopenjp2-7-dev librsvg2-dev libvidstab-dev libvorbis-dev libvpx-dev libwebp-dev \
#     libnuma-dev libssl-dev librtmp-dev libxvidcore-dev libzmq3-dev ocl-icd-opencl-dev libfdk-aac-dev \
#     && apt autoremove --purge -y && apt autoclean -y && apt clean

# RUN apt-get update && apt-get install -y --no-install-recommends \
#     libgomp1 \
#     intel-opencl-icd \
#     intel-media-va-driver-non-free \
#     libmfx1 \
#     libmfx-tools \
#     libva-drm2 \
#     pciutils \
#     psmisc \
#     tmux \
#     vainfo \
#     $(apt-cache depends libx264-dev | grep Depends | grep libx264 | cut -d: -f2) \
#     $(apt-cache depends libx265-dev | grep Depends | grep libx265 | cut -d: -f2) \
#     libfdk-aac1 \
#     libmp3lame0 \
#     libopenjp2-7 \
#     librsvg2-2 \
#     libvidstab1.1 \
#     libvorbis0a \
#     libvpx6 \
#     libwebp6 \
#     libxvidcore4 \
#     libzmq5 \
#     librtmp1 \
#     libwebpmux3 \
#     && apt-get full-upgrade -y && apt autoremove --purge -y && apt autoclean -y && apt clean \
#     && rm -rf /var/lib/apt/lists/*

# RUN export LIBVA_DRIVER_NAME=iHD
