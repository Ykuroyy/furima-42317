class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :redirect_if_invalid_user

  def index
    @order_shipping = OrderShipping.new
    gon.public_key = ENV.fetch('PAYJP_PUBLIC_KEY', nil)
  end

  def create
    @order_shipping = OrderShipping.new(order_shipping_params)
    if @order_shipping.valid?
      pay_item
      if @order_shipping.save
        redirect_to root_path
      else
        flash.now[:alert] = '保存に失敗しました'
        gon.public_key = ENV.fetch('PAYJP_PUBLIC_KEY', nil) # JS再読み込み用
        render :index, status: :unprocessable_entity
      end
    else
      gon.public_key = ENV.fetch('PAYJP_PUBLIC_KEY', nil) # JS再読み込み用
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_shipping_params
    params.require(:order_shipping).permit(
      :postal_code, :prefecture_id, :city, :street_address,
      :building, :phone_number, :token
    ).merge(user_id: current_user.id, item_id: @item.id)
  end

  def redirect_if_invalid_user
    redirect_to root_path if current_user.id == @item.user_id || @item.order.present?
  end

  def pay_item
    Payjp.api_key = ENV.fetch('PAYJP_SECRET_KEY', nil)
    Payjp::Charge.create(
      amount: @item.price,
      card: @order_shipping.token,
      currency: 'jpy'
    )
  end
end
