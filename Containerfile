FROM alpine AS download

ENV DUPLICACY_VERSION=2.7.2
ENV DUPLICACY_BINARY_URL=https://github.com/gilbertchen/duplicacy/releases/download/v${DUPLICACY_VERSION}/duplicacy_linux_x64_${DUPLICACY_VERSION}

RUN wget $DUPLICACY_BINARY_URL -O duplicacy.bin \
	&& chmod 755 duplicacy.bin

FROM scratch

LABEL org.opencontainers.image.source=https://github.com/computator/duplicacy-container

COPY --from=download duplicacy.bin /usr/bin/duplicacy

WORKDIR /repo
ENTRYPOINT ["duplicacy"]
