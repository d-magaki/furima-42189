class OrdersController < ApplicationController
  before_action :authenticate_user!        # ログインしていないと購入できない
  before_action :set_item                  # 商品の取得
  before_action :redirect_if_invalid_user # 購入できない条件ならリダイレクト

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_shipping_form = OrderShippingForm.new
  end

  def create
    @order_shipping_form = OrderShippingForm.new(order_shipping_form_params)

    if @order_shipping_form.valid?
      pay_item  # クレジット決済（PAY.JP処理）
      @order_shipping_form.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_shipping_form_params
    params.require(:order_shipping_form).permit(
      :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number
    ).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_invalid_user
    if current_user.id == @item.user_id || @item.order.present?
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_shipping_form_params[:token],
      currency: 'jpy'
    ) 
  end
end
