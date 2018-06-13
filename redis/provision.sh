#!/usr/bin/env bash
#
# This script installs the latest version of Redis in VVV.
#
# Based on the instructions found in the Redis Quick Start:
# https://redis.io/topics/quickstart.

# Enable the default Redis port to be overwritten.
if [ -z "$REDIS_PORT" ] ; then
    REDIS_PORT=6379
fi

# Install Tool Command Language (tcl), necessary for `make test`.
sudo apt-get install -y tcl

# Download, extract, and build Redis from source.
cd /tmp || exit 1
wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable || exit 1
make
make test

# Copy the binaries into the local path.
sudo make install

# Configure and daemonize Redis.
sudo REDIS_CONFIG_FILE="/etc/redis/${REDIS_PORT}.conf" \
    REDIS_LOG_FILE="/var/log/redis_${REDIS_PORT}.log" \
    REDIS_DATA_DIR="/var/lib/redis/${REDIS_PORT}" \
    REDIS_EXECUTABLE="$(command -v redis-server)" \
    ./utils/install_server.sh

# Install phpredis via PECL.
yes '' | sudo pecl install redis || exit 1

# Create redis.ini files for each version of PHP.
for DIR in /etc/php/*/mods-available; do
    echo "extension=redis.so" | sudo tee "$DIR/redis.ini" > /dev/null
done

# Enable the Redis PHP module.
sudo phpenmod redis
