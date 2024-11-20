#php #installation  #php8 #apache2 #web #web-server #apache2 

# Install PHP
- Add new repo to the personal repository
```bash
sudo add-apt-repository ppa:ondrej/php # Press enter when prompted.
```
- Update to retrieve new information from the server repo.
```bash
sudo apt update
```
- Install essential PHP extensions.
```bash
sudo apt install php8.3-common php8.3-cli php8.3-fpm php8.3-{curl,bz2,mbstring,intl,xdebug,redis}
```
# Set up Apache web server
- Enable `php8.3-fpm.conf` configuration for Apache2 web server.
```bash
sudo a2enconf php8.3-fpm
```
- Also disable legacy PHP fpm versions.
```bash
sudo a2disconf php8.2-fpm # When upgrading from an older PHP version
```
- Restart Apache web server.
# Switch among many PHP versions
- Employ the `update-alternatives` command
```bash
sudo update-alternatives --config php
```
- Select an option to establish a link for `usr/bin/php` to `usr/lib/php/8.3`
