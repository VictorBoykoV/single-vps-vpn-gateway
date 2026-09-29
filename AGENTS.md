# Public template rules

Keep the repository provider and location neutral. Never commit real server addresses, usernames, passwords, certificates, private keys, generated client profiles, or deployment logs. Verify any change to the installer against a disposable fresh Ubuntu 24.04 VPS before describing it as production-tested. Preserve the fresh-install guard and private-only DNS/dashboard binding. Do not treat a successful server-side check as proof that a client network can reach IKEv2 or that a device has no IPv6/DNS leak.
