#!/bin/bash
source server-installer/common.sh
server_name
select_ram
select_cpu

VERSIONS=$(curl -s https://api.purpurmc.org/v2/purpur | \
grep -o '"versions":\[[^]]*' | sed 's/.*\[//;s/"//g' | tr ',' ' ')

echo "Select Purpur Version:"
select VERSION in $VERSIONS; do break; done

wget -O purpur.jar https://api.purpurmc.org/v2/purpur/$VERSION/latest/download
echo "eula=true" > eula.txt

cat <<EOF > start.sh
java -Xms$RAM -Xmx$RAM -jar purpur.jar nogui
EOF

chmod +x start.sh
echo "Purpur server created!"
