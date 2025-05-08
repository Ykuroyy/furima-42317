class ItemsController < ApplicationController
  # トップページ（indexアクション）のみ、ログインなしでアクセス可能にする
  skip_before_action :authenticate_user!, only: [:index]
  before_action :authenticate_user!, only: [:new, :create]

  def index
    # 商品一覧やトップページの処理をここに書く
    @items = Item.all.order(created_at: :desc)
    @item = Item.new
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
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :image)
  end
end
