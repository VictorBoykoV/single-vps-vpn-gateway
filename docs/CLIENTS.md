# Client setup and real-device checks

## Android strongSwan

1. Generate a `.sswan` profile as shown in the README. Import it into the official strongSwan VPN Client app.
2. Enter the EAP password when prompted. Do not embed it in the profile file.
3. Confirm the imported profile has the expected server identity and blocks IPv4 and IPv6 outside the VPN. Leave the optional 1280 MTU unset unless tests show a path-MTU problem.
4. Connect, open a normal website, then open the private AdGuard dashboard address from the README.

For YouTube in a browser, see [client-side blocking options](AD-BLOCKING.md). The VPS DNS filter does not reliably remove YouTube video ads.

## Apple and other IKEv2 clients

The Apple `.mobileconfig` generator installs the private CA and a full-tunnel IKEv2 profile without the EAP password. Review the profile before installation and enter the password on the device. For manual IKEv2 clients, use the same server address and remote identity (`SERVER_ID`), EAP username and password, and trust the generated CA certificate. Prefer full-tunnel IPv4 and IPv6 settings. Client interfaces differ; inspect their actual routes and DNS after connecting.

## Checklist

Run these checks on both Wi-Fi and mobile data, with the VPN connected:

1. A normal website loads.
2. A public IPv4 checker reports the VPS's public IPv4, rather than the phone or home network address.
3. An IPv6 checker reports no public IPv6 from the phone's original network. This release intentionally does not offer IPv6 Internet egress.
4. `http://10.254.0.1:3000` (or the configured private DNS address) opens the AdGuard login page.
5. A DNS leak checker does not show resolvers from the phone's ISP or home router. Results may show the VPS or DNS infrastructure used by recursive resolution.
6. A test ad domain such as `doubleclick.net` is blocked. Some in-app ads remain because DNS blocking does not inspect page content.

If any result is wrong, disconnect the VPN and use [troubleshooting](TROUBLESHOOTING.md) before relying on it.
