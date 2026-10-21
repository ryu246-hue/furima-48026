class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :redirect_if_unavailable

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)

    unless @order_address.valid?
      render :index, status: :unprocessable_entity
      return
    end

    begin
      Payjp::Charge.create(
        amount: @item.price,
        card: @order_address.token,
        currency: 'jpy'
      )

      if @order_address.save
        redirect_to root_path
      else
        @order_address.errors.add(:base, '購入情報の保存に失敗しました')
        render :index, status: :unprocessable_entity
      end
    rescue Payjp::PayjpError
      @order_address.errors.add(:base, 'カード決済に失敗しました')
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_unavailable
    return unless @item.user_id == current_user.id || @item.order.present?

    redirect_to root_path
  end

  def order_params
    params.require(:order_address).permit(
      :postal_code,
      :prefecture_id,
      :city,
      :addresses,
      :building,
      :phone_number,
      :token
    ).merge(
      user_id: current_user.id,
      item_id: @item.id
    )
  end
end
