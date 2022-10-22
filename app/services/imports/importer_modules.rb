class Imports::ImporterModules

  def initialize(file)
    @path = file.path
  end

  #method returns true/false if academic exists
  #input: an email (as a string)
  def self.academicExists(email)
    academic_in_db = User.find_by(email: email)
    if not(academic_in_db.nil?) then
      return true
    else
      return false
    end
  end
    

  def import
    # check file type is correct
    if not((@path).to_s.include?(".csv")) then
      return "File is in the wrong format. File of type '.csv' is needed."
    end
    
    csv = CSV.read(@path, headers: true, skip_blanks: true)
    #array of all headers
    headerArray = ['Module Code', 'Semester type', 'Academic 1', 'Email', 'Academic 1 Dept', 'Academic 2', 'Email', 'Academic 2 Dept', 'Academic 3', 'Email', 'Academic 3 Dept']
    #check headers are correct
    csv_valid = (headerArray - csv.headers.compact).empty?
    return "CSV format is not valid. Wrong headers are: #{(headerArray - csv.headers.compact).join(", ")}." unless csv_valid
    
    csv.each_with_index do |uni_module,i|
      #ignore empty lines
      next if uni_module["Module Code"].nil?
      
      module_already_in_db = UniModule.find_by(modCode: uni_module["Module Code"])
      #array of column numbers that have academic names
      academicColumns = [2,5,8]
      #add (or update if existing) academics in the db
      academicColumns.each do |column|
        if uni_module[column].present? then
          fullname = (uni_module[column]).split(' ')
          justName = fullname.take (fullname.length - 1)
          finalName = ""
          if justName.length == 1 then
            finalName = justName[0]
          else
            finalName = justName.join(' ')
          end
          if not(Imports::ImporterModules.academicExists(uni_module[column+1])) then
            new_academic = User.new
            new_academic.givenname = finalName
            new_academic.email = uni_module[column+1]
            new_academic.sn = fullname.last
            new_academic.role = 'Academic'
            new_academic.ou = uni_module[column+2]
            new_academic.save!
          else
            academic = User.find_by(email: uni_module[column+1])
            academic.update(givenname: finalName,sn: fullname.last, ou: uni_module[column+2])
          end
        end  
      end

      #add module in the db
      if module_already_in_db.nil? then
        new_module = UniModule.new
        module_code = uni_module["Module Code"]
        new_module.deptCode = module_code[0..2]
        new_module.modCode = module_code
        userIds = Array.new
        academicColumns.each do |column|
          if uni_module[column].present? then
            academic = User.find_by(email: uni_module[column+1])
            userIds.push(academic.id)
          end
        end
        new_module.user_ids = userIds
        new_module.save!
      end
      #update module in the db if it exists
      if not(module_already_in_db.nil?) then
        userIds = Array.new
        academicColumns.each do |column|
          if uni_module[column].present? then
            academic = User.find_by(email: uni_module[column+1])
            userIds.push(academic.id)
          end
          module_already_in_db.update(user_ids: userIds)
        end
      end
    end

    return "File uploaded successfully."
    
  end

end
