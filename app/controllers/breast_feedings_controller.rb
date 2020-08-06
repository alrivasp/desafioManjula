class BreastFeedingsController < ApplicationController
  #before_action :set_breast_feeding, only: [:show, :edit, :update, :destroy]
  before_action :find_baby

  # GET /breast_feedings
  # GET /breast_feedings.json
  def index
    @breast_feedings = @baby.breast_feedings# Se muestran los amamantamientos asociados a este bebe
  end

  # GET /breast_feedings/1
  # GET /breast_feedings/1.json
  def show
    @breast_feeding = BreastFeeding.find(params[:id])
  end

  # GET /breast_feedings/new
  def new
    @breast_feeding = BreastFeeding.new
  end

  # GET /breast_feedings/1/edit
  def edit
    @breast_feeding = BreastFeeding.find(params[:id])
  end

  # POST /breast_feedings
  # POST /breast_feedings.json
  def create
    @breast_feeding = BreastFeeding.new(breast_feeding_params)#Strong parameters, previene ataques de mass assignment
    @breast_feeding.baby = @baby #Asignamos el bebe, ya no es necesario pasarlo en el formulario, ahora viene en la url
    respond_to do |format|
      if @breast_feeding.save
        #format.html { redirect_to baby_breast_feeding_path(@baby, @breast_feeding), notice: 'Amamantamiento fue Creado correctamente.' }
        format.html { redirect_to  baby_path(@baby), notice: 'Amamantamiento fue Creado correctamente.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /breast_feedings/1
  # PATCH/PUT /breast_feedings/1.json
  def update
    @breast_feeding = BreastFeeding.find params[:id]
    respond_to do |format|
      if @breast_feeding.update(breast_feeding_params.merge(baby: @baby))# Se añade el beb que se obtuvo en la llamada a find_baby
        format.html { redirect_to baby_path(@baby), notice: 'Amamantamiento fue Actualizado.-' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /breast_feedings/1
  # DELETE /breast_feedings/1.json
  def destroy
    @breast_feeding = BreastFeeding.find params[:id]
    @breast_feeding.destroy
    respond_to do |format| 
      #format.html { redirect_to baby_breast_feedings_url, notice: 'Amamantamiento fue Eliminado correctamente.' }
      format.html { redirect_to baby_path(@baby), notice: 'Amamantamiento fue Eliminado correctamente.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    #def set_breast_feeding
    #  @breast_feeding = BreastFeeding.find(params[:id])
    #end

    # Only allow a list of trusted parameters through.
    #def breast_feeding_params
    #  params.require(:breast_feeding).permit(:duration, :quantity, :baby_id)
    #end

    def breast_feeding_params
      params.require(:breast_feeding).permit(:duration, :quantity)
    end
  
    def find_baby
      @baby = Baby.find params[:baby_id]
    end
end
