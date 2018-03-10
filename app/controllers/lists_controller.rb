class ListsController < ApplicationController
  def index
    @lists = List.all
    render json: @lists, status: :ok
  end

  def show
    @list = List.find(params[:id])
    render json: @list, status: :ok
  end
end
