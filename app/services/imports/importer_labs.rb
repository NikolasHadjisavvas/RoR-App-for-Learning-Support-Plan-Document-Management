require 'date'
class Imports::ImporterLabs

  def initialize(file)
    @path = file.path
  end

  def import
    # check file type is correct
    if not((@path).to_s.include?(".csv")) then
      return "File is in the wrong format. File of type '.csv' is needed."
    end
    #array of all headers
    headerArray = ['EventId', 'Start', 'Finish', 'Status', 'Day', 'Room','RoomName', 'Module Code', 'DOA', 'Staffcode', 'Staffname', 'Staffemail', 'StudentRegNo', 'Dates']
    csv = CSV.read(@path, headers: true, skip_blanks: true)
    #check headers are correct
    csv_valid = (headerArray - csv.headers.compact).empty?
    return "CSV format is not valid. Wrong headers are: #{(headerArray - csv.headers.compact).join(", ")}." unless csv_valid
    
    #initialise student array and eventID
    array_of_students = Array.new
    previousEventID = ""

    csv.each_with_index do |row,i|
      #skip line if there is no regno
      next if (row["StudentRegNo"].nil?)

      currentEventID = row["EventId"]
      #return false if student doesnt exist in db
      if Student.find_by(regNo: row["StudentRegNo"]).nil? then
          return "There is no student with registration number #{row["StudentRegNo"]}."
      end

      #check if the lab already exists by retrieving the corresponding record.
      lab_already_exists = Lab.find_by(eventId: row["EventId"])

      #if lab doesnt exist, record info in a new lab obj
      #and store the previous info
      if lab_already_exists.nil? then
        if i!= 0 then
          Lab.find_by(eventId: previousEventID.to_i).update(student_ids: array_of_students)
          array_of_students.clear
        end

        new_lab = Lab.new

        #if lab tech is a user then add them onto the lab
        #else create them
        technician_already_exists = User.find_by(email: row["Staffemail"])
        if not(technician_already_exists.nil?) then
          new_lab.user_id = technician_already_exists.id
        else
          new_technician = User.new
          new_technician.email = row["Staffemail"]
          new_technician.ou = (SheffieldLdapLookup::LdapFinder.new(row["Staffemail"]).lookup[:ou])[0]
          new_technician.role = "Lab Technician"
          new_technician.givenname = (SheffieldLdapLookup::LdapFinder.new(row["Staffemail"]).lookup[:givenname])[0]
          new_technician.sn = (SheffieldLdapLookup::LdapFinder.new(row["Staffemail"]).lookup[:sn])[0]
          new_technician.save!
          new_lab.user_id = new_technician.id
        end

        
        new_lab.day = row["Day"]
        new_lab.eventId = (row["EventId"]).to_i
        new_lab.room = row["Room"]
        new_lab.roomname = row["RoomName"]
        modID = UniModule.find_by(modCode: row["Module Code"])
        if modID.nil? then
          return "Module #{row["Module Code"]} does not exist. Please try again."
        else
          new_lab.uni_module_ids = modID.id
        end

        date = row["Dates"].to_date
        start = row["Start"].to_time
        finish = row["Finish"].to_time
        new_lab.startdate = DateTime.new(date.year,date.month,date.day,start.hour,start.min,start.sec)
        new_lab.finishdate = DateTime.new(date.year,date.month,date.day,finish.hour,finish.min,finish.sec)

        new_lab.save!
        array_of_students.push(Student.find_by(regNo: row["StudentRegNo"]).id)
        previousEventID = row["EventId"]
      
      #if lab exists, update the info
      elsif not(lab_already_exists.nil?) then
        #add previous event's students if starting new event
        if not(currentEventID == previousEventID) && not(previousEventID.empty?) then
          (Lab.find_by(eventId: previousEventID.to_i)).update(student_ids: array_of_students)
          array_of_students.clear
        end


        techID = 1
        #if lab tech is a user then record their id
        #else create them and then record their id
        technician_already_exists = User.find_by(email: row["Staffemail"])
        if not(technician_already_exists.nil?) then
          techID = technician_already_exists.id
        else
          new_technician = User.new
          new_technician.email = row["Staffemail"]
          new_technician.ou = (SheffieldLdapLookup::LdapFinder.new(row["Staffemail"]).lookup[:ou])[0]
          new_technician.role = "Lab Technician"
          new_technician.givenname = (SheffieldLdapLookup::LdapFinder.new(row["Staffemail"]).lookup[:givenname])[0]
          new_technician.sn = (SheffieldLdapLookup::LdapFinder.new(row["Staffemail"]).lookup[:sn])[0]
          new_technician.save!
          techID = new_technician.id
        end

        date = row["Dates"].to_date
        start = row["Start"].to_time
        finish = row["Finish"].to_time
        startDate = DateTime.new(date.year,date.month,date.day,start.hour,start.min,start.sec)
        finishDate = DateTime.new(date.year,date.month,date.day,finish.hour,finish.min,finish.sec)
        lab_already_exists.update(day:row["Day"],room:row["Room"],roomname:row["RoomName"],startdate: startDate, finishdate: finishDate,user_id: techID)
        array_of_students.push(Student.find_by(regNo: row["StudentRegNo"]).id)
        previousEventID = row["EventId"]
      
      else
        array_of_students.push(Student.find_by(regNo: row["StudentRegNo"]).id)
      end
    end
    #add the last set of students on the event
    if not(previousEventID.empty?) then
      (Lab.find_by(eventId: previousEventID.to_i)).update(student_ids: array_of_students)
    end

    return "File uploaded successfully."
    
  end

end
