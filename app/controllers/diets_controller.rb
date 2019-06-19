class DietsController < ApplicationController
  before_action :set_diet, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @diets = Diet.all
  end

  def show
  end

  def new
    @diet = Diet.new
  end

  def edit
  end

  def create
    @diet = Diet.new(diet_params)

    respond_to do |format|
      if @diet.save
        format.html { redirect_to diets_path, notice: 'Диета создана' }
        format.json { render :index, status: :created, location: @diet }
      else
        format.html { render :new }
        format.json { render json: @diet.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @diet.update(diet_params)
        format.html { redirect_to diets_path, notice: 'Диета обновлена' }
        format.json { render :index, status: :ok, location: @diet }
      else
        format.html { render :edit }
        format.json { render json: @diet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @diet.destroy
    respond_to do |format|
      format.html { redirect_to diets_url, notice: 'Диета удалена' }
      format.json { head :no_content }
    end
  end

  private
    def set_diet
      @diet = Diet.find(params[:id])
    end

    def diet_params
      params.require(:diet).permit(:title, :description, :cover)
    end
end