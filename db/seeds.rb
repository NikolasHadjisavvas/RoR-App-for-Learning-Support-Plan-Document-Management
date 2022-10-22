# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Lsp.new(access: 'test' ,  circumstances: 'test' , contact: 'test',exams: 'test',practicals: 'test', recommendations: 'test', regNo:'123456789',teaching: 'test')

#Department.new(deptCode: 'COM',deptTitle:'Computer Science')

#Student.new(deptCode:'COM',periodOfStudy:'A',personalTutor:'test',programmeCode:'COMU03',regNo: '123456789')

#UniModule.new(modCode:'COM2001',modTitle:"Test")

#User.new(deptCode:'COM',email:'test',firstName:'test',lastName:'test',role:'DLO',username:'test')

#User.where(email: 'cshowkins1@sheffield.ac.uk').first_or_create(password: 'password123', password_confirmation: 'password123')

#User.create(email:'k.m.groom@sheffield.ac.uk',givenname:'Kris',role:'Academic',sn:'Groom',ou:'EEE',username:'kmGroom')
#User.create(email:'j.wilmott@sheffield.ac.uk',givenname:'Jon',role:'Academic',sn:'Willmott',ou:'EEE',username:'jWillmott')
#User.create(email:'r.saad@sheffield.ac.uk',givenname:'Rola',role:'Academic',sn:'Saad',ou:'EEE',username:'rSaad')
#User.create(email:'n.powell@sheffield.ac.uk',givenname:'Neill',role:'Academic',sn:'Powell',ou:'EEE',username:'nPowell')
#User.create(email:'j.s.ng@sheffield.ac.uk',givenname:'Jo Shien',role:'Academic',sn:'Ng',ou:'EEE',username:'jsNg')
#User.create(email:'m.masoud@sheffield.ac.uk',givenname:'Mahmoud',role:'Academic',sn:'Masoud',ou:'EEE',username:'mMasoud')
#User.create(email:'k.mitchell@sheffield.ac.uk',givenname:'Ken',role:'Academic',sn:'Mitchell',ou:'EEE',username:'KMitchell')
#User.create(email:'kboon.lee@sheffield.ac.uk',givenname:'Kean Boon',role:'Academic',sn:'Lee',ou:'EEE',username:'KBLee')

#UniModule.create(modCode:'ACS342',deptCode: "ACS")
#UniModule.create(modCode:'EEE307',deptCode: "EEE")
#UniModule.create(modCode:'EEE317',deptCode: "EEE")
#UniModule.create(modCode:'EEE348',deptCode: "EEE")
#UniModule.create(modCode:'EEE350',deptCode: "EEE")
#UniModule.create(modCode:'EEE345',deptCode: "EEE")
#UniModule.create(modCode:'EEE381',deptCode: "EEE")
#UniModule.create(modCode:'MGT388',deptCode: "MGT")
#UniModule.create(modCode:'MEC1000',deptCode: "MEC")


#  deptCode      :text
#  firstname     :text
#  lastname      :text
#  periodOfStudy :text
#  personalTutor :text
#  programmeCode :text
#  regNo         :integer          primary key
#  sup_email     :text
#  supervisor    :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#


Faculty.create(title: 'Arts and Humanities')
Department.create(deptCode: 'AAP',deptTitle:'Department of Archaeology',faculty_id:1)
Department.create(deptCode: 'EAS',deptTitle:'School of East Asian Studies',faculty_id:1)
Department.create(deptCode: 'LIT',deptTitle:'School of English',faculty_id:1)
Department.create(deptCode: 'ELL',deptTitle:'School of English',faculty_id:1)
Department.create(deptCode: 'HST',deptTitle:'Department of History',faculty_id:1)
Department.create(deptCode: 'MDL',deptTitle:'School of Languages and Cultures',faculty_id:1)
Department.create(deptCode: 'MUS',deptTitle:'Department of Music',faculty_id:1)
Department.create(deptCode: 'PHI',deptTitle:'Department of Philosophy',faculty_id:1)
Department.create(deptCode: 'MLT',deptTitle:'Modern Languagues Teaching Centre',faculty_id:1)

