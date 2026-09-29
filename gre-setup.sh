#!/bin/bash

# ==============================
#        GRE Tunnel Manager
# ==============================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m'
BOLD='\033[1m'

# Check root
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}Error: This script must be run as root${NC}"
   exit 1
fi

clear

echo -e "${CYAN}"
echo "╔════════════════════════════════════════════╗"
echo "║         GRE Tunnel Manager v2.3            ║"
echo "║     Persistent • Key-based • Easy Setup    ║"
echo "╚════════════════════════════════════════════╝"
echo -e "${NC}"

echo -e "${BOLD}Please select an option:${NC}"
echo
echo -e "  ${GREEN}1)${NC}  Setup GRE Tunnel  ${YELLOW}→ Iran Server${NC}"
echo -e "  ${GREEN}2)${NC}  Setup GRE Tunnel  ${YELLOW}→ Outside Server (with Key)${NC}"
echo -e "  ${RED}3)${NC}  Complete Remove   ${YELLOW}→ Delete everything${NC}"
echo
echo -n -e "${BOLD}Enter your choice [1-3]: ${NC}"
read choice

# Validate IP
validate_ip() {
    local ip=$1
    [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]
}

# Create simple encrypted key
generate_key() {
    local local_ip=$1
    local remote_ip=$2
    echo -n "${local_ip}|${remote_ip}|GRE2025" | base64 | sed 's/+/-/g; s/\//_/g' | rev
}

# Decode key
decode_key() {
    local key=$1
    local decoded
    decoded=$(echo "$key" | rev | sed 's/-/+/g; s/_/\//g' | base64 -d 2>/dev/null)
    
    if [[ $? -ne 0 || -z "$decoded" ]]; then
        return 1
    fi
    
    local local_ip=$(echo "$decoded" | cut -d'|' -f1)
    local remote_ip=$(echo "$decoded" | cut -d'|' -f2)
    local salt=$(echo "$decoded" | cut -d'|' -f3)
    
    if [[ "$salt" != "GRE2025" ]] || ! validate_ip "$local_ip" || ! validate_ip "$remote_ip"; then
        return 1
    fi
    
    echo "$local_ip $remote_ip"
}

# Create systemd service
create_service() {
    local local_ip=$1
    local remote_ip=$2
    local ipv6_addr=$3

    cat > /etc/systemd/system/gre1.service << EOF
[Unit]
Description=GRE Tunnel gre1
After=network-online.target
Wants=network-online.target

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/sbin/ip tunnel add gre1 mode gre local ${local_ip} remote ${remote_ip} ttl 255
ExecStart=/sbin/ip -6 addr add ${ipv6_addr}/64 dev gre1
ExecStart=/sbin/ip link set gre1 mtu 1500
ExecStart=/sbin/ip link set gre1 up
ExecStop=/sbin/ip link set gre1 down
ExecStop=/sbin/ip tunnel del gre1

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reload
    systemctl enable gre1.service > /dev/null 2>&1
    systemctl restart gre1.service
}

