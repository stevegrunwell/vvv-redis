# Redis Utilities for VVV

[![Build Status](https://travis-ci.com/stevegrunwell/vvv-redis.svg?branch=master)](https://travis-ci.com/stevegrunwell/vvv-redis)

This package is meant to automate the installation and configuration of [Redis](https://redis.io/) and [phpredis](https://github.com/phpredis/phpredis) in [Varying Vagrant Vagrants (VVV)](https://varyingvagrantvagrants.org/) environments.

The latest version of Redis will be built and installed from source, providing your VVV environment with a powerful in-memory data store and queuing system. Additionally, phpredis will be installed, exposing access to Redis from within your PHP applications.

For more information on how to use Redis, [please see the Redis documentation](https://redis.io/documentation).

## Installation

The package registers Redis as [a custom utility](https://varyingvagrantvagrants.org/docs/en-US/utilities/), making it easy to install via [the `vvv-custom.yml` file](https://varyingvagrantvagrants.org/docs/en-US/vvv-config/):

1. Add the following line under `utility-sources:` (or create the node if it doesn't yet exist):

    ```yml
    utility-sources:
      redis: https://github.com/stevegrunwell/vvv-redis.git
    ```

2. Under the `utilities:` section, add a new node **at the same level as** the `core:` node:

    ```yml
    utilities:
      core:
        # Any core utilities you're using go here (e.g. phpmyadmin, php72, etc.)
      redis:
        - redis
    ```

3. (Re-) provision Vagrant using `vagrant up --provision`

### Testing Redis

Once VVV has provisioned, you can verify that Redis is up and running by ping-ing the Redis server:

```bash
vagrant@vvv:$ redis-cli ping
PONG
```

## Support

This package has been designed to work with the latest versions of VVV, adhering to the [instructions provided in the official Redis Quick Start Guide](https://redis.io/topics/quickstart), using setup scripts that ship with Redis itself. Meanwhile, phpredis is configured to [install the latest stable release via PECL](https://github.com/phpredis/phpredis/blob/develop/INSTALL.markdown#installation-from-pecl).

That being said, bugs do happen from time to time in software. If you run into trouble, [please open an issue on GitHub](https://github.com/stevegrunwell/vvv-redis/issues/new) and we'll try to help you through it!

## License

This package is licensed under the [MIT License](license.txt), while Redis itself is released under [the BSD 3-Clause "New" or "Revised" License](https://github.com/antirez/redis/blob/unstable/COPYING) and phpredis is available under [the PHP License, version 3.01](http://www.php.net/license/3_01.txt).
