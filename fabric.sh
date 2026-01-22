#!/bin/bash
source server-installer/common.sh
server_name
select_ram
select_cpu

VERSIONS=$(curl -s https://meta.fabricmc.net/v2/versions/game | \
grep -o '"version":"[^"]*"' | cut -d'"' -f4 | head -25)

echo "Select Fabric MC Version:"
select MC in $VERSIONS; do break; done

LOADER=$(curl -s https://meta.fabricmc.net/v2/versions/loader | \
grep -o '"version":"[^"]*"' | head -1 | cut -d'"' -f4)

wget -O fabric.jar \
https://meta.fabricmc.net/v2/versions/loader/$MC/$LOADER/1.0.1/server/jar

echo "eula=true" > eula.txt

cat <<EOF > start.sh
java -Xms$RAM -Xmx$RAM -jar fabric.jar nogui
EOF

chmod +x start.sh
echo "Fabric server created!"
