#!/bin/bash

source ./env

${DOCKER_SERVER_ROOT}/Steam/srcds_run -game tf -autoupdate -steam_dir ${DOCKER_SERVER_ROOT} -steamcmd_script ${DOCKER_SERVER_ROOT}/tf2_ds.txt $@
