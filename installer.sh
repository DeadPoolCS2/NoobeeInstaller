#!/bin/sh

print_header() {
    clear
    echo "  _   _             ____            "
    echo " | \ | | ___   ___ | __ )  ___  ___ "
    echo " |  \| |/ _ \ / _ \|  _ \ / _ \/ _ \\"
    echo " | |\  | (_) | (_) | |_) |  __/  __/"
    echo " |_| \_|\___/ \___/|____/ \___|\___|"
    echo "         *Made By Akila*            "
    echo "                                    "
}

show_menu() {
    print_header
    echo "Welcome to the NooBee Theme Installer!"
    echo "Please select an option:"
    echo "1. Install Theme (Must have a fresh Panel Install)"
    echo "2. Quit"
}

install_theme() {
    print_header
    echo "Installing theme..."
    apt update
    apt install -y curl dirmngr apt-transport-https lsb-release ca-certificates
    curl -sL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key --keyring /etc/apt/trusted.gpg.d/nodesource.gpg add -
    VERSION=node_16.x
    DISTRO="$(lsb_release -s -c)"
    echo "deb https://deb.nodesource.com/$VERSION $DISTRO main" | tee /etc/apt/sources.list.d/nodesource.list
    echo "deb-src https://deb.nodesource.com/$VERSION $DISTRO main" | tee -a /etc/apt/sources.list.d/nodesource.list
    apt update
    apt install -y nodejs
    npm i -g yarn
    (
        cd /var/www/pterodactyl || return 1
        yarn
        cd ..
        wget -O Noobee_v1.zip https://akila.network/noobee/Noobee_v1.zip
        apt install -y unzip
        unzip -o Noobee_v1.zip -d temp_dir
        cp -r -f temp_dir/pterodactyl/. /var/www/pterodactyl/
        rm -rf temp_dir
        cd /var/www/pterodactyl || return 1
        yarn build:production
        php artisan view:clear
        echo "Theme installation completed!"
        sleep 2
    )
}

show_menu

while true; do
    read -p "Enter your choice (1-2): " choice
    echo ""
    
    case $choice in
        1)
            install_theme
            ;;
        2)
            echo "Quitting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            echo ""
            ;;
    esac
done
