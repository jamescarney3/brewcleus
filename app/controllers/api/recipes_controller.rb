class Api::RecipesController < ApplicationController

  wrap_parameters false

  def show
    @recipe = Recipe.find(params[:id])
    render :show
  end

  def verify_author
    @recipe = Recipe.find(params[:id])
    render :author_id
  end

end
