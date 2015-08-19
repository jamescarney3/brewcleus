class Api::BatchesController < ApplicationController

  def show
    @batch = Batch.find(params[:id])
    render :show
  end

end
