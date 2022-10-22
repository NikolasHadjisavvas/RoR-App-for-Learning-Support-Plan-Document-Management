##
# Deals with requests and responses from pages involving users.
# 
# @authors C.Howkins, A.Lieu
# 
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  authorize_resource

  # GET /users
  def index
    @pagy, @users = pagy(User.order('sn ASC'))
    session[:return_to] = request.env['PATH_INFO']
  end

  # GET /users/academic_users
  # Renders the user index page but with a list of users whose role is Academic.
  def academic_users
    session[:return_to] = request.env['PATH_INFO']
    @pagy, @users = pagy(User.where(role: "Academic").order('sn ASC'))
    render :index
  end

  # GET /users/lab_technician_users
  # Renders the user index page but with a list of users whose role is 'Lab Technician'.
  def lab_technician_users
    session[:return_to] = request.env['PATH_INFO']
    @pagy, @users = pagy(User.where(role: "Lab Technician").order('sn ASC'))
    render :index
  end

  # GET /users/dlo_users
  # Renders the user index page but with a list of users whose role is 'DLO'.
  def dlo_users
    session[:return_to] = request.env['PATH_INFO']
    @pagy, @users = pagy(User.where(role: "DLO").order('sn ASC'))
    render :index 
  end

  # GET /users/1
  def show
  end
  

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    render layout: false
  end

  # POST /users
  def create
    @user = User.new(user_params)
    @user.get_info_from_ldap
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      if session[:return_to] == "/users/academic_users" # Returns the correct group of users by role depending on what page is being viewed
        @pagy, @users = pagy(User.where(role: "Academic"))
      elsif session[:return_to] == "/users/lab_technician_users"
        @pagy, @users = pagy(User.where(role: "Lab Technician"))
      elsif session[:return_to] == "/users/dlo_users"
        @pagy, @users = pagy(User.where(role: "DLO"))
      else
        @pagy, @users = pagy(User.all)
      end
      if session[:return_to] != "/settings" 
        render 'update_success'
      else
        redirect_to :controller => 'settings', :action => 'index'
      end
    else
      if session[:return_to] != "/settings"
        render 'update_failure'
      else
        redirect_to :controller => 'settings', :action => 'index'
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    if session[:return_to] == "/users/academic_users" # Ensures the correct redirect which depends on what page is being viewed.
      redirect_to users_academic_users_path, notice: 'User was successfully destroyed.'
    elsif session[:return_to] == "/users"
      redirect_to users_url, notice: 'User was successfully destroyed.'
    elsif session[:return_to] == "/users/lab_technician_users"
      redirect_to users_lab_technician_users_path, notice: 'User was successfully destroyed.'
    elsif session[:return_to] == "/users/dlo_users"
      redirect_to users_dlo_users_path, notice: 'User was successfully destroyed.'
    end
  end

  
  # POST /users/search
  def search
    search = "%#{params[:search][:search_for_users]}%"
    # Return users by matching first name, last name, or full name with search parameters by role within a department.
    @pagy, @users = pagy(User.all)
    @pagy, @users = pagy(@users.where(ou: params[:search][:deptCode])) if params[:search][:deptCode].present?
    @pagy, @users = pagy(@users.where(role: params[:search][:role])) if params[:search][:role].present?
    @pagy, @users = pagy(@users.where("givenname ILIKE ? or sn ILIKE ? or CONCAT(givenname, ' ', sn) ILIKE ? or email ILIKE ? or username ILIKE ?", search, search, search, search, search)) if params[:search][:search_for_users].present?
    @pagy, @users = pagy(@users.order('sn ASC'))
    render :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:username, :firstName, :lastName, :email, :role, :deptCode, :ou, :givenname, :sn, :notification_freq)
    end
end
