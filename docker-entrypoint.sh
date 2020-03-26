#!/bin/sh
# Interpreter identifier

# Exit on fail
set -e

rm -f $APP_HOME/tmp/pids/server.pid

bundle exec bin/rails db:create
bundle exec bin/rails db:migrate

exec "$@"
