##
# Deals with page redirection depending on a user's role.
# 
# @authors C.Howkins, A.Lieu
# 
class PagesController < ApplicationController
  
  def home
    @current_nav_identifier = :home
  end

  # GET /
  ##
  # Redirects you to a page depending on your current role.
  #
  def index
    if current_user.role == 'Superuser'
      redirect_to '/users'
    elsif current_user.role == 'DDSS'
      redirect_to '/users'
    elsif current_user.role == 'DLO'
      redirect_to '/students'
    elsif current_user.role == 'Lab Technician'
      redirect_to '/students'
    elsif current_user.role == 'Academic'
      redirect_to '/students'
    else
      redirect_to '/no_role'
    end
  end

end
