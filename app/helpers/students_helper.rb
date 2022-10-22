##
# Helper methods associated with retrieving student information.
# 
# @authors C.Howkins, A.Lieu. Edited by: Nicolas Hadjisavvas
#
module StudentsHelper
    ##
    # Returns an array of triples which each contain an existing instance of a student, the LSP attached to
    # that student, and the date/time of when the LSP was updated. The array is ordered by the most recently
    # updated at the start.
    #
    # @params ActiveRecord Relation
    # @return Array
    #
    def sortStudents(students)
      ids = students.pluck(:regNo)
      lsps = Lsp.where(regNo: ids).order(updated_at: :desc)
      students_with_lsps = []
      lsps.each do |lsp|
        students_with_lsps << [Student.find(lsp.regNo),lsp,lsp.updated_at]
      end
      return students_with_lsps
    end

    ##
    # Returns an active record of students taking modules belonging to a department but the students do
    # not belong to that department. Used for DLOs.
    #
    # @return ActiveRecord Relation
    #
    def getOtherStudents
      modules = UniModule.where(deptCode: current_user.ou)
      students = Student.where.not(deptCode: current_user.ou).where(:regNo => (StudentsUniModule.where(:uni_module_id => modules.pluck(:id)).pluck(:student_id)))
      return students
    end

    ##
    # Returns an active record  of all the students associated to an academic, this includes their tutees,
    # supervisees, and any students on modules they are teaching. Used by academics.
    #
    # @return ActiveRecord Relation
    #
    def getAllAcademicStudents
      modules = UniModule.find(UniModulesUser.where(user_id: current_user.id).pluck(:uni_module_id)).pluck(:id)
      # Returns the module ids of all modules the academic teaches.
      student_ids = StudentsUniModule.where(:uni_module_id => modules).pluck(:student_id)
      # Returns the student ids of all students taking the modules listed in modules.
      my_students = Student.where(:regNo => student_ids)
      ids = StudentsUser.where(user_id: current_user.id).pluck(:student_id)
      # Returns all the students linked to the academic i.e. their supervisees.
      supervisees = Student.where(:regNo => ids)
      tutees = Student.where(tutor_id: current_user.id)
      students = my_students.or(supervisees).or(tutees) 
      # An active record of all students that are tutees, supervisees, or students on modules they teach.
      return students
    end

    ##
    # Return the surname of a student's tutor using the tutor id column in the students table.
    #
    # @params ActiveRecord Relation
    # @return String
    #
    def getTutorName(student)
      id = student.tutor_id
      tutor = nil
      if id.nil?
          tutor = ""
      else
          tutor = User.find(id).sn
      end
      return tutor
    end

    #method for returning the academics teaching the modules taken by a specific student
    #params: student
    def myAcademics(student)
      #StudentsUniModule.where(student_id: student.id).pluck(:uni_module.id)
      academics = Array.new
      #accessing the modules taken by a student through the linker table
      modules_taking = StudentsUniModule.where(student_id: student.id)

      modids = Array.new
      modules_taking.each do |mod|
        modids.push(mod.uni_module_id)
      end

      #accessing the academics teaching the specific modules.
      records = UniModulesUser.where(uni_module_id: modids)

      userids = Array.new
      records.each do |rec|
        userids.push(rec.user_id)
      end

      academics = User.where(id: userids)
      return academics

    end


end
