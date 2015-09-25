class Api::RecipesController < ApplicationController

  wrap_parameters false

  before_filter :require_author_signed_in, only: [:update, :destroy]

  def index
    @recipes = Recipe.all.order(:created_at).reverse_order.page(1)
    render :index
  end

  #deal with ordering results, pagination when you implement pg_search stuff

  def show
    @recipe = Recipe.find(params[:id])
    render :show
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.author_id = current_user.id
    if @recipe.save
      render :show
    else
      render json: @recipe.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update(recipe_params)
    @recipe.image = nil if params[:delete_image]
    if @recipe.save
      render :show
    else
      render json: @recipe.errors.full_messages, status: :unprocessable_entity
    end
  end

  def random
    ids = Recipe.all.pluck("id").sample(params[:num].to_i)
    @recipes = Recipe.find(ids).shuffle
    render :random
  end

  def verify_author
    @recipe = Recipe.find(params[:id])
    render :author_id
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :style, :yield, :original_grav,
      :final_grav, :ibus, :description, :author_id, :image)
  end

  def require_author_signed_in
    unless recipe_params[:author_id].to_i == current_user.id
      render json: "User not authorized to change this recipe", status: :unauthorized
    end
  end

end
