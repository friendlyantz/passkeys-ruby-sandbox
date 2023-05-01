# Action Plan

- [x]  WIP(non-passkeys): Implement password suggestion field via html
- [ ] Rails app with passkeys(ideally with fingerprints via platform auth)
- [ ] Implement passkeys in Rack / Sinatra
- [ ] add uniq validation on device_id ([refer this](https://stackoverflow.com/a/57239573/1564635)])

## LINKS

<https://passkeys.dev/>

<https://webauthn.me/>

<https://web.dev/passkey-registration/>

<https://passkeys.directory/>

<https://web.dev/web-otp/>


<https://web.dev/security-credential-management/>

Source: 
- <https://philna.sh/blog/2022/12/07/better-two-factor-authentication-experiences-with-web-otp/>

- [Presentation by Phil Nash: The state of passwordless auth on the web](https://www.slideshare.net/PhilNash4/the-state-of-passwordless-auth-on-the-web-256910360)

## 1. Implement password suggestion field via html

Worked in firefox and safari only for me, but in theory following browsers are supported(autocomplete is a relatevely new feature):

- Google Chrome (desktop and mobile) version 86 and later
- Mozilla Firefox (desktop and mobile) version 78 and later
- Apple Safari (desktop and mobile) version 14 and later
- Microsoft Edge (desktop and mobile) version 87 and later

in FireFox you might have to (re)enable password suggestion in browser settings(i probably disabled it by accident)
in Safari works out of the box
in Chrome it did not work without Google account, might try again later with valid account

<img width="291" alt="image" src="https://user-images.githubusercontent.com/70934030/231021495-45bcd34f-5559-47e9-ae58-31f354488ee3.png">

<img width="287" alt="image" src="https://user-images.githubusercontent.com/70934030/231021509-e406b74d-f87f-4619-ad4f-e252ad487faf.png">
