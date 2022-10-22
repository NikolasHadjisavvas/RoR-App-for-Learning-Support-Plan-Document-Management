class ChangesController < ApplicationController
    before_action :set_change, only: [:show, :edit, :update, :destroy]
  
    # GET /aeas
    def index 
    end
  
    # GET /aeas/1
    def show
    end
  
    # GET /aeas/new
    def new
      @change = Change.new
    end
  
    # GET /aeas/1/edit
    def edit
    end
  
    # POST /aeas
    def create
      @change = Change.new(change_params)
  
      if @change.save
        flash.now[:alert] = 'Changed records queued for reminder.'
      end
    end
  
  
    # DELETE /aeas/1
    def destroy
      @change.destroy
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set
        @change = Change.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def change_params
        params.require(:aea).permit(:recipient, :sent)
      end
  end
  