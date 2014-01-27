class TypesController < ApplicationController
  before_action :set_type, only: [:show, :edit, :update, :destroy]

  def index
    @types = Type.all
  end

  def new
    @type = Type.new
  end

  def edit
  end

  def create
    @type = Type.new(type_params)

    respond_to do |format|
      if @type.save
        format.html { redirect_to types_path, notice: t('type.create', name: @type.name) }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @type.update(type_params)
        format.html { redirect_to types_path, notice: t('type.update', name: @type.name) }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
  name = @type.name
    @type.destroy
      respond_to do |format|
      format.html { redirect_to types_url, notice: t('type.destroyed', name: name) }
    end
  end

  private
  def set_type
    @type = Type.find(params[:id])
  end

  def type_params
    params.require(:type).permit(:name)
  end

end
