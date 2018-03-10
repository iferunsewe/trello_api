class ListsController < ApplicationController
  def index
    binding.pry
    @lists = List.all
    render json: @lists, status: :ok
  end
end
