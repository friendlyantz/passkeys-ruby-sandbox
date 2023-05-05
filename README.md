# Action Plan

- [x]  WIP(non-passkeys): Implement password suggestion field via html
- [ ] Rails app with passkeys(ideally with fingerprints via platform auth)
  - <https://github.com/cedarcode/webauthn-ruby>
  - <https://github.com/cedarcode/webauthn-rails-demo-app>
- [ ] Implement passkeys in Rack / Sinatra
- [ ] add uniq validation on device_id ([refer this](https://stackoverflow.com/a/57239573/1564635)])
- [ ] OPTIONAL: 2fa using passkeys
- [ ] OPTIONAL: legacy app

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


----

# Rails

## Gist
Registrations (User Controller) -> Credential Controller -> Credential Model -> User Model -> Session Controller -> Home Controller

JavaScript is a must for WebAuthn
optional to consider [@github/webauthn-json](https://github.com/github/webauthn-json)

## Rails new; rails scaffold

```sh
rails new \
  --database postgresql \
  new_app_name \
```

## add webauthn gem

```ruby
# add to gemfile
gem 'webauthn'
```

```sh
touch config/initializers/webauthn.rb
```

```ruby
# config/initializers/webauthn.rb
WebAuthn.configure do |config|
  config.origin = "https://localhost:3000"
end
```

## Registrations controller

```sh
rails g controller registrations new
```

```ruby
# config/routes.rb
Rails.application.routes.draw do
  get 'registrations/new'
  root 'registrations#new'
end
```

```ruby
# View app/views/registrations/new.html.erb
<%= form_with url: registrations_new_path do |form| %>
  <%= form.text_field :username %>
  <%= form.text_field :nickname %>
  <%= form.submit 'Sign Up' %>
<% end %>
```

```ruby
# app/controllers/registrations_controller.rb
class RegistrationsController < ApplicationController
  def new
    # blank in example
    # @registration = WebAuthn::Credential.options_for_create
  end
end
```

---

## Add user model

```sh
rails g model user username:string nickname:string
rails db:migrate
```

```ruby
# app/models/user.rb
class User < ApplicationRecord
  # def webauthn_id
    # blank in example
  # end
end
```

---

## Add credential model

```sh
# sign count is optional
rails g model credential user:references name:string public_key:string
rails db:migrate
```

## Add credential controller

```sh
rails g controller credentials
```

```ruby
# config/routes.rb
Rails.application.routes.draw do
  get 'registrations/new'
  root 'registrations#new'
  resources :credentials, only: [:create]
end
```

```ruby
# app/controllers/credentials_controller.rb
def create
  user = User.new(...)

  options = WebAuthn::Credential.options_for_create(...)

  if user.valid?
    session[:current_registration] = { challenge: options.challenge }

    respond_to do |format|
      format.json { render json: options }
    end
  end
end
```



## Credential concept

<!-- TODO -->

## User concept
- perhaps should have a `name` / `nickname`
- must have  a `t.string "webauthn_id"`

webauthn_id is a unique identifier for a user's device. It is used to identify a user's device when they log in. It is not a secret, and it is not used to authenticate a user. It is simply a unique identifier for a device.

generate it via
```ruby
  after_initialize do
    self.webauthn_id ||= WebAuthn.generate_user_id
  end
```

---


<!-- TODO -->

---

## create concept of a `session` controller

```sh
rails g controller session new
# it will have new / create / callback for WebAuthn with it's logig from the docs as well as destroy
```

## create concept of `current_user`, i.e. in Apps in this case

```ruby
class ApplicationController < ActionController::Base
  helper_method :current_user

  private

  def current_user
    @current_user ||=
      if session[:user_id]
        User.find_by(id: session[:user_id])
      end
  end
end
```

## Home controller, root to it, enforce current user before action check

```sh
rails g controller home index
```

```ruby
class HomeController < ApplicationController
  before_action :authenticate_user!

  def enforce_current_user
    return unless current_user.blank?

    redirect_to new_session_path
  end
end
```
