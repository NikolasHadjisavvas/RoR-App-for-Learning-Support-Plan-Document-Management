require 'date'
class Imports::Importer

  def initialize(file)
    @path = file.path
  end

  def import
    # check file type is correct
    if not((@path).to_s.include?(".csv")) then
      return "File is in the wrong format. File of type '.csv' is needed."
    end
    #array of all headers
    headerArray = ['Registration_Number', 'Surname', 'Forename', 'Title', 'E_Mail_Address', 'Supervisors_Surname','Supervisors_Initials', 'SupervisorsEmail', 'Tutor_Surname', 'Tutor_Initials', 'TutorEmail', 'Programme_Code', 'Calendar_Occurrence_Code', 'Programme_Period_Code', 'Expected_Completion_Date','Unit_Code', 'Calendar_Type_Code', 'Owned_By_Code']
    csv = CSV.read(@path, headers: true, skip_blanks: true)
    #check headers are correct
    csv_valid = (headerArray - csv.headers.compact).empty?
    return "CSV format is not valid. Wrong headers are: #{(headerArray - csv.headers.compact).join(", ")}." unless csv_valid
    
    array_of_modules = Array.new

    csv.each_with_index do |student,i|
      #ignore empty lines
      next if student["Unit_Code"].nil?
      #check if the student already exists by retrieving the corresponding record.
      student_already_in_db = Student.find_by(regNo: (student["Registration_Number"]).to_i)

      #if student_already_in_db is empty(meaning the student does not already exist),only then create 
      #the new student.
      programmeCode = student["Programme_Code"]
      
      #stop function if the module doesnt exist, to prevent association errors
      if UniModule.find_by(modCode: student["Unit_Code"]).nil? then
        return "Module #{student["Unit_Code"]} does not exist. Please try again."
      end

      if student["Registration_Number"].present? && student_already_in_db.nil? then
        if User.find_by(email: student["TutorEmail"]).nil? then
          return "There is no academic with email: #{student["TutorEmail"]}. Please try again."
        end
        if i != 0 then
          #add modules collected from previous lines
          Student.find_by(regNo: $reg_no).update(uni_module_ids: array_of_modules)
        end
        #start anew and record new info
        array_of_modules.clear
        new_student = Student.new
        new_student.deptCode = programmeCode[0..2]
        new_student.periodOfStudy = student["Programme_Period_Code"]
        new_student.firstname = student["Forename"]
        new_student.email = student["E_Mail_Address"]
        new_student.lastname = student["Surname"]
        new_student.programmeCode = student["Programme_Code"]
        new_student.regNo = (student["Registration_Number"]).to_i
        if student["SupervisorsEmail"].present? then
          if User.find_by(email: student["SupervisorsEmail"]).nil? then
            return "There is no academic with email: #{student["SupervisorsEmail"]}. Please try again."
          end
          new_student.sup_email = student["SupervisorsEmail"]
          new_student.sup_id = User.find_by(email: student["SupervisorsEmail"]).id
          new_student.supervisor = student["Supervisors_Surname"] + " " + student["Supervisors_Initials"]
        end
        new_student.tut_email = student["TutorEmail"]
        new_student.tutor_id = User.find_by(email: student["TutorEmail"]).id
        new_student.personalTutor = student["Tutor_Surname"] + " " + student["Tutor_Initials"]
        new_student.completion_date = (student["Expected_Completion_Date"]).to_date

        array_of_modules = array_of_modules.push(UniModule.find_by(modCode: student["Unit_Code"]).id)
        if (student["Registration_Number"]).size != 9 then
          return "Registration number #{student["Registration_Number"]} is not 9 characters. Please try again."
        end
        new_student.save!
        $reg_no = (student["Registration_Number"]).to_i
        #attaching an empty lsp and aea to the newly created student.
        lsp_for_student = Lsp.new(regNo: (student["Registration_Number"]).to_i)
        lsp_for_student.save!
      # if the student already exists in db, just update their info.
      elsif student["Registration_Number"].present? && not(student_already_in_db.nil?) then
        if User.find_by(email: student["TutorEmail"]).nil? then
          return "There is no academic with email: #{student["TutorEmail"]}. Please try again."
        end
        if i != 0 then
          Student.find_by(regNo: $reg_no).update(uni_module_ids: array_of_modules)
        end
        array_of_modules.clear
        $reg_no = (student["Registration_Number"]).to_i
        array_of_modules = array_of_modules.push(UniModule.find_by(modCode: student["Unit_Code"]).id)
        student_already_in_db.update(deptCode: programmeCode[0..2], periodOfStudy: student["Programme_Period_Code"],
                                      programmeCode:student["Programme_Code"], tut_email: student["TutorEmail"] , 
                                      tutor_id: User.find_by(email: student["TutorEmail"]).id ,personalTutor: student["Tutor_Surname"] + " " + student["Tutor_Initials"],
                                      firstname: student["Forename"], lastname: student["Surname"], email: student["E_Mail_Address"], completion_date: (student["Expected_Completion_Date"]).to_date)
        if student["SupervisorsEmail"].present? then
          if User.find_by(email: student["SupervisorsEmail"]).nil? then
            return "There is no academic with email: #{student["SupervisorsEmail"]}. Please try again."
          end
          student_already_in_db.update(sup_email: student["SupervisorsEmail"], sup_id: User.find_by(email: student["SupervisorsEmail"]).id, supervisor: (student["Supervisors_Surname"] + " " + student["Supervisors_Initials"]))
        end
      end
      #if no information provided then just record new modcode found
      if not(student["Registration_Number"].present?) then
        array_of_modules = array_of_modules.push(UniModule.find_by(modCode: student["Unit_Code"]).id)
      end

    end
    #update info for the last student too
    Student.find_by(regNo: $reg_no).update(uni_module_ids: array_of_modules)



    

    return "File uploaded successfully."
    
  end

end
