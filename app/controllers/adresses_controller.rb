class AddressesController < ApplicationController
  def index
    @addresses = Address.includes(:user)
  end

  def show
    @address = Address.find(params[:id])
  end
end
