#!/bin/bash
clear

pause(){ read -p "Press Enter..."; }

create_server() {
clear
echo "1) Paper"
echo "2) Spigot"
echo "3) Fabric"
echo "4) Purpur"
echo "5) Velocity"
read -p "Select: " c

case $c in
  1) bash paper.sh ;;
  2) bash spigot.sh ;;
  3) bash fabric.sh ;;
  4) bash purpur.sh ;;
  5) bash velocity.sh ;;
esac
pause
}

start_server() {
clear
ls servers
read -p "Server name: " NAME
cd servers/$NAME || return

echo "1) start.sh"
echo "2) custom command"
read -p "Select: " s

[ "$s" = "1" ] && bash start.sh
[ "$s" = "2" ] && read -p "Command: " CMD && bash -c "$CMD"
pause
}

real_kvm() {
bash <(curl -s https://vps1.jishnu.fun)
pause
}

while true; do
clear
echo "===== OG SERVER MANAGER ====="
echo "1) Create Server"
echo "2) Start Server"
echo "3) Real KVM VPS"
echo "0) Exit"
read -p "Select: " o

case $o in
  1) create_server ;;
  2) start_server ;;
  3) real_kvm ;;
  0) exit ;;
esac
done
