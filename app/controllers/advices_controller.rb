class AdvicesController < ApplicationController
  before_action :set_advice, only: [:edit, :destroy, :update]
  before_action :authenticate_user!

  def index
    @advices = Advice.all
  end

  def new
    @advice = Advice.new
  end

  def create
    @advice = Advice.new(post_params)
    respond_to do |format|
      if @advice.save
        format.html { redirect_to advices_path, notice: 'Совет успешно создан!' }
        format.json { render :index, status: :created, location: @advice }
      else
        format.html { render :new }
        format.json { render json: @advice.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
  	respond_to do |format|
      if @advice.update_attributes(post_params)
        format.html { redirect_to advices_path, notice: 'Совет был обновлен.' }
      else
        format.html { render :edit }
        format.json { render json: @advice.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @advice.destroy!
    respond_to do |format|
      format.html { redirect_to advices_path, notice: 'Совет удален.'}
      format.json { head :no_content }
    end
  end

  private

  def post_params
    params.require(:advice).permit(:summary)
  end

  def set_advice
    @advice = Advice.find(params[:id])
  end
end