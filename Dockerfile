ARG BASE_IMAGE=lscr.io/linuxserver/webtop:ubuntu-xfce
FROM ${BASE_IMAGE}

ENV APP_VERSION=4.11.10
ENV ARCH=x86_64
ENV APP_NAME=pandacoin
ENV TARBALL_URL="https://gitlab.com/api/v4/projects/25484413/packages/generic/pandacoin/pandacoin-v${APP_VERSION}pnd/${APP_NAME}-${APP_VERSION}-${ARCH}-linux-gnu.tar.gz"
ENV TARBALL_NAME="${APP_NAME}-${APP_VERSION}-${ARCH}-linux-gnu.tar.gz"

RUN apt-get update && \
    apt-get install -y curl wget nano && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 22445 33445 44445

WORKDIR /tmp

RUN curl -L -o ${TARBALL_NAME} ${TARBALL_URL} && \
    tar xzf ${TARBALL_NAME}

RUN install -Dm755 pandacoin-4.11.10/bin/pandacoin-qt /usr/local/bin/pandacoin-qt && \
    install -Dm755 pandacoin-4.11.10/bin/pandacoin-wallet /usr/local/bin/pandacoin-wallet && \
    install -Dm755 pandacoin-4.11.10/bin/pandacoind /usr/local/bin/pandacoind && \
    install -Dm755 pandacoin-4.11.10/bin/pandacoin-cli /usr/local/bin/pandacoin-cli && \
    install -Dm755 pandacoin-4.11.10/bin/pandacoin-tx /usr/local/bin/pandacoin-tx && \
    mkdir -p /usr/local/lib && \
    install -Dm755 pandacoin-4.11.10/lib/libpandacoinconsensus.so.0 /usr/local/lib/libpandacoinconsensus.so.0 && \
    install -Dm755 pandacoin-4.11.10/lib/libpandacoinconsensus.so.0.0.0 /usr/local/lib/libpandacoinconsensus.so.0.0.0 && \
    ln -sf /usr/local/lib/libpandacoinconsensus.so.0.0.0 /usr/local/lib/libpandacoinconsensus.so

RUN ldconfig

COPY pandacoin128.png /usr/share/pixmaps/pandacoin128.png
COPY pandacoin-testnet128.png /usr/share/pixmaps/pandacoin-testnet128.png
COPY pandacoin-qt.desktop /usr/share/applications/pandacoin-qt.desktop
COPY pandacoin-testnet-qt.desktop /usr/share/applications/pandacoin-testnet-qt.desktop


RUN mkdir -p /config/Desktop /config/.pandacoin && \
    cp /usr/share/applications/pandacoin*.desktop /config/Desktop/ && \
    chmod +x /config/Desktop/pandacoin*.desktop && \
    chown -R 911:911 /config/Desktop /config/.pandacoin
	
ADD https://github.com/DigitalPandacoin/Pandacoin-multiwallet-DEX/releases/download/0.8.2/Pandacoin-multiwallet-DEX-linux-5818b30-x86_64.AppImage /bin/pandacoin-multiwallet.AppImage
RUN chmod +x /bin/pandacoin-multiwallet.AppImage
RUN cd /bin && ./pandacoin-multiwallet.AppImage --appimage-extract
RUN mv /bin/squashfs-root /bin/pandacoin-multiwallet
COPY pandacoin-multiwallet.desktop /usr/share/applications/pandacoin-multiwallet.desktop
RUN cp /usr/share/applications/pandacoin-multiwallet.desktop /config/Desktop/pandacoin-multiwallet.desktop
RUN chmod +x /usr/share/applications/pandacoin-multiwallet.desktop
RUN rm -rf /tmp/*
