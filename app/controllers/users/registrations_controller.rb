# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @user = User.new
  end

  # def create
  # @user = User.new(sign_up_params)
  # if @user.save
  # sign_in(:user, @user)
  # redirect_to root_path
  # else
  render :new
  # end
  # end

  def create
    @user = User.new(sign_up_params)
    begin
      @user.birth_date = Date.new(
        params[:user]['birth_date(1i)'].to_i,
        params[:user]['birth_date(2i)'].to_i,
        params[:user]['birth_date(3i)'].to_i
      )
    rescue StandardError
      @user.birth_date = nil
    end

    if @user.save
      sign_in(:user, @user)
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(
      :nickname, :email, :password, :password_confirmation,
      :last_name, :first_name,
      :last_name_kana, :first_name_kana,
      :birth_date
    )
  end
end
