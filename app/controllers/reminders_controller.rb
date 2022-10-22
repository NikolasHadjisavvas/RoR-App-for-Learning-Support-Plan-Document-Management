#reminders controller,including the method which takes the params in the manual emails form and sends the email

class RemindersController < ApplicationController
    before_action :set_reminder, only: [:destroy]

    include StudentsHelper


    def new
        session[:return_to] = request.env['PATH_INFO']
        @reminder = Reminder.new
        @users = nil
        if current_user.dlo?
            @users = User.where(role: 'Academic', ou: current_user.ou)
        elsif current_user.ddss?
            @users = User.where(role: 'DLO')
        else
            @users = User.all
        end
        @students = Student.where(deptCode: current_user.ou)
    end

    def create
        @reminder = Reminder.new(reminder_params)
        sender = current_user
        if @reminder.save
            recipients = Array.new
            content = @reminder.body
            toAll = @reminder.toAll

            recipient_emails = params[:user_ids]
            if not(recipient_emails.nil?)
                UserMailer.send_reminder_email(current_user,recipient_emails,content).deliver
                redirect_to backLocation, notice: 'Reminder sent.'
            else
                redirect_to backLocation, notice: 'Reminder did not send, please ensure there is at least one recipient'
            end
      
        end
    end

    def show
        session[:return_to] = request.env['PATH_INFO']
        @students = Student.where(deptCode: current_user.ou).or(getOtherStudents())
        @reminder = Reminder.new
        @student_page = true
        render :new
    end

    #manual reminders method,getting the selected reipients through the form
    #and calling user mailer to send the email.
    def send_reminder_email
        recipients = Array.new
        content = params[:send_reminder_email]
        toAll = params[:send_reminder_email][:toall]
        
        if toAll == 'false' then
            recipients_objects = params[:send_reminder_email][:recipients]
            recipients_objects.each do |obj|
                if not(User.find_by(id: obj.to_i).nil?) then
                    email = User.find_by(id: obj.to_i).email
                    recipients.push(email)
                    #Reminder.create(body: content)
                    
                end
            end
        else
            if current_user.dlo? then
                academics = @users # This was changed from User.where(role: 'Academic') because we wanted to just select all the users after a search result
                recipients = academics.pluck(:email)
            elsif current_user.ddss?
                dlos = @users
                recipients = dlos.pluck(:email)
            elsif current_user.superuser?
                recipients = @users.pluck(:email)
            end

        end

        
        sender = current_user
        UserMailer.send_reminder_email(current_user,recipients,content).deliver
        redirect_to new_reminder_path, notice: 'Reminder sent.'
    end

    def destroy
        @reminder.destroy
    end

    def search
        if current_user.dlo? && session[:return_to] == '/reminders/student_reminders'
            search = "%#{params[:search][:search_for_students]}%"
            @students = Student.where(deptCode: current_user.ou).or(getOtherStudents())
            modules_search = StudentsUniModule.where(uni_module_id: params[:search][:uni_modules]).pluck(:student_id)
            @students = @students.where(regNo: modules_search) if params[:search][:uni_modules].present?
            @students = @students.order('lastname ASC')
            @reminder = Reminder.new()
            @student_page = true
            render :new
        else
            search = "%#{params[:search][:search_for_users]}%"
            if current_user.dlo? && !@student_page
                @users = User.where(role: 'Academic', ou: current_user.ou)
            elsif current_user.ddss?
                @users = User.where(role: 'DLO')
            else
                @users = User.all
            end
            @users = @users.where(ou: params[:search][:deptCode]) if params[:search][:deptCode].present?
            modules_search = UniModulesUser.where(uni_module_id: params[:search][:uni_modules]).pluck(:user_id)
            @users = @users.where(id: modules_search) if params[:search][:uni_modules].present?
            @users = @users.where(role: params[:search][:role]) if params[:search][:role].present?
            @users = @users.order('sn ASC')
            @reminder = Reminder.new()
            render :new
        end
    end 

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_reminder
          @reminder = Reminder.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def reminder_params
          params.require(:reminder).permit(:body, :toAll, user_ids: [])
        end
    

end
