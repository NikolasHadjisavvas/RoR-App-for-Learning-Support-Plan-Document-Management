class AeasController < ApplicationController
  before_action :set_aea, only: [:show, :edit, :update, :destroy]
  authorize_resource

  # GET /aeas
  def index 
    if user_signed_in?
      if current_user.role == "DDSS" || current_user.role == "Superuser"
        @aeas = Aea.all
      elsif current_user.role == "DLO"
        reg_nos = Student.select('regNo').where(deptCode: current_user.ou)
        @aeas = Aea.where(regNo: reg_nos)
      end
    end
  end

  # GET /aeas/1
  def show
  end

  # GET /aeas/new
  def new
    @aea = Aea.new
  end

  # GET /aeas/1/edit
  def edit
  end

  # POST /aeas
  def create
    @aea = Aea.new(aea_params)

    if @aea.save
      redirect_to @aea, notice: 'Aea was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /aeas/1
  def update
    if @aea.update(aea_params)
      redirect_to @aea, notice: 'Aea was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /aeas/1
  def destroy
    @aea.destroy
    redirect_to aeas_url, notice: 'Aea was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aea
      @aea = Aea.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def aea_params
      params.require(:aea).permit(:regNo, :requirements, :other, :information, :illness, :consent, :duration, :additional)
    end
end
