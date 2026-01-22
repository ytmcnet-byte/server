#!/bin/bash
source server-installer/common.sh
server_name
select_ram
select_cpu

VERSIONS="1.20.6 1.20.4 1.20.1 1.19.4 1.18.2"

echo "Select Spigot Version:"
select VERSION in $VERSIONS; do break; done

wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
java -jar BuildTools.jar --rev $VERSION

mv spigot-*.jar spigot.jar
echo "eula=true" > eula.txt

cat <<EOF > start.sh
java -Xms$RAM -Xmx$RAM -jar spigot.jar nogui
EOF

chmod +x start.sh
echo "Spigot server created!"
