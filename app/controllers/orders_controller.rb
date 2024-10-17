class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :tp_index

  def index
    @item = Item.find(params[:item_id])
    @user_order = UserOrder.new
  end

  def new
  end

  def create
    @user_order = UserOrder.new(order_params)
    if @user_order.valid?
      @user_order.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:user_order).permit(:city, :post_code, :prefecture_id, :house_number, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id]
    )
  end

  def tp_index
    item = Item.find(params[:item_id])
    redirect_to action: :index unless current_user.id == @item.user_id
  end
end
