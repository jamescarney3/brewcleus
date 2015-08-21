class Api::RecipeIngredientsController < ApplicationController

  wrap_parameters RecipeIngredient, include: [:ingredient_id, :recipe_id, :amount, :units]

  def show
    @recipe_ingredient = RecipeIngredient.find(params[:id])
    render :show
  end

  def update
    @recipe_ingredient = RecipeIngredient.find(params[:id])
    @recipe_ingredient.update(recipe_ingredient_params)
    if @recipe_ingredient.save
      render json: @recipe_ingredient
    else
      render json: @recipe_ingredient.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe_ingredient = RecipeIngredient.find(params[:id])
    @recipe_ingredient.destroy
    render json: @recipe_ingredient
  end

  private

  def recipe_ingredient_params
    params.require(:recipe_ingredient).permit(:ingredient_id, :recipe_id, :amount, :units)
  end

end
