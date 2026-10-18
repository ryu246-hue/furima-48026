class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @items = Item.order(created_at: :desc)
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])

    return if @item.user_id == current_user.id

    redirect_to root_path
  end

  def update
    @item = Item.find(params[:id])

    unless @item.user_id == current_user.id
      redirect_to root_path
      return
    end

    if @item.update(item_update_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
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

  private

  def item_params
    params.require(:item).permit(
      :image,
      :name,
      :description,
      :category_id,
      :condition_id,
      :shipping_charge_id,
      :prefecture_id,
      :shipping_day_id,
      :price
    ).merge(user_id: current_user.id)
  end

  def item_update_params
    params.require(:item).permit(
      :image,
      :name,
      :description,
      :category_id,
      :condition_id,
      :shipping_charge_id,
      :prefecture_id,
      :shipping_day_id,
      :price
    )
  end
end
