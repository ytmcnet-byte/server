#!/bin/bash
source server-installer/common.sh
server_name
select_ram
select_cpu

VERSIONS=$(curl -s https://api.papermc.io/v2/projects/velocity | \
grep -o '"versions":\[[^]]*' | sed 's/.*\[//;s/"//g' | tr ',' ' ')

echo "Select Velocity Version:"
select VERSION in $VERSIONS; do break; done

BUILD=$(curl -s https://api.papermc.io/v2/projects/velocity/versions/$VERSION | \
grep -o '[0-9]\+' | tail -1)

wget -O velocity.jar \
https://api.papermc.io/v2/projects/velocity/versions/$VERSION/builds/$BUILD/downloads/velocity-$VERSION-$BUILD.jar

cat <<EOF > start.sh
java -Xms$RAM -Xmx$RAM -jar velocity.jar
EOF

chmod +x start.sh
echo "Velocity proxy created!"
