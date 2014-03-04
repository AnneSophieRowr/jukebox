class ParametersController < ApplicationController
  include Concerns::Synchronize
  before_action :set_parameter, only: [:show, :edit, :update, :destroy]

  def index
    @parameters = Kaminari.paginate_array(ParameterDecorator.decorate_collection(Parameter.all)).page(params[:page])
  end

  def new
    @parameter = Parameter.new
  end

  def edit
  end

  def create
    @parameter = Parameter.new(parameter_params)

    respond_to do |format|
      if @parameter.save
        format.html { redirect_to parameters_path, notice: t('parameter.create', name: @parameter.name) }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @parameter.update(parameter_params)
        format.html { redirect_to parameters_path, notice: t('parameter.update', name: @parameter.name) }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
  name = @parameter.name
    @parameter.destroy
      respond_to do |format|
      format.html { redirect_to parameters_url, notice: t('parameter.destroyed', name: name) }
    end
  end

  private
  def set_parameter
    @parameter = Parameter.find(params[:id])
  end

  def parameter_params
    params.require(:parameter).permit(:name, :value)
  end

end
