#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Получаем имя сети, к которой вы подключены
wifi_name=$(iwgetid -r)

# Получаем количество подключенных пользователей
connected_users=$(sudo iw dev | grep -A 4 $wifi_name | grep -oP '(\d+) clients' | grep -oP '(\d+)')

# Получаем пароль Wi-Fi сети
wifi_password=$(sudo cat /etc/NetworkManager/system-connections/$wifi_name.nmconnection | grep -oP 'psk=(.+)' | cut -d'=' -f2)

# Получаем MAC-адрес вашего устройства
mac_address=$(ip link | grep ether | awk '{print $2}')

# Хешируем MAC-адрес
hashed_mac=$(echo -n $mac_address | md5sum | awk '{print $1}')

# Выводим результаты
echo -e "${BLUE}Wi-Fi сеть: $wifi_name ${NC}"
echo -e "${BLUE}Количество подключенных пользователей: $connected_users${NC}"
echo -e "${RED}Пароль Wi-Fi сети: $wifi_password ${NC}"
echo -e "${BLUE}MAC-адрес вашего устройства: $mac_address ${NC}"
echo -e "${BLUE}Хешированный MAC-адрес: $hashed_mac ${NC}"