class TypeObjsController < ApplicationController
  before_action :set_type_obj, only: [:show, :edit, :update, :destroy]

  # GET /type_objs
  # GET /type_objs.json
  def index
    @type_objs = TypeObj.all
  end

  # GET /type_objs/1
  # GET /type_objs/1.json
  def show
  end

  # GET /type_objs/new
  def new
    @type_obj = TypeObj.new
  end

  # GET /type_objs/1/edit
  def edit
  end

  # POST /type_objs
  # POST /type_objs.json
  def create
    @type_obj = TypeObj.new(type_obj_params)

    respond_to do |format|
      if @type_obj.save
        format.html { redirect_to admin_path, notice: 'Type obj was successfully created.' }
        format.json { render :show, status: :created, location: @type_obj }
      else
        format.html { render :new }
        format.json { render json: @type_obj.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /type_objs/1
  # PATCH/PUT /type_objs/1.json
  def update
    respond_to do |format|
      if @type_obj.update(type_obj_params)
        format.html { redirect_to admin_path, notice: 'Type obj was successfully updated.' }
        format.json { render :show, status: :ok, location: @type_obj }
      else
        format.html { render :edit }
        format.json { render json: @type_obj.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /type_objs/1
  # DELETE /type_objs/1.json
  def destroy
    @type_obj.destroy
    respond_to do |format|
      format.html { redirect_to admin_path, notice: 'Type obj was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_type_obj
      @type_obj = TypeObj.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def type_obj_params
      params.require(:type_obj).permit(:objclass, :src, :icon_src)
    end
end
