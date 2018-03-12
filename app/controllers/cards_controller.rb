class CardsController < ApplicationController
  before_action :set_list
  before_action :set_card, only: [:show, :update, :destroy]

  def index
    @cards = @list.cards
    render json: @cards, status: :ok
  end

  def show
    render json: @card, status: :ok
  end

  def create
    @card = @list.cards.create!(card_params)
    render json: @card, status: :created
  end

  def update
    @card.update(card_params)
    render json: @card, status: :ok
  end

  def destroy
    @card.destroy
    head :no_content
  end

  def change_list
    card = Card.find(params[:id])
    card.update(list_id: params[:list_id])
    render json: card, status: :ok
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_card
    @card = @list.cards.find(params[:id]) if @list
  end

  def card_params
    params.permit(:title, :description, :due_date)
  end
end
