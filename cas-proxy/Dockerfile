FROM php:8.3.2-apache
# NOTE: PHP is NOT required by the CAS module for Apache (libapache2-mod-auth-cas),
#       but we use it here simply so we can easily display the server side variables
#       in our sample webpage.

RUN set -x && \
    apt-get update && \
    apt-get install -y \
        # Provides mod_auth_cas used to support CAS in Apache
        # (I believe this to be the module written by Apereo (https://github.com/apereo/mod_auth_cas))
        libapache2-mod-auth-cas \
        # Provides envsubst, which is used to dynamically create the apache2.conf 
        gettext && \
    # Clean up apt cache to minimize image size
    rm -rf /var/lib/apt/lists/* && \
    # Create directory for CAS cache
    install -o www-data -g www-data -m 0750 -d /var/cache/httpd/mod_auth_cas/ && \
    # Create directory for sample webpage
    mkdir -p /usr/local/apache2/htdocs/secured-by-cas/
    
ADD apache2.conf.template /etc/apache2/apache2.conf.template
ADD index-public.php /var/www/html/index.php
ADD index-private.php /var/www/html/secured-by-cas/index.php
ADD entrypoint.sh /auth-demo-entrypoint.sh
