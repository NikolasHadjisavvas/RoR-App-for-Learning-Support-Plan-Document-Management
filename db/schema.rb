# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_19_233400) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "aeas", id: false, force: :cascade do |t|
    t.text "regNo"
    t.text "requirements"
    t.text "other"
    t.text "information"
    t.text "illness"
    t.text "consent"
    t.text "duration"
    t.text "additional"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "changes", force: :cascade do |t|
    t.text "recipient"
    t.text "sent", default: "false"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "departments", id: false, force: :cascade do |t|
    t.text "deptCode"
    t.text "deptTitle"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "faculty_id", null: false
    t.index ["faculty_id"], name: "index_departments_on_faculty_id"
  end

  create_table "faculties", force: :cascade do |t|
    t.text "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "labs", id: false, force: :cascade do |t|
    t.integer "eventId"
    t.text "day"
    t.text "room"
    t.text "roomname"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "startdate"
    t.datetime "finishdate"
    t.bigint "user_id"
  end

  create_table "labs_students", id: false, force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "lab_id", null: false
    t.index ["lab_id", "student_id"], name: "index_labs_students_on_lab_id_and_student_id"
    t.index ["student_id", "lab_id"], name: "index_labs_students_on_student_id_and_lab_id"
  end

  create_table "labs_uni_modules", id: false, force: :cascade do |t|
    t.bigint "uni_module_id", null: false
    t.bigint "lab_id", null: false
    t.index ["lab_id", "uni_module_id"], name: "index_labs_uni_modules_on_lab_id_and_uni_module_id", unique: true
    t.index ["uni_module_id", "lab_id"], name: "index_labs_uni_modules_on_uni_module_id_and_lab_id", unique: true
  end

  create_table "lsps", id: false, force: :cascade do |t|
    t.integer "regNo"
    t.text "access"
    t.text "contact"
    t.text "teaching"
    t.text "exams"
    t.text "practicals"
    t.text "circumstances"
    t.text "recommendations"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "disabilitytype"
    t.text "disabilityInfo"
    t.text "timetabling"
    t.text "advisor_email"
    t.text "advisor_name"
  end

  create_table "reminders", force: :cascade do |t|
    t.text "body"
    t.boolean "toAll"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reminders_users", force: :cascade do |t|
    t.bigint "reminder_id"
    t.bigint "user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "students", id: false, force: :cascade do |t|
    t.integer "regNo"
    t.text "programmeCode"
    t.text "deptCode"
    t.text "personalTutor"
    t.text "periodOfStudy"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "supervisor"
    t.text "sup_email"
    t.text "firstname"
    t.text "lastname"
    t.integer "tutor_id"
    t.text "email"
    t.date "completion_date"
    t.integer "sup_id"
    t.text "tut_email"
  end

  create_table "students_uni_modules", id: false, force: :cascade do |t|
    t.bigint "uni_module_id", null: false
    t.bigint "student_id", null: false
    t.index ["student_id", "uni_module_id"], name: "index_students_uni_modules_on_student_id_and_uni_module_id", unique: true
    t.index ["uni_module_id", "student_id"], name: "index_students_uni_modules_on_uni_module_id_and_student_id", unique: true
  end

  create_table "students_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "student_id", null: false
    t.index ["student_id", "user_id"], name: "index_students_users_on_student_id_and_user_id"
    t.index ["user_id", "student_id"], name: "index_students_users_on_user_id_and_student_id"
  end

  create_table "uni_modules", force: :cascade do |t|
    t.text "modCode"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "deptCode"
  end

  create_table "uni_modules_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "uni_module_id", null: false
    t.index ["uni_module_id", "user_id"], name: "index_uni_modules_users_on_uni_module_id_and_user_id", unique: true
    t.index ["user_id", "uni_module_id"], name: "index_uni_modules_users_on_user_id_and_uni_module_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.string "uid"
    t.string "mail"
    t.string "ou"
    t.string "dn"
    t.string "sn"
    t.string "givenname"
    t.string "role"
    t.integer "notification_freq", default: 3
    t.index ["email"], name: "index_users_on_email"
    t.index ["username"], name: "index_users_on_username"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "departments", "faculties"
end
