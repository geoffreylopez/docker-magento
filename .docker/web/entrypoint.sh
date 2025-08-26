#!/bin/bash
set -e

echo "memory_limit=2G" > /usr/local/etc/php/conf.d/memory-limit.ini


cd /var/www/html

# Installer Magento si le dossier est vide
if [ ! -f "app/etc/env.php" ]; then
    echo "⚡ Installing Magento..."
    # remove existing files if any
    composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition .
    bin/magento setup:install \
        --base-url=http://localhost \
        --db-host=db \
        --db-name=magento \
        --db-user=magento \
        --db-password=magento \
        --backend-frontname=admin \
        --admin-firstname=Admin \
        --admin-lastname=User \
        --admin-email=admin@example.com \
        --admin-user=admin \
        --admin-password=Admin123! \
        --language=en_US \
        --currency=USD \
        --timezone=America/Chicago \
        --use-rewrites=1 \
        --search-engine=opensearch \
        --opensearch-host=opensearch \
        --opensearch-password=Magento2!.
    bin/magento sampledata:deploy
    bin/magento deploy:mode:set developer
fi

composer install
bin/magento setup:upgrade
bin/magento cache:flush


exec php-fpm -F