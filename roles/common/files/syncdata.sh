#!/bin/bash
# files that should reside on all machines locally are synced on a regular bases
# adapt accordingly (USER@SERVER)

rsync -av --delete --password-file=/etc/rsyncsecret USER@SERVER::class /data/local

