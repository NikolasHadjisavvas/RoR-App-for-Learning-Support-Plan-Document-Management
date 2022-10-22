class FacultiesController < ApplicationController
    def index
        @faculties = Faculty.all
      end



    private
      # Only allow a trusted parameter "white list" through.
      def faculty_params
        params.require(:faculty).permit(:title)
      end     
end
