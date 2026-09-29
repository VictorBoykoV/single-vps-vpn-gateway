#!/usr/bin/env bash
set -Eeuo pipefail
[[ $EUID -eq 0 ]] || { echo 'Run as root on the VPN server.' >&2; exit 1; }
source /etc/single-vps-vpn/network.env
for service in strongswan-starter unbound adguardhome single-vps-vpn-dns-address single-vps-vpn-firewall; do
  systemctl is-active --quiet "$service" || { echo "$service is not active" >&2; exit 1; }
done
ip address show dev lo | grep -Fq "$DNS_IP/32"
ss -tuln | grep -Fq "$DNS_IP:53"
ss -tuln | grep -Fq "$DNS_IP:3000"
ss -tuln | grep -Fq '127.0.0.1:5353'
ipsec status | grep -Fq 'ikev2-vpn'
dig +time=3 +tries=1 +short @127.0.0.1 -p 5353 example.com A | grep -Eq '^[0-9]+\.'
dig +time=3 +tries=1 +short @"$DNS_IP" example.com A | grep -Eq '^[0-9]+\.'
blocked=false
for _ in {1..20}; do
  if [[ $(dig +time=3 +tries=1 +short @"$DNS_IP" doubleclick.net A) == 0.0.0.0 ]]; then
    blocked=true; break
  fi
  sleep 2
done
[[ $blocked == true ]] || { echo 'AdGuard filter is not blocking the test domain.' >&2; exit 1; }
echo 'Server-side VPN, DNS and ad-block checks passed.'
