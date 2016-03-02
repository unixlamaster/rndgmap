class PoligonsController < ApplicationController
  before_action :set_poligon, only: [:show, :edit, :update, :destroy]

  # GET /poligons
  # GET /poligons.json
  def index
    @poligons = Poligon.all
  end

  def map
      @poligons = Poligon.all
  end
  # GET /poligons/1
  # GET /poligons/1.json
  def show
  end

  # GET /poligons/new
  def new
    coords = params[:poligon][:coords].gsub(/\),\(/," | ").gsub(/[\(\)]/,"")
    @poligon = Poligon.new(coords: coords)
    @areas = Area.all
  end

  # GET /poligons/1/edit
  def edit
    @areas = Area.all
  end

  # POST /poligons
  # POST /poligons.json
  def create
    @poligon = Poligon.new(poligon_params)

    respond_to do |format|
      if @poligon.save
        format.html { redirect_to admin_path, notice: 'Poligon was successfully created.' }
        format.json { render :show, status: :created, location: @poligon }
      else
        format.html { render :new }
        format.json { render json: @poligon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /poligons/1
  # PATCH/PUT /poligons/1.json
  def update
    respond_to do |format|
      if @poligon.update(poligon_params)
        format.html { redirect_to poligons_path, notice: 'Poligon was successfully updated.' }
        format.json { render :show, status: :ok, location: @poligon }
      else
        format.html { render :edit }
        format.json { render json: @poligon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /poligons/1
  # DELETE /poligons/1.json
  def destroy
    @poligon.destroy
    respond_to do |format|
      format.html { redirect_to admin_path, notice: 'Poligon was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poligon
      @poligon = Poligon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poligon_params
      params.require(:poligon).permit(:coords, :name, :url, :year, :area_id, :color)
    end
end
