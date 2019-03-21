FROM ubuntu:bionic

# Install build packages and MPD itself to get possibly missing runtime dependencies
RUN apt-get update \
    && apt-get update --fix-missing \
    && apt-get install -y \
        g++ \
        libpcre3-dev \
        libmad0-dev libmpg123-dev libid3tag0-dev \
        libflac-dev libvorbis-dev libopus-dev \
        libadplug-dev libaudiofile-dev libsndfile1-dev libfaad-dev \
        libfluidsynth-dev libgme-dev libmikmod2-dev libmodplug-dev \
        libmpcdec-dev libwavpack-dev libwildmidi-dev \
        libsidplay2-dev libsidutils-dev libresid-builder-dev \
        libavcodec-dev libavformat-dev \
        libmp3lame-dev libtwolame-dev libshine-dev \
        libsamplerate0-dev libsoxr-dev \
        libbz2-dev libcdio-paranoia-dev libiso9660-dev libmms-dev \
        libzzip-dev \
        libcurl4-gnutls-dev libyajl-dev libexpat-dev \
        libasound2-dev libao-dev libjack-jackd2-dev libopenal-dev \
        libpulse-dev libshout3-dev \
        libsndio-dev \
        libmpdclient-dev \
        libnfs-dev libsmbclient-dev \
        libupnp-dev \
        libavahi-client-dev \
        libsqlite3-dev \
        libsystemd-dev \
        libgtest-dev \
        libboost-dev \
        libicu-dev \
        mpd \
        python3-pip \
        ninja-build
RUN pip3 install meson

WORKDIR /src/
COPY mpd_src .
RUN meson . output/release --buildtype=debugoptimized -Db_ndebug=true
RUN ninja -C output/release

ARG user=mpd
ARG group=audio

COPY mpd.conf /etc/mpd.conf

RUN mkdir -p /var/lib/mpd/music \
    && mkdir -p /var/lib/mpd/playlists \
    && mkdir -p /var/log/mpd \
    && mkdir /run/mpd \
    && touch /run/mpd/pid \
    && touch /var/lib/mpd/state \
    && touch /var/lib/mpd/database \
    && chown -R ${user}:${group} /var/lib/mpd \
    && chown -R ${user}:${group} /var/log/mpd \
    && chown ${user}:${group} /run/mpd/pid \
    && chown ${user}:${group} /var/lib/mpd/state \
    && chown ${user}:${group} /var/lib/mpd/database

EXPOSE 6600 8000

CMD /src/output/release/mpd --no-daemon --stdout -v /etc/mpd.conf
