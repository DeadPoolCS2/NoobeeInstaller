#!/bin/sh

show_menu() {
    clear
    echo "  _   _             ____            "
    echo " | \ | | ___   ___ | __ )  ___  ___ "
    echo " |  \| |/ _ \ / _ \|  _ \ / _ \/ _ \\"
    echo " | |\  | (_) | (_) | |_) |  __/  __/"
    echo " |_| \_|\___/ \___/|____/ \___|\___|"
    echo "         *Made By Akila*            "
    echo "                                    "
    echo "Welcome to the NooBee Theme Installer!"
    echo "Please select an option:"
    echo "1. Install Theme (Must have a fresh Panel Install)"
    echo "2. Quit"
}

install_theme() {
    clear
    echo "  _   _             ____            "
    echo " | \ | | ___   ___ | __ )  ___  ___ "
    echo " |  \| |/ _ \ / _ \|  _ \ / _ \/ _ \\"
    echo " | |\  | (_) | (_) | |_) |  __/  __/"
    echo " |_| \_|\___/ \___/|____/ \___|\___|"
    echo "         *Made By Akila*            "
    echo "                                    "
    echo "Installing theme..."
    sudo apt update
    sudo apt install -y curl dirmngr apt-transport-https lsb-release ca-certificates
    curl -sL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key --keyring /etc/apt/trusted.gpg.d/nodesource.gpg add -
    VERSION=node_16.x
    DISTRO="$(lsb_release -s -c)"
    echo "deb https://deb.nodesource.com/$VERSION $DISTRO main" | sudo tee /etc/apt/sources.list.d/nodesource.list
    echo "deb-src https://deb.nodesource.com/$VERSION $DISTRO main" | sudo tee -a /etc/apt/sources.list.d/nodesource.list
    sudo apt update
    sudo apt install -y nodejs
    sudo npm i -g yarn
    cd /var/www/pterodactyl && {
        yarn
        cd ..
        wget https://cdn.discordapp.com/attachments/1076876649250967562/1076879105938694144/Noobee_v1.zip &&
        sudo apt install -y unzip &&
        unzip -o Noobee_v1.zip -d temp_dir &&
        sudo cp -r -f temp_dir/pterodactyl/. /var/www/pterodactyl/ &&
        sudo rm -rf temp_dir &&
        cd /var/www/pterodactyl || return 1
        yarn build:production
        php artisan view:clear
        echo "Theme installation completed!"
        sleep 2
    }
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