Faculty.create(title: 'Engineering')
Department.create(deptCode: 'ACS',deptTitle:'Department of Automatic Control and Systems Engineering',faculty_id:2)
Department.create(deptCode: 'CPE',deptTitle:'Department of Chemical and Biological Engineering',faculty_id:2)
Department.create(deptCode: 'CIV',deptTitle:'Department of Civil and Structural Engineering',faculty_id:2)
Department.create(deptCode: 'COM',deptTitle:'Department of Computer Science',faculty_id:2)
Department.create(deptCode: 'EEE',deptTitle:'Department of Electronic and Electrical Engineering',faculty_id:2)
Department.create(deptCode: 'MAT',deptTitle:'Department of Materials Science and Engineering',faculty_id:2)
Department.create(deptCode: 'MEC',deptTitle:'Department of Mechanical Engineering',faculty_id:2)
Department.create(deptCode: 'AER',deptTitle:'Interdisciplinary Programmes (Aerospace Engineering, Bioengineering and General Engineering)',faculty_id:2)
Department.create(deptCode: 'BIE',deptTitle:'Interdisciplinary Programmes (Aerospace Engineering, Bioengineering and General Engineering)',faculty_id:2)
Department.create(deptCode: 'GEE',deptTitle:'Interdisciplinary Programmes (Aerospace Engineering, Bioengineering and General Engineering)',faculty_id:2)
Department.create(deptCode: 'ACS',deptTitle:'Interdisciplinary Programmes (Aerospace Engineering, Bioengineering and General Engineering)',faculty_id:2)
Department.create(deptCode: 'MEE',deptTitle:'Multidisciplinary Engineering Education',faculty_id:2)


Faculty.create(title: 'Medicine, Dentistry and Health')
#Department.create(deptCode: '',deptTitle:'The Medical School: Academic Unit of Medical Education') #MED MDE
#Department.create(deptCode: '',deptTitle:'The Medical School: Department of Infection, Immunity and Cardiovascular Disease') #CDL MED
#Department.create(deptCode: '',deptTitle:'The Medical School: Department of Neuroscience') # MED NEU
Department.create(deptCode: 'HMC',deptTitle:'The Medical School: Department of Oncology and Metabolism',faculty_id:3)
Department.create(deptCode: 'OCP',deptTitle:'The Medical School: Department of Oncology and Metabolism',faculty_id:3)
#Department.create(deptCode: '',deptTitle:'Health Sciences School') 
Department.create(deptCode: 'HAR',deptTitle:'School of Health and Related Research',faculty_id:3)
Department.create(deptCode: 'DEN',deptTitle:'School of Clinical Dentistry',faculty_id:3)
Department.create(deptCode: 'CDH',deptTitle:'School of Clinical Dentistry',faculty_id:3)

Faculty.create(title: 'Science')
Department.create(deptCode: 'APS',deptTitle:'Department of Animal and Plant Sciences',faculty_id:4)
Department.create(deptCode: 'BMS',deptTitle:'Department of Biomedical Science',faculty_id:4)
Department.create(deptCode: 'CHM',deptTitle:'Department of Chemistry',faculty_id:4)
Department.create(deptCode: 'MAS',deptTitle:'School of Mathematics and Statistics',faculty_id:4)
Department.create(deptCode: 'MBB',deptTitle:'Department of Molecular Biology and Biotechnology',faculty_id:4)
Department.create(deptCode: 'PHY',deptTitle:'Department of Physics and Astronomy',faculty_id:4)
Department.create(deptCode: 'PSY',deptTitle:'Department of Pyschology',faculty_id:4)

Faculty.create(title: 'Social Sciences')
Department.create(deptCode: 'ARC',deptTitle:'School of Architecture',faculty_id:5)
Department.create(deptCode: 'ECN',deptTitle:'Department of Economics',faculty_id:5)
Department.create(deptCode: 'EDU',deptTitle:'School of Education',faculty_id:5)
Department.create(deptCode: 'GEO',deptTitle:'Department of Geography',faculty_id:5)
Department.create(deptCode: 'INF',deptTitle:'Information School',faculty_id:5)
Department.create(deptCode: 'JNL',deptTitle:'Department of Journalism Studies',faculty_id:5)
Department.create(deptCode: 'LSC',deptTitle:'Department of Landscape Architecture',faculty_id:5)
Department.create(deptCode: 'LAW',deptTitle:'School of Law',faculty_id:5)
Department.create(deptCode: 'MGT',deptTitle:'Management School',faculty_id:5)
Department.create(deptCode: 'POL',deptTitle:'Department of Politics',faculty_id:5)
Department.create(deptCode: 'SMI',deptTitle:'Sheffield Methods Institute',faculty_id:5)
Department.create(deptCode: 'SCS',deptTitle:'Department of Sociological Studies',faculty_id:5)
Department.create(deptCode: 'TRP',deptTitle:'Department of Urban Studies and Planning',faculty_id:5)

