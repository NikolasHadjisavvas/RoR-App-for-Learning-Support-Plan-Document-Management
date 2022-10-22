##
# Deals with requests and responses from pages involving LSPs.
# 
# @authors C.Howkins, A.Lieu
# 
class LspsController < ApplicationController
  before_action :set_lsp, only: [:show, :edit, :update, :destroy]
  authorize_resource

  include StudentsHelper

  include StudentsHelper


  # GET /lsps
  def index 
    if user_signed_in?
      if current_user.role == "DDSS" || current_user.role == "Superuser"
        @pagy, @lsps = pagy(Lsp.all)
      elsif current_user.role == "DLO" 
        reg_nos = Student.select('regNo').where(deptCode: current_user.ou)
        @pagy, @lsps = pagy(Lsp.where(regNo: reg_nos)) # Return only the LSPs belonging to students in the same department as a DLO
      end
    end
  end

  # GET /lsps/1
  def show
  end

  # GET /lsps/new
  def new
    @lsp = Lsp.new
  end

  # GET /lsps/1/edit
  def edit
    @student = Student.find_by_regNo(@lsp.regNo)
  end

  # POST /lsps
  def create
    @lsp = Lsp.new(lsp_params)

    if @lsp.save
      redirect_to @lsp, notice: 'Lsp was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /lsps/1
  def update
    @student = Student.find_by(regNo: @lsp.regNo)
    if @lsp.update(lsp_params)
      users = myAcademics(@student)
      users.each do |user|
        already_scheduled_reminder = Change.where(recipient: user.email, sent: "false")
        if already_scheduled_reminder.empty? then
          Change.create(recipient: user.email)
        end
      end
      redirect_to @student, notice: 'Lsp was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /lsps/1
  def destroy
    @lsp.destroy
    redirect_to lsps_url, notice: 'Lsp was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lsp
      @lsp = Lsp.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def lsp_params
      params.require(:lsp).permit(:regNo, :access, :contact, :teaching, :exams, :practicals, :circumstances, :recommendations, :timetabling, :advisor_email, :advisor_name)
    end
end
