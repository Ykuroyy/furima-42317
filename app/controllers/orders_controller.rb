# app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :redirect_if_invalid_user

  def index
    gon.public_key = ENV.fetch('PAYJP_PUBLIC_KEY', nil)
    @order_shipping = OrderShipping.new
  end

  def new
  end

  def create
    @order_shipping = OrderShipping.new(order_params)
    if @order_shipping.valid?
      pay_item
      if @order_shipping.save
        redirect_to root_path
      else
        flash.now[:alert] = '保存に失敗しました'
        render :index, status: :unprocessable_entity
      end
    else
      gon.public_key = ENV.fetch('PAYJP_PUBLIC_KEY', nil)
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
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
      amount: @item.price, # 商品の値段
      card: order_params[:token],       # カードトークン
      currency: 'jpy'                   # 通貨の種類（日本円）
    )
  end
end
