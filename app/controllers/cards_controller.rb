class CardsController < ApplicationController
  before_action :set_list

  def index
    @cards = @list.cards
    render json: @cards, status: :ok
  end

  def show
    @card = @list.cards.find(params[:id]) if @list
    render json: @card, status: :ok
  end

  def create
    @card = @list.cards.create!(card_params)
    render json: @card, status: :created
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def card_params
    params.permit(:title, :description, :due_date)
  end
end
