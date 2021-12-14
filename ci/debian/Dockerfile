FROM debian:buster

# Add deb-src to sources.list
RUN find /etc/apt/sources.list* -type f -exec sed -i 'p; s/^deb /deb-src /' '{}' +

# Install developer tools
RUN apt-get update \
 && apt-get install --no-install-recommends -yV build-essential devscripts \
    equivs wget git zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev \
    libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev

RUN wget https://www.python.org/ftp/python/3.9.1/Python-3.9.1.tgz \
    && tar -xf Python-3.9.1.tgz \
    && cd Python-3.9.1 \
    && ./configure --enable-optimizations \
    && make && make altinstall \
    && python3.9 --version


RUN wget http://ftp.us.debian.org/debian/pool/main/m/meson/meson_0.60.2-1_all.deb \
    && apt install -f $PWD/meson_*.deb -y && rm meson*.deb
