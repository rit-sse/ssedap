#!/bin/bash

# bundle our gems for deployment with binstubs, and the ruby-local-exec shebang
#
# we used to use --deployment, but it's sloooowww and can cause problems with
# deploying, oddly enough...
bundle install --quiet --binstubs --shebang ruby-local-exec

RAILS_ENV=production rake db:create

# make our directories and symlinks
rm -rf "$APP_DIR/tmp/pids" "$APP_DIR/log"
mkdir -p "$APP_SHARED/sockets"
mkdir -p "$APP_SHARED/pids"
mkdir -p "$APP_SHARED/log"
mkdir -p "$APP_SHARED/files"
mkdir -p "$APP_SHARED/config"
ln -s "$APP_SHARED/sockets" "$APP_DIR/tmp/sockets"
ln -s "$APP_SHARED/pids" "$APP_DIR/tmp/pids"
ln -s "$APP_SHARED/files" "$APP_DIR/files"
ln -s "$APP_SHARED/log" "$APP_DIR/log"

