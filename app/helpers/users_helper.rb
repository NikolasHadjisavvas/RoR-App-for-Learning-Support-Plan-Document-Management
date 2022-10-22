##
# Helper methods associated with retrieving user information.
# 
# @authors C.Howkins, A.Lieu
#
module UsersHelper
    ##
    # Used to redirect to the correct page when the back button in a view is pressed
    #
    def backLocation
        if session[:return_to].nil?
            session[:return_to] = "/"
        end
        return session[:return_to]
    end
end
