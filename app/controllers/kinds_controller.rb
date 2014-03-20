class KindsController < ApplicationController
  include Concerns::Synchronize
  before_action :set_kind, only: [:show, :edit, :update, :destroy]

  def index
    @kinds = Kaminari.paginate_array(KindDecorator.decorate_collection(Kind.all)).page(params[:page])
  end

  def new
    @kind = Kind.new
  end

  def edit
  end

  def create
    @kind = Kind.new(kind_params)

    respond_to do |format|
      if @kind.save
        format.html { redirect_to kinds_path, notice: t('kind.create', name: @kind.name) }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @kind.update(kind_params)
        format.html { redirect_to kinds_path, notice: t('kind.update', name: @kind.name) }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
  name = @kind.name
    @kind.destroy
      respond_to do |format|
      format.html { redirect_to kinds_url, notice: t('kind.destroyed', name: name) }
    end
  end

  private
  def set_kind
    @kind = Kind.find(params[:id])
  end

  def kind_params
    params.require(:kind).permit(:name, :image, :visible, :description)
  end

end
