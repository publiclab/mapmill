class SitetmpsController < ApplicationController
  before_action :set_sitetmp, only: [:show, :edit, :update, :destroy]

  # GET /sitetmps
  # GET /sitetmps.json
  def index
    @sitetmps = Sitetmp.all
  end

  # GET /sitetmps/1
  # GET /sitetmps/1.json
  def show
  end

  # GET /sitetmps/new
  def new
    @sitetmp = Sitetmp.new
  end

  # GET /sitetmps/1/edit
  def edit
  end

  # POST /sitetmps
  # POST /sitetmps.json
  def create
    @sitetmp = Sitetmp.new(sitetmp_params)

    respond_to do |format|
      if @sitetmp.save
        format.html { redirect_to @sitetmp, notice: 'Sitetmp was successfully created.' }
        format.json { render :show, status: :created, location: @sitetmp }
      else
        format.html { render :new }
        format.json { render json: @sitetmp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sitetmps/1
  # PATCH/PUT /sitetmps/1.json
  def update
    respond_to do |format|
      if @sitetmp.update(sitetmp_params)
        format.html { redirect_to @sitetmp, notice: 'Sitetmp was successfully updated.' }
        format.json { render :show, status: :ok, location: @sitetmp }
      else
        format.html { render :edit }
        format.json { render json: @sitetmp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sitetmps/1
  # DELETE /sitetmps/1.json
  def destroy
    @sitetmp.destroy
    respond_to do |format|
      format.html { redirect_to sitetmps_url, notice: 'Sitetmp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sitetmp
      @sitetmp = Sitetmp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sitetmp_params
      params.require(:sitetmp).permit(:nonce)
    end
end
