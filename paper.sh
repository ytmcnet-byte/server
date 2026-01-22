#!/bin/bash
source server-installer/common.sh
server_name
select_ram
select_cpu

VERSIONS=$(curl -s https://api.papermc.io/v2/projects/paper | \
grep -o '"versions":\[[^]]*' | sed 's/.*\[//;s/"//g' | tr ',' ' ')

echo "Select Paper Version:"
select VERSION in $VERSIONS; do break; done

BUILD=$(curl -s https://api.papermc.io/v2/projects/paper/versions/$VERSION | \
grep -o '[0-9]\+' | tail -1)

wget -O paper.jar \
https://api.papermc.io/v2/projects/paper/versions/$VERSION/builds/$BUILD/downloads/paper-$VERSION-$BUILD.jar

echo "eula=true" > eula.txt

cat <<EOF > start.sh
java -Xms$RAM -Xmx$RAM -jar paper.jar nogui
EOF

chmod +x start.sh
echo "Paper server created!"
