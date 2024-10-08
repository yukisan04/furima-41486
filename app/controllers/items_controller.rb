class ItemsController < ApplicationController
  def index
  end
  def destroy
    @item.destroy
    redirect_to action: :index
  end
end
