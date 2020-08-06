class BabiesController < ApplicationController
  #before_action :set_baby, only: [:show, :edit, :update, :destroy]

  # GET /babies
  # GET /babies.json
  def index
    @babies = Baby.all
  end

  # GET /babies/1
  # GET /babies/1.json
  def show
    @baby = Baby.find params[:id]
  end

  # GET /babies/new
  def new
    @baby = Baby.new
    #3.times {@building.apartments.build}
    @baby.breast_feedings.build
    # Esto crea una nueva instancia de Baby y 1 instancias de Breast_feedings que pertenecen al Baby.
  end

  # GET /babies/1/edit
  def edit
    @baby = Baby.find params[:id]
  end

  # POST /babies
  # POST /babies.json
  def create
    @baby = Baby.new(baby_params)
    if @baby.save
     redirect_to baby_path(@baby)
    else
     render ‘new’
    end
  end

  # PATCH/PUT /babies/1
  # PATCH/PUT /babies/1.json
  def update
    @baby = Baby.find params[:id]
    respond_to do |format|
      if @baby.update_attributes(baby_params)
        format.html { redirect_to baby_path(@baby), notice: 'Bebe se actualizo correctamente.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /babies/1
  # DELETE /babies/1.json
  def destroy
    @baby = Baby.find params[:id]
    @baby.destroy
    respond_to do |format|
      format.html { redirect_to babies_url, notice: 'Bebe fue Destruido correctamente.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    #def set_baby
    #  @baby = Baby.find(params[:id])
    #end

    # Only allow a list of trusted parameters through.
    def baby_params
      # Esto permite que los atributos de amamantamiento sean guardados.
      # El parametró destroy  nos permite eliminar un amamantmiento cuando se enviar el formulario.
      params.require(:baby).permit(:name, :photo, apartments_attributes: [:id, :duration, :quantity, :_destroy])
    end
end
