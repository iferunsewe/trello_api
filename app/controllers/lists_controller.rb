class ListsController < ApplicationController
  before_action :set_list, only: [:show, :update, :destroy]

  def index
    @lists = List.all
    render json: @lists, status: :ok
  end

  def show
    render json: @list, status: :ok
  end

  def create
    @list = List.create!(list_params)
    render json: @list, status: :created
  end

  def update
    @list.update(list_params)
    render json: @list, status: :ok
  end

  def destroy
    @list.destroy
    head :no_content
  end

  private

  def list_params
    params.permit(:name)
  end

  def set_list
    @list = List.find(params[:id])
  end
end
