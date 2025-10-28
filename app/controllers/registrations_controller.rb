class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_rut] = @user.rut
      merge_session_cart_into(@user)
      redirect_to root_path, notice: "Cuenta creada con éxito."
    else
      flash.now[:alert] = "Revisa los errores."
      render :new, status: :unprocessable_entity
    end
  end


  private

  def user_params
    params.require(:user).permit(
      :rut,                 
      :first_name,          
      :last_name,           
      :email,
      :password,
      :password_confirmation,
      :accept_terms         
    )
  end
end
