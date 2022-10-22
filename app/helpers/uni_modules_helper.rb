module UniModulesHelper
    def getAcademics(uni_module)
        user_ids = UniModulesUser.where(uni_module_id: uni_module.id).pluck(:user_id)
        academics = User.where(id: user_ids).where(role: "Academic")
        academic_names = []
        academics.each do |academic|
            academic_names << academic.fullName
        end
        return academic_names
    end
end