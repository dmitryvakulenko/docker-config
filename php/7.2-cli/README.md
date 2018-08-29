# PHP 7.2-cli

Image based on [official php 7.2-cli](https://hub.docker.com/_/php/) image.

Added php extensions pdo, pdo_pgsql, gd, pcntl, curl, xml, mbstring, soap, zip, dom, intl, bcmath, gettext, redis xdebug mongodb.
Also added git, composer.

Entrypoint try to copy key from /run/secrets/git_key to /var/www/.ssh/id_rsa for simplify php package installation.
To use this feature just add to you docker-compose

    secrets:
      git_key:
        file: '${HOME}/.ssh/id_rsa'
        
Timezone set to Europe/Moscow