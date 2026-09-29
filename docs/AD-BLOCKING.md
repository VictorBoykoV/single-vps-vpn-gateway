# YouTube and client-side ad blocking

AdGuard Home filters **DNS names** for all VPN clients. YouTube frequently delivers ads and videos through the same domains, so DNS cannot reliably distinguish the two. The AdGuard Home team [lists YouTube ads as a DNS-blocking limitation](https://github.com/AdguardTeam/AdGuardHome/wiki/FAQ#are-there-any-known-limitations). This repository does not offer a “block YouTube ads” server switch or a special YouTube DNS list, because either would promise a result the VPS cannot provide.

The practical arrangement is to keep AdGuard Home for ordinary ad and tracker domains and add a **browser content blocker on the device** used for YouTube:

| Where you watch | Option alongside this StrongSwan VPN | Scope |
|---|---|---|
| Android phone | Watch `youtube.com` in [Firefox for Android](https://www.mozilla.org/firefox/browsers/mobile/android/) with [uBlock Origin from Mozilla Add-ons](https://addons.mozilla.org/android/addon/ublock-origin/) | Browser pages only; the native YouTube app is separate. |
| iPhone or iPad | Watch `youtube.com` in Safari with the [AdGuard Safari extension](https://adguard.com/en/support/adguard_for_ios/doesnt_block_ads/in_youtube.html) enabled | Safari pages only; follow AdGuard's current setup guide. |
| Desktop | Use a maintained browser content blocker in the browser used for `youtube.com` | Browser pages only. |
| Native YouTube app or TV | [YouTube Premium](https://support.google.com/youtube/answer/10159588) is the official cross-device ad-free option | Applies to the signed-in account on supported devices. |

Content blocking depends on the browser and YouTube's current delivery methods, so it cannot be guaranteed permanently. It may occasionally interfere with playback.

## Change DNS blocking strength

While connected to the VPN, open the private AdGuard Home dashboard address from the README. Go to **Filters → DNS blocklists → Add blocklist → Add a custom list**. The included AdGuard DNS filter already blocks many ad and tracker domains. For stronger filtering, add one [HaGeZi Multi](https://github.com/hagezi/dns-blocklists) list in Adblock format:

- **Pro:** `https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/pro.txt` — stronger coverage with a lower risk of broken sites.
- **Pro++:** `https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/pro.plus.txt` — more aggressive, with a greater chance of blocking something a site needs.

Pick one Multi tier; the tiers build on each other. If a website stops working, disable the newly added list to compare, then use **Filters → Check the filtering** for its domain and add a narrow exception under **Filters → DNS allowlists** if needed. The query log is disabled by default for privacy. More DNS lists still cannot reliably remove YouTube in-video ads.

**Android VPN conflict:** AdGuard's full Android app normally uses a local VPN to filter traffic. [AdGuard states that Android cannot run two VPN-based apps simultaneously](https://adguard.com/en/support/adguard_for_android/doesnt_work_as_intended/protection_turns_off/other_vpn.html). Do not replace the StrongSwan connection with that local VPN expecting both protections to remain active. A browser extension such as uBlock Origin does not need a second VPN and can be used while StrongSwan stays connected.
