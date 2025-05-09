class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item

  def index
    return unless current_user.id == @item.user_id || @item.order.present?

    redirect_to root_path

    # ここに購入フォーム用オブジェクトをインスタンス変数で設定（例：@order_address）
  end

  def create
    # 購入処理のロジック（未実装なら空でも可）
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end
end
