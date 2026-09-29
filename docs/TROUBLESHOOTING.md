# Troubleshooting

## Phone says “peer not responding”

This is a transport or reachability symptom; it happens before the VPN password is checked. Verify the phone uses the intended public IP/hostname, and confirm the provider firewall allows **UDP 500 and 4500**. On the VPS, inspect `sudo ipsec statusall` and the strongSwan log while making one connection attempt. If no IKE packets arrive, changing the EAP password or DNS settings cannot fix that path. Test from Wi-Fi and mobile data; compare with ordinary HTTPS reachability only to separate a dead IP from blocked VPN UDP. HTTPS working does not prove IKEv2 is permitted.

## Authentication fails

IKE traffic reached the server. Check the EAP username, password, server identity, and CA certificate. The server identity must match the certificate subjectAltName generated from `SERVER_ID`.

## VPN connects but websites do not load

Run `sudo ./scripts/verify.sh` on the VPS. If the AdGuard page works but websites fail, check Unbound and outbound DNS from the VPS. If DNS works but large pages or video stall, try an Android profile generated with `PROFILE_MTU=1280`. Reconnect after any profile or server DNS change so the device receives the new settings.

## Unexpected location or IPv6

First verify the actual public IPv4 and IPv6 from the connected device. A service can report a different country because its IP-geolocation database is stale, or because it uses GPS, account region, SIM, cookies, or a proxy. A public IPv6 from the phone network indicates client-side bypass; inspect the profile's outside-VPN block/full-tunnel settings. No server can force routing for an app or OS path the client deliberately excludes from the VPN.

## Ads remain

Check that the device received the private DNS address and that AdGuard loaded its filter. Apps using their own encrypted DNS can bypass it. DNS filtering also cannot reliably block ads served from the same domain as content. Adjust filters in the VPN-only dashboard after backing up its configuration.
