#!/bin/bash

# Fail on error
set -e -o pipefail -u

# Log commands
set -x

# Generate the apache2.conf, applying bash variables to the template
envsubst '${ENV_DOMAIN}' < /etc/apache2/apache2.conf.template > /etc/apache2/apache2.conf

# Launch the original entrypoint
/usr/local/bin/docker-php-entrypoint apache2-foreground

