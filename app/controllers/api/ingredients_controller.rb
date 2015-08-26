class Api::IngredientsController < ApplicationController

  def index
    @ingredients = Ingredient.all
    render :index
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      render json: @ingredient
    else
      render json: @ingredient.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name)
  end

end
