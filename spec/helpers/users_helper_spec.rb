require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the UsersHelper. For example:
#
# describe UsersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe UsersHelper, type: :helper do
  describe '#backLocation' do
    it 'returns the path stored in session[:return_to]' do
      session[:return_to] = "/students"
      expect(helper.backLocation).to eq("/students")
    end

    it 'returns the root path if session[:return to] is empty' do
      expect(helper.backLocation).to eq("/")
    end
  end

end
