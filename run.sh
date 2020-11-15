#!/bin/bash
docker run -d \
    --name timemachine \
    --net host \
    -v "/storage/backups/:/backups/backups/" \
    --restart=unless-stopped \
    timemachine
