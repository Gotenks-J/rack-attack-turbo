class SessionsController < ApplicationController
  def create
    redirect_to root_url, notice: 'Yay'
  end
end