case $choice in
    1)
        echo
        echo -e "${CYAN}══════════════════════════════════════${NC}"
        echo -e "${BOLD}  Setting up GRE on ${YELLOW}Iran Server${NC}"
        echo -e "${CYAN}══════════════════════════════════════${NC}"
        echo

        echo -n -e "Enter ${BOLD}Iran (Local)${NC} IP: "
        read LOCAL_IP
        if ! validate_ip "$LOCAL_IP"; then
            echo -e "${RED}Invalid IP address!${NC}"
            exit 1
        fi

        echo -n -e "Enter ${BOLD}Outside (Remote)${NC} IP: "
        read REMOTE_IP
        if ! validate_ip "$REMOTE_IP"; then
            echo -e "${RED}Invalid IP address!${NC}"
            exit 1
        fi

        echo
        echo -e "${YELLOW}Creating tunnel...${NC}"
        echo -e "  Local  : ${GREEN}${LOCAL_IP}${NC}"
        echo -e "  Remote : ${GREEN}${REMOTE_IP}${NC}"
        echo -e "  IPv6   : ${GREEN}fd00:1::1/64${NC}"

        ip link set gre1 down 2>/dev/null
        ip tunnel del gre1 2>/dev/null

        create_service "$LOCAL_IP" "$REMOTE_IP" "fd00:1::1"

        KEY=$(generate_key "$LOCAL_IP" "$REMOTE_IP")

        echo
        echo -e "${GREEN}✓ GRE Tunnel successfully created and enabled!${NC}"
        echo -e "${GREEN}✓ It will persist after reboot.${NC}"
        echo
        echo -e "${PURPLE}════════════════════════════════════════${NC}"
        echo -e "${BOLD}${YELLOW}  Your Connection Key (copy this):${NC}"
        echo -e "${PURPLE}════════════════════════════════════════${NC}"
        echo
        echo -e "  ${CYAN}${KEY}${NC}"
        echo
        echo -e "${PURPLE}════════════════════════════════════════${NC}"
        echo -e "Use this key on the Outside server (Option 2)"
        echo
        echo -e "${GREEN}Destination IPv6 (Outside side): ${CYAN}fd00:1::2${NC}"
        echo
        ;;

    2)
        echo
        echo -e "${CYAN}══════════════════════════════════════${NC}"
        echo -e "${BOLD}  Setting up GRE on ${YELLOW}Outside Server${NC}"
        echo -e "${CYAN}══════════════════════════════════════${NC}"
        echo

        echo -n -e "Enter the ${BOLD}Connection Key${NC}: "
        read KEY

        DECODED=$(decode_key "$KEY")
        if [[ $? -ne 0 || -z "$DECODED" ]]; then
            echo -e "${RED}Invalid or corrupted key!${NC}"
            exit 1
        fi

        IRAN_IP=$(echo $DECODED | awk '{print $1}')
        OUTSIDE_IP=$(echo $DECODED | awk '{print $2}')

        LOCAL_IP=$OUTSIDE_IP
        REMOTE_IP=$IRAN_IP

        echo
        echo -e "${GREEN}Key successfully decoded!${NC}"
        echo -e "  Local  (Outside) : ${GREEN}${LOCAL_IP}${NC}"
        echo -e "  Remote (Iran)    : ${GREEN}${REMOTE_IP}${NC}"
        echo -e "  IPv6             : ${GREEN}fd00:1::2/64${NC}"
        echo

        echo -e "${YELLOW}Creating tunnel...${NC}"

        ip link set gre1 down 2>/dev/null
        ip tunnel del gre1 2>/dev/null

        create_service "$LOCAL_IP" "$REMOTE_IP" "fd00:1::2"

        echo
        echo -e "${GREEN}✓ GRE Tunnel successfully created and enabled!${NC}"
        echo -e "${GREEN}✓ It will persist after reboot.${NC}"
        echo

        echo -e "${YELLOW}Testing connection (4 packets)...${NC}"
        ping6 -c 4 fd00:1::1
        ;;

    3)
        echo
        echo -e "${RED}══════════════════════════════════════${NC}"
        echo -e "${BOLD}  Complete Removal of GRE Tunnel${NC}"
        echo -e "${RED}══════════════════════════════════════${NC}"
        echo

        echo -e "${YELLOW}Stopping and disabling service...${NC}"
        systemctl stop gre1.service 2>/dev/null
        systemctl disable gre1.service 2>/dev/null

        echo -e "${YELLOW}Removing service file...${NC}"
        rm -f /etc/systemd/system/gre1.service
        systemctl daemon-reload

        echo -e "${YELLOW}Deleting tunnel interface...${NC}"
        ip link set gre1 down 2>/dev/null
        ip tunnel del gre1 2>/dev/null
        ip link delete gre1 2>/dev/null

        echo
        echo -e "${GREEN}✓ GRE Tunnel completely removed.${NC}"
        echo -e "${GREEN}✓ No residual files or interfaces left.${NC}"
        ;;

    *)
        echo -e "${RED}Invalid option!${NC}"
        exit 1
        ;;
esac

echo
echo -e "${CYAN}Done.${NC}"
