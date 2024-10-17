class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :tp_index, only: [:index, :create]

  def index
    @item = Item.find(params[:item_id])
    @user_order = UserOrder.new
  end

  def new
  end

  def create
    @item = Item.find(params[:item_id])
    @user_order = UserOrder.new(order_params)
    if @user_order.valid?
      @user_order.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
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
  end
end
