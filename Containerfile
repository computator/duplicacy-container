FROM docker.io/library/alpine AS download

ARG RELEASE_VER=latest

RUN set -eux; \
	DUPLICACY_BINARY_URL=$(\
		wget --header 'X-GitHub-API-Version: 2022-11-28' -qO - \
				"https://api.github.com/repos/gilbertchen/duplicacy/releases/$([ "$RELEASE_VER" = "latest" ] || echo "tags/v")${RELEASE_VER}" \
			| grep -e 'browser_download_url.*linux_x64' \
			| cut -d '"' -f 4\
		); \
	wget $DUPLICACY_BINARY_URL -O duplicacy.bin; \
	chmod 755 duplicacy.bin

FROM gcr.io/distroless/static

LABEL org.opencontainers.image.source=https://github.com/computator/duplicacy-container

COPY --from=download duplicacy.bin /usr/bin/duplicacy

WORKDIR /repo
ENTRYPOINT ["duplicacy"]
