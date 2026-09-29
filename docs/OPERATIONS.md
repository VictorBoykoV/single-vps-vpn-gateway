# Operations

## Add or remove a VPN user

On the VPS, from the repository directory:

```bash
sudo ./scripts/manage-eap-user.sh add NEW_USERNAME
sudo ./scripts/manage-eap-user.sh remove OLD_USERNAME
```

Adding prompts twice for a password of at least 16 characters. For unattended use, supply a root-only `VPN_PASSWORD_FILE`. The helper rereads secrets without restarting active tunnels. Removing a user prevents new logins; disconnect an existing session separately if immediate revocation is needed.

## Check status

```bash
sudo ./scripts/verify.sh
sudo ipsec statusall
sudo systemctl status strongswan-starter unbound adguardhome
```

When the phone is disconnected, zero active IKE sessions is normal. The installer does not prove the phone can reach UDP 500/4500 from every network.

## Back up

Keep a root-only encrypted/offline copy of `/root/single-vps-vpn`, `/etc/ipsec.conf`, `/etc/ipsec.secrets`, `/etc/ipsec.d`, `/etc/single-vps-vpn`, `/var/lib/AdGuardHome`, `/etc/unbound/unbound.conf.d/single-vps-vpn.conf`, and the relevant systemd units. These files contain private keys and login material. Never attach an unencrypted backup to a GitHub issue or commit it.

## Updates

Apply Ubuntu security updates normally. AdGuard Home is pinned to a verified version in `scripts/install.sh`; review a new official release and its SHA-256 digests before changing those values. Back up the AdGuard config and state, replace its binary with the verified release while the service is stopped, run `--check-config`, then restart and run `scripts/verify.sh`. This installer is intentionally for fresh deployments and should not be rerun as an upgrade tool.
