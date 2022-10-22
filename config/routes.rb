Rails.application.routes.draw do
  mount EpiCas::Engine, at: "/"
  devise_for :users
  resources :academics
  resources :aeas
  resources :departments
  resources :ddss
  resources :dlos
  resources :labs
  resources :lsps
  resources :faculties
  resources :changes
  resources :reminders
  resources :settings
  #get "/uni_modules/:id/students", to: "uni_modules#students", as: :students_uni_modules
  #get "/students/supervisees", to: "students#supervisees", as: :supervisees_students
  #get "/students/tutees", to: "students#tutees", as: :supervisees_tutees
  resources :uni_modules
  get "/users/academic_users", to: "users#academic_users"
  get "/users/lab_technician_users", to: "users#lab_technician_users"
  get "/users/dlo_users", to: "users#dlo_users"
  resources :users do
    post :search, on: :collection
  end
  get "/students/other_students", to: "students#other_students", as: :other_students
  get "/students/my_students", to: "students#my_students", as: :my_students
  get "/students/my_tutees", to: "students#my_tutees", as: :my_tutees
  get "/students/my_supervisees", to: "students#my_supervisees", as: :my_supervisees
  resources :students do
    post :search, on: :collection
  end
  resources :users
  #resources :other_students

  resources :uploads, only: [:new] do
    post :upload_students, on: :collection
    post :upload_lsps, on: :collection
    post :upload_uni_modules, on: :collection
    post :upload_aeas, on: :collection
    post :upload_labs, on: :collection
  end
  
  get "/reminders/student_reminders", to: "reminders#student_reminders", as: :student_reminders
  resources :reminders, only: [:new, :search] do
    post :send_reminder_email, on: :collection
    post :search, on: :collection
  end
  
  match "/403", to: "errors#error_403", via: :all
  match "/404", to: "errors#error_404", via: :all
  match "/422", to: "errors#error_422", via: :all
  match "/500", to: "errors#error_500", via: :all
  match "/no_role", to: "errors#no_role", via: :all
  match "*path", to: "errors#error_404", via: :all

  

  get :ie_warning, to: 'errors#ie_warning'
  get :javascript_warning, to: 'errors#javascript_warning'

  root to: "pages#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
