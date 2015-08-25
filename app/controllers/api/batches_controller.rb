class Api::BatchesController < ApplicationController

  # before_filter :require_signed_in, only: [:create, :update, :destroy] <--- write this helper method in app controller
  # before_filter :require_author_signed_in, only: [:update, :destroy] <-- ditto for this, adapt from method in recipecontroller

  def show
    @batch = Batch.find(params[:id])
    render :show
  end

  def create
    @batch = Batch.new(batch_params)
    @batch.user_id = current_user.id

    if @batch.save
      render :show
    else
      render json: @batch.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def batch_params
    params.require(:batch).permit(:user_id, :recipe_id, :brew_date, :rating,
      :yield, :original_grav, :final_grav, :bottle_date, :procedure_notes,
      :comments)
  end

end
