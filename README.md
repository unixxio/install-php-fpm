# Install PHP-FPM
**Last Update**: November 22, 2021

This installer should work on any Debian based OS. This also includes Ubuntu. If a certain PHP-FPM version is already installed, it will abort installation.

**Install CURL first**
```
apt-get install curl -y
```

### Run the installer with the following command
```
bash <( curl -sSL https://raw.githubusercontent.com/unixxio/install-php-fpm/main/install-php-fpm.sh )
```

**Requirements**
* Execute as root

**What does it do**
* Install PHP for PHP-FPM

**Supported versions**
* PHP 7.2
* PHP 7.3
* PHP 7.4
* PHP 8.0

**PHP-FPM Commands**

You can change `8.0` to `7.2` for example if you wish to check other versions.

PHP-FPM status
```
systemctl status php8.0-fpm.service
```
Stop PHP-FPM
```
systemctl stop php8.0-fpm.service
```
Start PHP-FPM
```
systemctl start php8.0-fpm.service
```
Reload PHP-FPM
```
systemctl reload php8.0-fpm.service
```
Check PHP version
```
/usr/bin/php8.0 -v
```
Check system default PHP version
```
php -v
```
Check php.ini location
```
/usr/bin/php8.0 -i | grep "Loaded Configuration File"
```

**Tested on**
* Debian 10 Buster
* Debian 11 Bullseye

## Support
Feel free to [buy me a beer](https://paypal.me/sonnymeijer)! ;-)

## DISCLAIMER
Use at your own risk and always make sure you have backups!
