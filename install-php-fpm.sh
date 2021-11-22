#!/bin/bash

#####################################################
#                                                   #
#  Description : Install PHP-FPM from APT           #
#  Author      : Unixx.io                           #
#  E-mail      : github@unixx.io                    #
#  GitHub      : https://www.github.com/unixxio     #
#  Last Update : November 22, 2021                  #
#                                                   #
#####################################################
clear

# Variables
distro="$(lsb_release -sd | awk '{print tolower ($1)}')"
release="$(lsb_release -sc)"
version="$(lsb_release -sr)"
kernel="$(uname -r)"
uptime="$(uptime -p | cut -d " " -f2-)"
my_username="$(whoami)"
user_ip="$(who am i --ips | awk '{print $5}' | sed 's/[()]//g')"
user_hostname="$(host ${user_ip} | awk '{print $5}' | sed 's/.$//')"

packages="gnupg2 wget lsb-release ca-certificates apt-transport-https"

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Show the current logged in user
echo -e "\nHello ${my_username}, you are logged in from ${user_ip} (${user_hostname}).\n"

# Show system information
echo -e "Distribution : ${distro}"
echo -e "Release      : ${release}"
echo -e "Version      : ${version}"
echo -e "Kernel       : ${kernel}"
echo -e "Uptime       : ${uptime}"

# Choose PHP-FPM version
echo -e "\nPlease choose a PHP-FPM version to install.\n"

PS="$(echo -e "\nOption : ")"
PS3=${PS}
options=("7.2" "7.3" "7.4" "8.0" "Quit")
select php_version in "${options[@]}"
do
    case ${php_version} in
        "7.2")
            break
            ;;
        "7.3")
            break
            ;;
        "7.4")
            break
            ;;
        "8.0")
            break
            ;;
        "Quit")
            echo -e "\nYou choose to quit. Script will abort.\n"
            exit 0
            ;;
        *) echo -e "\n[ ERROR ] Invalid option $REPLY. Please choose again." ;;
    esac
done

# Set binary based on version
binary="/usr/sbin/php-fpm${php_version}"

# Install PHP-FPM
if [[ -f "${binary}" ]]; then
    # Show warning if version is already installed
    echo -e "\nThis version (php-fpm${php_version}) is already installed. Nothing to do here :-)\n"
    exit 1
else
    echo -e "\nInstalling required packages and PHP-FPM. Please wait...\n"
    # Update packages
    apt-get update > /dev/null 2>&1 && apt-get upgrade -y > /dev/null 2>&1

    # Install required packages
    apt-get install ${packages} -y > /dev/null 2>&1

    # Add APT repository
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list > /dev/null 2>&1

    # Add GPG key to OS
    wget -qO - https://packages.sury.org/php/apt.gpg | apt-key add - > /dev/null 2>&1

    # Install php-fpm
    apt-get update > /dev/null 2>&1 && apt-get install php${php_version}-fpm -y > /dev/null 2>&1
fi

# Finish script
echo -e "PHP-FPM (${php_version}) is now installed. Enjoy! ;-)\n"
exit 0
