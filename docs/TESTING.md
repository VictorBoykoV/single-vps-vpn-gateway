# Tests and deployment evidence

Verified 13 October 2026 against a repurposed, owner-authorized Ubuntu 24.04 `x86_64` VPS. Real deployment addresses, credentials and logs are not public.

## Repeated installation checks

Rookstride alpha2 bundles the installer/verification scripts from gateway revision `2fc6063b7b74e15e1e24e1b69a8f1e9b228ef77a`. Those core scripts passed three consecutive app-driven gateway reset → reinstall → real IKEv2 client cycles:

| Cycle | Android | Result | Extra check |
|---|---|---|---|
| 1 | 16 / API 36 | PASS | Purged managed packages for a cold installation; deliberately planted a stale control socket. |
| 2 | 9 / API 28 | PASS | Signed app upgrade and independent installation audit. |
| 3 | 8 / API 26 | PASS | Rebooted the VPS; services, DNS, firewall and certificate recovered before the client connected. |

Every cycle checked removal of gateway data and own firewall chains, SSH preservation, loaded VPN configuration, working recursive DNS, blocked test ad DNS, suppressed AAAA answers, private DNS/dashboard binding, valid fresh certificates and absence of duplicate firewall jumps. A separate Android app verified the selected VPS IPv4 exit through a real tunnel. The literal IPv6 probe failed as expected; real IPv6-capable phone networks still require testing.

These were gateway-data resets, retaining Ubuntu and SSH. Packages were purged only in cycle 1; later cycles reused binaries while removing configuration, certificates and data. Full [scope and sanitized results](https://github.com/VictorBoykoV/rookstride/blob/main/docs/TESTING.md) are maintained with Rookstride. No claim of universal provider/network compatibility follows from these checks.

## Fixes and boundaries

The installer and verifier already include fixes discovered during earlier deployment:

- Extract the checksum-verified AdGuard archive without assuming its member names omit the `./` prefix.
- Consume full readiness-command output, avoiding `grep -q` / `pipefail` SIGPIPE false failures.
- Inspect loaded connections with `ipsec statusall`, and wait for real DNS/socket readiness after service startup.

Rookstride separately fixes management enrollment's stale VICI socket detection and removes the socket during its reviewed reset. Standalone installation does not require that helper or its statistics service.

After the three successful cycles, this repository's Android profile generator was changed to **default MTU 1280**, matching the profiles exercised by Rookstride. The generated default is checked locally; installer and firewall code were not changed after the live cycles. Rookstride's helper already exported MTU 1280, so its tested APK is unchanged by this standalone generator update.

## Repeat on your own disposable server

Run repository checks before deployment:

```bash
bash scripts/test-repository.sh
```

Install on a fresh Ubuntu 24.04 VPS, then run:

```bash
sudo ./scripts/verify.sh
sudo ipsec statusall
sudo ss -tuln
sudo openssl verify -CAfile /etc/ipsec.d/cacerts/single-vps-ca.pem \
  /etc/ipsec.d/certs/single-vps-server-cert.pem
```

Complete the [device checklist](CLIENTS.md). Repeat with explicitly reviewed Rookstride gateway resets or provider OS rebuilds, generating fresh profiles each time. Include a VPS reboot and inspect DNS/private listeners and managed firewall rules again. Never bypass the fresh-install guard to overwrite a working VPN.

Live server testing covered `x86_64`. The `aarch64` download path and Apple profile generation are supported by source/local checks but still need their own live-device/server compatibility tests. Phone-network reachability, IPv6-capable networks, disconnected lockdown and sustained load remain separate gates.
