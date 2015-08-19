class Api::IngredientsController < ApplicationController

  def index
    @ingredients = Ingredient.all
    render :index
  end
end
