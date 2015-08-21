class Api::RecipeIngredientsController < ApplicationController

  def show
    @recipe_ingredient = RecipeIngredient.find(params[:id])
    render :show
  end

  def destroy
    @recipe_ingredient = RecipeIngredient.find(params[:id])
    @recipe_ingredient.destroy
    render json: @recipe_ingredient
  end

end
