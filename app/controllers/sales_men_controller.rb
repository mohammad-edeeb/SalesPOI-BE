class SalesMenController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_sales_man, only: [:show, :edit, :update, :destroy]

  # GET /sales_men
  # GET /sales_men.json
  def index
    @sales_men = SalesMan.paginate(:page => params[:page], :per_page => 20).order("username ASC")
  end

  # GET /sales_men/new
  def new
    @sales_man = SalesMan.new
  end

  # GET /sales_men/1/edit
  def edit
  end

  # POST /sales_men
  # POST /sales_men.json
  def create
    @sales_man = SalesMan.new(sales_man_params)

    respond_to do |format|
      if @sales_man.save
        format.html { redirect_to sales_men_url, notice: 'Sales man was successfully created.' }
        format.json { render :show, status: :created, location: @sales_man }
      else
        format.html { render :new }
        format.json { render json: @sales_man.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales_men/1
  # PATCH/PUT /sales_men/1.json
  def update
    respond_to do |format|
      if @sales_man.update(sales_man_params)
        @sales_man.regenerate_auth_token
        format.html { redirect_to sales_men_url, notice: 'Sales man was successfully updated.' }
        format.json { render :show, status: :ok, location: @sales_man }
      else
        format.html { render :edit }
        format.json { render json: @sales_man.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales_men/1
  # DELETE /sales_men/1.json
  def destroy
    @sales_man.destroy
    respond_to do |format|
      format.html { redirect_to sales_men_url, notice: 'Sales man was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    @sales_man_import = SalesManImport.new
  end

  def do_import
    if(!params[:sales_man_import].present?)
      @sales_man_import = SalesManImport.new
      render :import
      return
    end
    @sales_man_import = SalesManImport.new(params[:sales_man_import])
    if @sales_man_import.save
      redirect_to sales_men_url, notice: "Imported sales men successfully."
    else
      render :import
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sales_man
      @sales_man = SalesMan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sales_man_params
      params.require(:sales_man).permit(SalesMan.permitted_attrs)
    end
end
