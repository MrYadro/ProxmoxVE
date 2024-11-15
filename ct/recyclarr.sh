#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/MrYadro/ProxmoxVE/dev/misc/build.func)
# Copyright (c) 2021-2024 tteck
# Author: tteck
# Co-Author: MrYadro
# License: MIT
# https://github.com/community-scripts/ProxmoxVE/raw/main/LICENSE

function header_info {
clear
cat <<"EOF"
    ____                       __               
   / __ \___  _______  _______/ /___ ___________
  / /_/ / _ \/ ___/ / / / ___/ / __ `/ ___/ ___/
 / _, _/  __/ /__/ /_/ / /__/ / /_/ / /  / /    
/_/ |_|\___/\___/\__, /\___/_/\__,_/_/  /_/     
                /____/                           
                                         
EOF
}
header_info
echo -e "Loading..."
APP="Recyclarr"
var_disk="2"
var_cpu="1"
var_ram="512"
var_os="debian"
var_version="12"
variables
color
catch_errors

function default_settings() {
  CT_TYPE="1"
  PW=""
  CT_ID=$NEXTID
  HN=$NSAPP
  DISK_SIZE="$var_disk"
  CORE_COUNT="$var_cpu"
  RAM_SIZE="$var_ram"
  BRG="vmbr0"
  NET="dhcp"
  GATE=""
  APT_CACHER=""
  APT_CACHER_IP=""
  DISABLEIP6="no"
  MTU=""
  SD=""
  NS=""
  MAC=""
  VLAN=""
  SSH="no"
  VERB="no"
  echo_default
}

function update_script() {
header_info
if [[ ! -f /root/.config/recyclarr/recyclarr.yml ]]; then msg_error "No ${APP} Installation Found!"; exit; fi
msg_info "Stopping ${APP} LXC"
systemctl stop recyclarr.service
msg_ok "Stopped ${APP} LXC"

msg_info "Updating ${APP} LXC"
rm -rf /usr/local/bin/*
wget -q $(curl -s https://api.github.com/repos/recyclarr/recyclarr/releases/latest | grep download | grep linux-x64 | cut -d\" -f4)
tar -C /usr/local/bin -xzf recyclarr*.tar.gz
rm -rf recyclarr*.tar.gz
msg_ok "Updated ${APP} LXC"

msg_info "Starting ${APP} LXC"
systemctl start recyclarr.service
msg_ok "Started ${APP} LXC"
msg_ok "Updated Successfully"
exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
echo -e "Finish installation of ${APP} by editing /root/.config/recyclarr/recylcarr.yml
         ${BL}https://recyclarr.dev/wiki/getting-started/${CL} \n"