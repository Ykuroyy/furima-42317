class ItemsController < ApplicationController
  # トップページ（indexアクション）のみ、ログインなしでアクセス可能にする
  skip_before_action :authenticate_user!, only: [:index]
  before_action :authenticate_user!, only: [:new, :create]

  def index
    # 商品一覧やトップページの処理をここに書く
    @items = Item.all.order(created_at: :desc)
    # @item = Item.new
  end

  # def show
  # @item = Item.find(params[:id])
  # end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to root_path, notice: '商品を投稿しました'
    else
      puts @item.errors.full_messages
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :name, :description, :category_id, :sales_status_id,
      :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id,
      :price, :image
    ).merge(user_id: current_user.id)
  end
end
