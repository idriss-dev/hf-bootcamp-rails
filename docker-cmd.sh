#!/bin/sh
set -ex

# run guard with livereload in background
bin/bundle exec guard -i &

# start the server
bin/rails server -b 0.0.0.0
