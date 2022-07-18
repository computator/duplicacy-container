FROM alpine

LABEL org.opencontainers.image.source=https://github.com/computator/duplicacy-container

ENV DUPLICACY_VERSION=2.7.2
ENV DUPLICACY_BINARY_URL=https://github.com/gilbertchen/duplicacy/releases/download/v${DUPLICACY_VERSION}/duplicacy_linux_x64_${DUPLICACY_VERSION}

RUN wget $DUPLICACY_BINARY_URL -O duplicacy.bin \
	&& install duplicacy.bin /usr/bin/duplicacy \
	&& rm duplicacy.bin

WORKDIR /repo
ENTRYPOINT ["duplicacy"]
