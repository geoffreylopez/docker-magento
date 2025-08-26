# Docker-compose Magento 2

This repository contains a Docker Compose configuration for setting up a new Magento 2 development environment. 
It includes services for the web server, database, and other necessary components.

It includes the following services:
- **Web Server**: Nginx
- **Database**: MariaDB
- **PHP**: PHP-FPM with necessary extensions for Magento 2
- **Redis**: For caching and session storage
- **Opensearch**: For search functionality
- **Mailhog**: For capturing outgoing emails during development
- **Varnish**: For caching HTTP requests

## How it works
1. Clone the repository to your local machine.
2. Navigate to the .docker directory.
3. Run `docker-compose up -d` to start the services.
4. Access the Magento 2 by navigating to `http://localhost` in your web browser.
