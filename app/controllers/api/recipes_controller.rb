class Api::RecipesController < ApplicationController

  wrap_parameters false

  def show
    @recipe = Recipe.find(params[:id])
    debugger
    render :show
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.author_id == current_user.id && @recipe.save
      render :show
    else
      render json: @recipe.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update(recipe_params)
    if @recipe.author_id == current_user.id && @recipe.save
      render :show
    else
      render json: @recipe.errors.full_messages, status: :unprocessable_entity
    end
  end

  def verify_author
    @recipe = Recipe.find(params[:id])
    render :author_id
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :style, :yield, :original_grav,
      :final_grav, :ibus, :description, :author_id)
  end

end