Faculty.create(title: 'Other')
Department.create(deptCode: 'ACE',deptTitle:'Department for Lifelong Learning',faculty_id:6)
Department.create(deptCode: 'ELT',deptTitle:'English Language Teaching Centre',faculty_id:6)
Department.create(deptCode: 'SIC',deptTitle:'Sheffield International College',faculty_id:6)

user1 = User.new(email: 'e.j.norling@sheffield.ac.uk', role: 'Academic')
user2 = User.new(email: 'k.bogdanov@sheffield.ac.uk', role: 'Academic')
user3 = User.new(email: 'ypanteli1@sheffield.ac.uk', role: 'Lab Technician')
user4 = User.new(email: 'dlai2@sheffield.ac.uk', role: 'Lab Technician')
user5 = User.new(email: 'g.sapsford@sheffield.ac.uk', role: 'Superuser')
user6 = User.new(email: 't.dolmansley@sheffield.ac.uk', role: 'Superuser')
user1.get_info_from_ldap
user2.get_info_from_ldap
user3.get_info_from_ldap
user4.get_info_from_ldap
user5.get_info_from_ldap
user6.get_info_from_ldap
user1.save
user2.save
user3.save
user4.save
user5.save
user6.save

Student.create!(regNo: 210000003, firstname: "Tomiko", lastname: "Omri", deptCode: "COM", periodOfStudy: "A", personalTutor: "A", programmeCode: "COMU101")
Student.create(regNo: 210000004, firstname: "Aurel", lastname: "Jodoc", deptCode: "COM", periodOfStudy: "B", personalTutor: "A", programmeCode: "COMU38")
Student.create(regNo: 210000005, firstname: "Nevil", lastname: "Erle", deptCode: "COM", periodOfStudy: "C", personalTutor: "A", programmeCode: "COMU43")
Student.create(regNo: 210000006, firstname: "Lennie", lastname: "Sterling", deptCode: "COM", periodOfStudy: "C", personalTutor: "A", programmeCode: "COMU103")
Student.create(regNo: 210000007, firstname: "Linden", lastname: "Melanie", deptCode: "EEE", periodOfStudy: "B", personalTutor: "A", programmeCode: "EEEU01")
Student.create(regNo: 210000008, firstname: "Chrissy", lastname: "Layton", deptCode: "AER", periodOfStudy: "A", personalTutor: "A", programmeCode: "AERU10")
Student.create(regNo: 210000009, firstname: "Kapono", lastname: "Melika", deptCode: "ACS", periodOfStudy: "A", personalTutor: "A", programmeCode: "ACSU01")
Student.create(regNo: 210000010, firstname: "Kilikina", lastname: "Kawehi", deptCode: "CIV", periodOfStudy: "B", personalTutor: "A", programmeCode: "CIVU12")
Student.create(regNo: 210000011, firstname: "Guy", lastname: "Tzia", deptCode: "MAT", periodOfStudy: "C", personalTutor: "A", programmeCode: "MATU05")
Student.create(regNo: 210000012, firstname: "Lars", lastname: "Deepak", deptCode: "MAT", periodOfStudy: "C", personalTutor: "A", programmeCode: "MATU06")

Lsp.create(regNo: 210000003)
Lsp.create(regNo: 210000004)
Lsp.create(regNo: 210000005)
Lsp.create(regNo: 210000006)
Lsp.create(regNo: 210000007)
Lsp.create(regNo: 210000008)
Lsp.create(regNo: 210000009)
Lsp.create(regNo: 210000010)
Lsp.create(regNo: 210000011)
Lsp.create(regNo: 210000012)
