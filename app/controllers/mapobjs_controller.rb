class MapobjsController < ApplicationController
  before_action :set_mapobj, only: [:show, :edit, :update, :destroy]

  def admin
    @mapobjs = Mapobj.all
    @type_objs = TypeObj.all
    @poligons = Poligon.all
#    format.html { render :admin }
  end

  # GET /mapobjs
  # GET /mapobjs.json
  def index
    @mapobjs = if params[:area].nil?
                 Mapobj.all
               else
                 Mapobj.where(area_id: params[:area])
               end
  end

  # GET /mapobjs/1
  # GET /mapobjs/1.json
  def show
  end

  # GET /mapobjs/new
  def new
    @mapobj = params[:mapobj].nil? ? Mapobj.new() : Mapobj.new(mapobj_params)
    @type_objs = TypeObj.all
    @areas = Area.all
  end

  # GET /mapobjs/1/edit
  def edit
    @type_objs = TypeObj.all
    @areas = Area.all
  end

  # POST /mapobjs
  # POST /mapobjs.json
  def create
    @mapobj = Mapobj.new(mapobj_params)

    respond_to do |format|
      if @mapobj.save
        format.html { redirect_to admin_path, notice: 'Mapobj was successfully created.' }
        format.json { render :show, status: :created, location: @mapobj }
      else
        format.html { render :new }
        format.json { render json: @mapobj.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mapobjs/1
  # PATCH/PUT /mapobjs/1.json
  def update
    respond_to do |format|
      if @mapobj.update(mapobj_params)
        format.html { redirect_to admin_path, notice: 'Mapobj was successfully updated.' }
        format.json { render :show, status: :ok, location: @mapobj }
      else
        format.html { render :edit }
        format.json { render json: @mapobj.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mapobjs/1
  # DELETE /mapobjs/1.json
  def destroy
    @mapobj.destroy
    respond_to do |format|
      format.html { redirect_to admin_path, notice: 'Mapobj was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mapobj
      @mapobj = Mapobj.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mapobj_params
      params.require(:mapobj).permit(:year, :type_id, :latitude, :longitude, :url, :name, :address, :area_id, :line)
    end
end
