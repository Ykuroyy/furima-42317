class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  before_action :redirect_if_sold_out, only: [:edit, :update]

  def index
    @items = Item.includes(:order).order(created_at: :desc)
  end

  def show
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to root_path, notice: '商品を投稿しました'
    else
      render :new
    end
  end



  def destroy
    @item.destroy
    redirect_to root_path
  end





  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def authorize_user
    redirect_to root_path unless current_user.id == @item.user_id
  end

  def redirect_if_sold_out
    return unless @item.order.present? && current_user.id == @item.user_id

    redirect_to root_path
  end

  def item_params
    params.require(:item).permit(
      :name, :description, :category_id,
      :condition_id,
      :shipping_fee_status_id, :prefecture_id,
      :scheduled_delivery_id, :price, :image
    ).merge(user_id: current_user.id)
  end
end
