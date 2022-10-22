##
# Deals with requests and responses from pages involving modules.
# 
# @authors C.Howkins, A.Lieu
# 
class UniModulesController < ApplicationController
  before_action :set_uni_module, only: [:show, :edit, :update, :destroy, :students]
  authorize_resource
  
  include StudentsHelper

  # GET /uni_modules
  def index
    session[:return_to] = request.env['PATH_INFO']
    if current_user.academic?
      # Returns modules that an academic is linked to using the uni_modules_users join table.
      @pagy, @uni_modules = pagy(UniModule.where(id: UniModulesUser.where(user_id: current_user.id).pluck(:uni_module_id)).order(modCode: :asc))
    else
      @pagy, @uni_modules = pagy(UniModule.order(modCode: :asc))
    end
  end

  # GET /uni_modules/1
  ##
  # Renders the student index page but with a list of students belonging to a module.
  #
  def show
    session[:return_to] = request.env['PATH_INFO'] # Used to redirect to the correct page when the back button is pressed.
    @uni_module = UniModule.find(params[:id])
    session[:return_id] = @uni_module.id # Module id required for correct redirects.
    session[:return_id_title] = @uni_module.modCode # Module code used to display it in the view for the show page.
    # Join table students_uni_modules used to find the students linked to the selected module.
    @student_ids = StudentsUniModule.where(uni_module_id: @uni_module.id).pluck(:student_id)
    @students = Student.where(:regNo => @student_ids) 
    @pagy, @students_with_lsps = pagy_array(sortStudents(@students))
    render "students/index"
  end

  # GET /uni_modules/new
  def new
    @uni_module = UniModule.new
  end

  # GET /uni_modules/1/edit
  def edit
  end

  # POST /uni_modules
  def create
    @uni_module = UniModule.new(uni_module_params)

    if @uni_module.save
      redirect_to uni_modules_path, notice: 'Uni module was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /uni_modules/1
  def update
    if @uni_module.update(uni_module_params)
      redirect_to @uni_module, notice: 'Uni module was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /uni_modules/1
  def destroy
    @uni_module.destroy
    redirect_to uni_modules_url, notice: 'Uni module was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_uni_module
      @uni_module = UniModule.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def uni_module_params
      params.require(:uni_module).permit(:id, :modCode, :deptCode, user_ids: [])
    end
end