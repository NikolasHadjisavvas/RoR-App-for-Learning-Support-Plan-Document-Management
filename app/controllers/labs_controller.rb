##
# Deals with requests and responses from pages involving labs.
#
# @authors C.Howkins, A.Lieu
#
class LabsController < ApplicationController
  before_action :set_lab, only: [:show, :edit, :update, :destroy]
  authorize_resource

  include StudentsHelper

  # GET /labs
  def index
    session[:return_to] = request.env['PATH_INFO']
    if current_user.lab_technician?
      @pagy, @labs = pagy(Lab.where(user_id: current_user.id))
    else
      @pagy, @labs = pagy(Lab.all)
    end
    @pagy, @labs = pagy(@labs.order(startdate: :asc))
  end

  # GET /labs/1
  def show
    session[:return_to] = request.env['PATH_INFO']
    student_ids = LabsStudent.where(lab_id: @lab.eventId).pluck(:student_id)
    modules = UniModule.where(id: (LabsUniModule.where(lab_id: @lab.eventId).pluck(:uni_module_id))).pluck(:modCode).join('/')
    date = @lab.startdate.localtime.strftime('%a, %d %b %Y')
    start_time = @lab.startdate.strftime('%H:%M')
    finish_time = @lab.finishdate.strftime('%H:%M')
    session[:return_id] = @lab.eventId
    session[:return_id_title] = modules+' - Lab '+@lab.eventId.to_s
    session[:return_id_subtitle1] = date+' - Starts at: '+start_time+', Finishes at: '+finish_time
    session[:return_id_subtitle2] = @lab.room+' - '+@lab.roomname
    @students = Student.where(regNo: student_ids)
    @pagy, @students_with_lsps = pagy_array(sortStudents(@students))
    render "students/index"
  end

  # GET /labs/new
  def new
    @lab = Lab.new
  end

  # GET /labs/1/edit
  def edit
  end

  # POST /labs
  def create
    params = lab_params
    @lab = Lab.new(lab_params)
    @lab.startdate = DateTime.parse([ params[:date], params[:start_time] ].join(' '))
    @lab.finishdate = DateTime.parse([ params[:date], params[:finish_time] ].join(' '))
    @lab.day = @lab.startdate.strftime("%A")

    if @lab.save
      redirect_to @lab, notice: 'Lab was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /labs/1
  def update
    params = lab_params
    @lab.startdate = DateTime.parse([ params[:date], params[:start_time] ].join(' '))
    @lab.finishdate = DateTime.parse([ params[:date], params[:finish_time] ].join(' '))
    @lab.day = @lab.startdate.strftime("%A")
    if @lab.update(lab_params)
      redirect_to @lab, notice: 'Lab was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /labs/1
  def destroy
    @lab.destroy
    redirect_to labs_url, notice: 'Lab was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lab
      @lab = Lab.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def lab_params
      params.require(:lab).permit(:eventId, :day, :room, :roomname, :date, :start_time, :finish_time, :user_id, uni_module_ids: [], student_ids: [])
    end
end
