#!/bin/sh
STORAGE_SEG=${STORAGE_NAME:+_$(echo "${STORAGE_NAME}" | tr a-z A-Z)}
exec podman run \
	--rm \
	-i \
	--net host \
	-v "${REPO_PATH:-.}:/repo" \
	--secret duplicacy_key,type=env,target=DUPLICACY${STORAGE_SEG}_PASSWORD \
	-v $SSH_AUTH_SOCK:/ssh.sock \
	-e SSH_AUTH_SOCK=/ssh.sock \
	-e DUPLICACY${STORAGE_SEG}_SSH_KEY_FILE=/dev/null \
	ghcr.io/computator/duplicacy \
	"$@"
