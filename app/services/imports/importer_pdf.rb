require 'pdf-reader'

class Imports::ImporterPdf
  def initialize(file)
    @path = file.path
  end
  
  #method adds mark class tags around text difference between 2 strings
  #Input: two strings that you want to find the difference and add the tags around
  def textDifference(originalstr,newstr)
    #if first string is nil then make no changes
    if originalstr.nil? then
      return newstr
    end
    #ignore span tags
    if originalstr.include? "<span class=mark>" then
      originalstr = originalstr.gsub("<span class=mark>","")
      originalstr = originalstr.gsub("</span>","")
    end
    originalstrArr = originalstr.split(".")
    #this if ensures it ignores empty lsps that only have sub-titles in them
    if originalstrArr.count < 10 && originalstrArr.include?("\n") then
      return newstr
    else
      #find the changed words and highlight them
      difference = newstr.split(".") - originalstrArr
      result = highlightString(difference,newstr)
      return (result)
    end
  end

  #method adds mark class tags around parts of a string that match with the strings in an array
  #Input: an array of strings, and a string
  def highlightString(wordArray,originalString)
    #make no changes if there no changed words in array
    if wordArray.empty? then
      return originalString
    end
    #take each word in array and add tags around it
    wordArray.each do |word|
      if word == " " then
        next
      end
      originalString = originalString.gsub(word+".",("<span class=mark>"+word+".</span>"))
    end
    #if 2 words next to each other have span tags, join them in 1 tag
    if originalString.include? "</span> <span class=mark>" then
      originalString = originalString.gsub("</span> <span class=mark>"," ")
    end
    return originalString
  end


  def import
    #return error 
    if not((@path).to_s.include?(".pdf")) then
      return "File is in the wrong format. File of type '.pdf' is needed."
    end
    pdf = PDF::Reader.new(@path)

    #initialise strings
    regNo = ""
    disabilitytype = ""
    adviserName = ""
    adviserEmail = ""
    disabilityInfo = ""

    #initialise t/f flags
    disabilityInfoFlag = false

    hashFlags = {
      seizureAdviceFlag: false,
      evacuationFlag: false,
      timetablingFlag: false,
      communicationFlag: false,
      physicalEnvFlag: false,
      accessibilityMaterialsFlag: false,
      attendanceFlag: false,
      teachingFlag: false,
      seminarsFlag: false,
      peersFlag: false,
      speakingFlag: false,
      presentationsFlag: false,
      practicalFlag: false,
      placementsFlag: false,
      fieldTripsFlag: false,
      yearAbroadFlag: false,
      courseworkFlag: false,
      feedbackFlag: false,
      vivaFlag: false,
      examsFlag: false,
      extenuatingFlag: false
    }

    #initialise all strings in a hash
    hashStrings = {
      seizureAdvice: "<b>Seizure Advice</b>\n",
      evacuation: "\n<b>Evacuation</b>",
      timetabling: "",
      communication: "",
      physicalEnv: "\n <b>Physical Environment</b> \n",
      accessibilityMaterials: "<b>Accessibility of Materials</b>",
      attendance: "\n<b>Attendance</b>",
      teaching: "\n<b>Teaching</b>",
      seminars: "\n<b>Teaching - Seminars/Tutorials</b>",
      peers: "\n<b>Working with Peers</b>",
      speaking: "\n<b>Speaking in Class</b>",
      presentations: "<b>Speaking in Class</b>",
      practical: "",
      placements: "\n<b>Placements</b>\n",
      fieldTrips: "\n<b>Field Trips</b>\n",
      yearAbroad: "\n<b>Year Abroad</b>\n",
      coursework: "\n<b>Coursework: support with production</b>\n",
      feedback: "\n<b>Feedback</b>\n",
      viva: "\n<b>Viva</b>\n",
      exams: "\n<b>Examinations</b>\n",
      extenuating: ""
    }

    #array with what each part of the LSP starts with
    stringStart = [
      'Seizure Advice ',
      'Evacuation ',
      'Timetabling ',
      'Communication/ongoing contact ',
      'Physical environment ',
      'Accessibility of materials ',
      'Attendance ',
      'Teaching ',
      'Teaching-seminars/tutorials ',
      'Working with peers ',
      'Speaking in class ',
      'Presentations ',
      'Practical course elements ',
      'Placements ',
      'Field trips ',
      'Year abroad ',
      'Coursework: support with production ',
      'Feedback ',
      'Viva ',
      'Examinations ',
      'Extenuating Circumstances '
    ]


    endingFlag = false

    pdf.pages.each_with_index do |page,page_i|
      string = page.to_s
      #read through each line of the page
      string.each_line.with_index do |line,i|
        #ignore everything if line is empty, or pdf has been read
        next if (line.nil?)
        next if endingFlag

        line = line.strip + " "
        #change the weird symbols with the bulletpoints
        if line.start_with?("●") then
          line = "\n" + line
        elsif line.start_with?("") then
          line = "\n" + line.gsub('','●')
        end
        
        #if statements set variables with pdf info if lines detected
        if line.start_with?('Registration number') then
          regNo = (line.gsub('Registration number: ',''))
          next
        elsif line.start_with?('Disability type') then
          disabilitytype = line.gsub('Disability type(s): ','')
          next
        elsif line.start_with?('Disability adviser name') then
          adviserName = line.gsub('Disability adviser name: ','')
          next
        elsif line.start_with?('Disability adviser email') then
          adviserEmail = line.gsub('Disability adviser email address: ','')
          next
        #following if statements trigger the flags when a new section is identified
        elsif line.start_with?('Disability information') then
          disabilityInfoFlag = true
          next
        elsif line.start_with?('Support required') then
          disabilityInfoFlag = false
          next
        elsif (stringStart.include? line) then
          indx = stringStart.index(line)
          hashFlags.transform_keys{ |key| hashFlags[key] = false}
          hashFlags[(hashFlags.keys[indx])] = true
          next

        elsif line.start_with?('Please contact me') then
          hashFlags.transform_keys{ |key| hashFlags[key] = false}
          endingFlag = true
          next
        end
        
        #if a flag is true, then add the info in the apropriate variable string
        if disabilityInfoFlag then
          disabilityInfo += line
          next
        elsif hashFlags.has_value?(true) then
          indx = hashFlags.find_index { |_,value| value == true }
          change = hashStrings[(hashStrings.keys[indx])] + line
          hashStrings[(hashStrings.keys[indx])] = change
          next

        end
      end
    end

    #check any errors with regNo
    if (regNo).empty? then
      return "No registration number detected."
    elsif Lsp.where(regNo: regNo.to_i).empty? then
      return "There is no student with registration number #{regNo.strip}."
    end

    #combine the sub-sections to make the sections in the lsp
    access = hashStrings[:seizureAdvice] + "\n" + hashStrings[:evacuation] + "\n" + hashStrings[:physicalEnv]
    teachingFinal = hashStrings[:accessibilityMaterials] + "\n" + hashStrings[:attendance] + "\n" + hashStrings[:teaching] + "\n" + hashStrings[:seminars] + "\n" + hashStrings[:peers] + "\n" + hashStrings[:speaking]
    examinations = hashStrings[:presentations] + "\n" + hashStrings[:coursework] + "\n" + hashStrings[:feedback] + "\n" + hashStrings[:viva] + "\n" + hashStrings[:exams]
    practicalFinal = hashStrings[:practical] + "\n" + hashStrings[:placements] + "\n" + hashStrings[:fieldTrips] + "\n" + hashStrings[:yearAbroad]
    
    #find the lsp initialised when the student was created
    lsp = Lsp.find_by(regNo: regNo.to_i)
    #update the lsp, ensuring the difference in text is highlighted with the class .mark
    lsp.update(access: textDifference(lsp.access,access),
                circumstances: textDifference(lsp.circumstances,hashStrings[:extenuating]),
                contact: textDifference(lsp.contact,hashStrings[:communication]) ,
                disabilityInfo: textDifference(lsp.disabilityInfo,disabilityInfo) ,
                disabilitytype: disabilitytype,
                exams: textDifference(lsp.exams,examinations),
                practicals: textDifference(lsp.practicals,practicalFinal),
                teaching: textDifference(lsp.teaching,teachingFinal),
                timetabling: textDifference(lsp.timetabling,hashStrings[:timetabling]),
                advisor_name: adviserName,
                advisor_email: adviserEmail)

    
    
    return "LSP uploaded successfully."

  end
  
end
