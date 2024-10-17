class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :item_find
  before_action :tp_index, only: [:index, :create]

  def index
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
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:user_order).permit(:city, :post_code, :prefecture_id, :house_number, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id, token: params[:token]]
    )
  end

  def item_find
    @item = Item.find(params[:item_id])
  end

  def tp_index
    redirect_to root_path unless current_user.id != @item.user_id
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: order_params[:price],
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
