##
# Deals with requests and responses from pages involving students.
# 
# @authors C.Howkins, A.Lieu
# 
class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  authorize_resource
  include ActiveModel::Dirty


  include StudentsHelper

  # GET /students
  def index
    session[:return_to] = request.env['PATH_INFO'] # Used to redirect to the correct page when the back button is pressed
    @students = []
    if current_user.academic?
      @students = getAllAcademicStudents # See app/helpers/students_helper.rb for method.
    elsif current_user.superuser? || current_user.ddss?
      @students = Student.all
    elsif current_user.dlo?
      @students = Student.where(deptCode: current_user.ou)
      @students = @students + getOtherStudents # See app/helpers/students_helper.rb for method.
    elsif current_user.lab_technician?
      lab_ids = Lab.where(user_id: current_user.id).pluck(:eventId)
      student_ids = LabsStudent.where(lab_id: lab_ids).pluck(:student_id)
      @students = Student.where(regNo: student_ids)
    end
    @pagy, @students_with_lsps = pagy_array(sortStudents(@students)) # See app/helpers/students_helper.rb for method.
  end

  # GET /students/my_students
  ##
  # Renders the student index page but with a list of students belonging to the user's department.
  #
  def my_students
    session[:return_to] = request.env['PATH_INFO']
    @students = Student.where(deptCode: current_user.ou)
    @pagy, @students_with_lsps = pagy_array(sortStudents(@students))
    render :index
  end

  # GET /students/other_students
  ##
  # Renders the student index page but with a list of students taking modules belonging to the DLO's
  # department but the students do not belong to that department.
  #
  def other_students
    session[:return_to] = request.env['PATH_INFO']
    @students = getOtherStudents
    @pagy, @students_with_lsps = pagy_array(sortStudents(@students))
    render :index
  end
  
  # GET /students/1
  def show
    @lsp = Lsp.find_by_regNo(@student.regNo)
  end
  
  # GET /students/my_supervisees
  ##
  # Renders the student index page but with a list of students that are supervisees of an academic.
  #
  def my_supervisees
    session[:return_to] = request.env['PATH_INFO']
    @students = current_user.students # uses the join table students_users to retrieve all the students linked to the academic
    @pagy, @students_with_lsps = pagy_array(sortStudents(@students))
    render :index
  end

  # GET /students/my_tutees
  ##
  # Renders the student index page but with a list of students that are tutees of an academic.
  #
  def my_tutees
    session[:return_to] = request.env['PATH_INFO']
    @students = Student.where(tutor_id: current_user.id) # Returns all the students that have a matching tutor_id with the the acadmic's id.
    @pagy, @students_with_lsps = pagy_array(sortStudents(@students))
    render :index
  end


  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  def create
    @student = Student.new(student_params)
    @student.personalTutor = User.find(@student.tutor_id).fullName
    @lsp = Lsp.new(regNo: @student.regNo) # An empty LSP is created and linked to the newly created student.

    if @student.save!
      @lsp.save
      redirect_to @student, notice: 'Student was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /students/1
  def update
    if @student.update(student_params)
      #changes = @student.previous_changes
      users = myAcademics(@student)
      users.each do |user| 
        already_scheduled_reminder = Change.where(recipient: user.email, sent: "false")
        if already_scheduled_reminder.empty? then
          Change.create(recipient: user.email)
        end
      end
      redirect_to @student, notice: 'Student was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /students/1
  def destroy
    @lsp = Lsp.find_by_regNo(@student.regNo)
    if @lsp.present?
      @lsp.destroy
    end
    @student.destroy
    redirect_to students_url, notice: 'Student was successfully destroyed.'
  end

  # POST /students
  ##
  # Search for students in a restricted list which is dependent on the page being viewed.
  #
  def search
    search = "%#{params[:search][:search_for_students]}%"
    @students = Student.none
    if session[:return_to] == "/students/my_tutees"
      @students = Student.where(tutor_id: current_user.id)
    elsif session[:return_to] == "/students/my_supervisees"
      @students = current_user.students
    elsif session[:return_to] == "/students" && current_user.academic?
      @students = getAllAcademicStudents
    elsif session[:return_to] == "/uni_modules/#{session[:return_id]}"
      @module = UniModule.find(session[:return_id])
      student_ids = StudentsUniModule.where(uni_module_id: @module.id).pluck(:student_id)
      @students = Student.where(:regNo => student_ids)
    elsif session[:return_to] == "/labs/#{session[:return_id]}"
      lab = Lab.find(session[:return_id])
      student_ids = LabsStudent.where(lab_id: lab.eventId).pluck(:student_id)
      @students = Student.where(:regNo => student_ids)
    elsif session[:return_to] == "/students" && current_user.lab_technician?
      labs = Lab.where(user_id: current_user.id).pluck(:eventId)
      student_ids = LabsStudent.where(lab_id: labs).pluck(:student_id)
      @students = Student.where(:regNo => student_ids)
    else
      @students = Student.all
    end
    # @students needs to be an active record
    # Return students by matching first name, last name, or full name with search parameters within a department.
    @students = @students.where(deptCode: params[:search][:deptCode]) if params[:search][:deptCode].present?
    @students = @students.where("firstname ILIKE ? or lastname ILIKE ? or CONCAT(firstname, ' ', lastname) ILIKE ?", search, search, search) if params[:search][:search_for_students].present?
    @pagy, @students_with_lsps = pagy_array(sortStudents(@students))
    render :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def student_params
      params.require(:student).permit(:sup_email, :supervisor, :tut_email, :completion_date, :firstname, :lastname, :regNo, :programmeCode, :deptCode, :email, :personalTutor, :tutor_id, :sup_id, :periodOfStudy, :user_ids, uni_module_ids: [])
    end
end
