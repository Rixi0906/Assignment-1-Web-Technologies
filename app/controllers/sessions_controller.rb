class SessionsController < ApplicationController
  def new
  end

  def create  
    user = User.find_by(email: params.dig(:session, :email))
    if user&.authenticate(params.dig(:session, :password))
      session[:user_rut] = user.rut
      merge_session_cart_into(user)
      redirect_to root_path, notice: "Bienvenido, #{user.name}"
    else
      flash.now[:alert] = "Email o contraseña inválidos."
      render :new, status: :unprocessable_entity
    end
  end
end
