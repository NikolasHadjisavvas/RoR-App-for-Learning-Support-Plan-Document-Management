# frozen_string_literal: true

##
# Ensures all pages in the system are authorized.
#
# @authors C.Howkins, A.Lieu
#
class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    user ||= User.new

    if user.superuser?
      can :manage, :all
    elsif user.academic?
      can :manage, Department
      can :read, UniModule, users: { id: user.id } # Uses the uni_modules_users join table to see if an academic teaches a specific model.
      can :students, UniModule, users: { id: user.id }
      # Uses the students_uni_modules join table , through the uni_modules_users join table, to see if a student belongs to a module the academic teaches.
      can :read, Student, uni_modules: { users: { id: user.id }} 
      can :read, Student, users: { id: user.id }
      can :read, Student, tutor_id: user.id
      # An academic can access the my_supervisees page, where the students that can be shown are linked to the academic via the students_users join table.
      can :my_supervisees, Student, users: { id: user.id }
      can :my_tutees, Student, tutor_id: user.id
      can :search, Student
    elsif user.dlo?
      modules = UniModule.where(deptCode: user.ou).pluck(:id) # Returns a list of all the module belonging to the department of the DLO.
      # DLO can view students that take modules that belong to the DLO's department, but can only manage those that are in the same department.
      can :read, Student, students_uni_modules: { uni_module_id: modules }
      can :manage, Student, deptCode: user.ou
      departmentStudents = Student.where(deptCode: user.ou).pluck(:regNo) # Returns a list of all the registration numbers of students who are in the DLOs department.
      can :manage, Lsp, regNo: departmentStudents
      can :create, User
      can :manage, :upload
    elsif user.ddss?
      can :read, User
      can :dlo_users, User
      can :create, User
      can :search, User
      can :manage, Student
      can :manage, :upload # Allows you to authorize a controller without that controller having a model.
      can :manage, Lsp
    elsif user.lab_technician?
      labs = Lab.where(user_id: user.id).pluck(:eventId)
      can :read, Student, labs_students: { lab_id: labs }
      can :search, Student
      can :read, Lab, user_id: user.id
      # https://stackoverflow.com/questions/11256969/cancan-and-controllers-without-models
    end
  end
end
