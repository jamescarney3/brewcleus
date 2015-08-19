class Api::RecipesController < ApplicationController

  wrap_parameters false

  def show
    @recipe = Recipe.find(params[:id])
    render :show
  end

end
