class CardsController < ApplicationController
  def index
    @cards = Card.all
    render json: @cards, status: :ok
  end

  def show
    @card = Card.find(params[:id])
    render json: @card, status: :ok
  end
end
