class Api::RecipeIngredientsController < ApplicationController

  def show
    @recipe_ingredient = RecipeIngredient.find(params[:id])
    render :show
  end

end
