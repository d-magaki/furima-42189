class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :destroy]

  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to @item
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path, notice: "Item successfully deleted."
    else
      redirect_to item_path(@item), alert: "Failed to delete the item."
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def authorize_user
    redirect_to root_path unless current_user == @item.user
  end

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :shipping_fee_id, 
      :prefecture_id, :shipping_day_id, :price, :image
    ).merge(user_id: current_user.id)
  end
end