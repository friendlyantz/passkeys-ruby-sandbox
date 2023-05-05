class RegistrationsController < ApplicationController
  def new
  end

  def create
    user = User.new(username: params[:username])
    options = WebAuthn::Credential.options_for_create(
      user: {
        id: user.webauthn_id, # id is required for user
        name: user.username, # name is required for user
      }
    )

    binding.pry
    # TODO
    
  end
end
