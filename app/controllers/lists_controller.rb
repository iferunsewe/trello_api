class ListsController < ApplicationController
  def index
    @lists = List.all
    render json: @lists, status: :ok
  end

  def show
    @list = List.find(params[:id])
    render json: @list, status: :ok
  end

  def create
    @list = List.create!(list_params)
    render json: @list, status: :created
  end

  private

  def list_params
    params.permit(:name)
  end
end
