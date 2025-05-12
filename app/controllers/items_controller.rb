class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.all.order(created_at: :desc)

    return unless Rails.env.production?

    Rails.logger.info "【本番デバッグ】Item.count = #{Item.count}"
    Rails.logger.info "【本番デバッグ】最新商品名: #{Item.last&.name}"
    Rails.logger.info "【本番デバッグ】画像添付あり？: #{Item.last&.image&.attached?}"
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to root_path, notice: '商品を投稿しました'
    else
      Rails.logger.info "出品失敗: #{@item.errors.full_messages}"
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :name, :description, :category_id,
      :condition_id,
      :shipping_fee_status_id, :prefecture_id,
      :scheduled_delivery_id, :price, :image
    ).merge(user_id: current_user.id)
  end
end
