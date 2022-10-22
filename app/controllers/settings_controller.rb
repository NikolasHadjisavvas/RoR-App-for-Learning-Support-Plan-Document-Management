class SettingsController < ApplicationController
    #before_action :set_lsp, only: [:show, :edit, :update, :destroy]
    #authorize_resource
  
  
    # GET /settings
    def index
        @user = current_user
        session[:return_to] = request.env['PATH_INFO']
    end

    def update
    end

    def create
        redirect_to settings_path
    end

    def destroy
        redirect_to settings_path
    end

end
