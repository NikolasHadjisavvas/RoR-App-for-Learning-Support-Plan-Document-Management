# project
---

### Description
Inclusivity is a core value that the university upholds. They offer extensive
support to students in the form of support groups and support plans. How-
ever, under the current system, there have been issues with implementing these
support plans. Their distribution between departments is inefficient and compli-
cated. Each DLO stores and shares their support plans differently, which leads
to inconsistency with sharing the relevant LSPs with the relevant people. The
current system also makes it difficult for academics to access relevant support
plans. This difficulty lies with the fact that DLOs have to email individual sup-
port plans to academics. The time spent on administrative work should be kept
to a minimum so that DLOs can spend more time providing support. We will
develop a solution in which members of staff can easily access current student
information. The system will also automate tasks to reduce the workload for
all parties involved.


### File structure
```
├── app
│   ├── assets
│   │   ├── config
│   │   │   └── manifest.js
│   │   ├── images
│   │   │   └── .keep
│   │   ├── javascripts
│   │   │   ├── ae_as.coffee
│   │   │   ├── ajax_setup.coffee
│   │   │   ├── application.js
│   │   │   ├── departments.coffee
│   │   │   ├── faculties.coffee
│   │   │   ├── homepage.coffee
│   │   │   ├── labs.coffee
│   │   │   ├── ls_ps.coffee
│   │   │   ├── modal.coffee
│   │   │   ├── other_student.coffee
│   │   │   ├── reminders.coffee
│   │   │   ├── select2_init.coffee
│   │   │   ├── students.coffee
│   │   │   ├── uni_modules.coffee
│   │   │   ├── uploads.coffee
│   │   │   └── users.coffee
│   │   └── stylesheets
│   │       ├── ae_as.scss
│   │       ├── application.css
│   │       ├── bootstrap_setup.scss
│   │       ├── custom_flash.scss
│   │       ├── customizations.scss
│   │       ├── departments.scss
│   │       ├── environment_notice.scss
│   │       ├── faculties.scss
│   │       ├── font_awesome_setup.scss
│   │       ├── forms.scss
│   │       ├── homepage.scss
│   │       ├── labs.scss
│   │       ├── layout.scss
│   │       ├── ls_ps.scss
│   │       ├── other_student.scss
│   │       ├── reminders.scss
│   │       ├── scaffolds.scss
│   │       ├── students.scss
│   │       ├── uni_modules.scss
│   │       ├── uploads.scss
│   │       ├── users.scss
│   │       ├── variables.scss
│   │       └── warning_page.scss
│   ├── controllers
│   │   ├── concerns
│   │   │   └── .keep
│   │   ├── aeas_controller.rb
│   │   ├── application_controller.rb
│   │   ├── departments_controller.rb
│   │   ├── errors_controller.rb
│   │   ├── faculties_controller.rb
│   │   ├── labs_controller.rb
│   │   ├── lsps_controller.rb
│   │   ├── pages_controller.rb
│   │   ├── reminders_controller.rb
│   │   ├── students_controller.rb
│   │   ├── uni_modules_controller.rb
│   │   ├── uploads_controller.rb
│   │   └── users_controller.rb
│   ├── helpers
│   │   ├── ae_as_helper.rb
│   │   ├── application_helper.rb
│   │   ├── departments_helper.rb
│   │   ├── environment_notice_helper.rb
│   │   ├── faculties_helper.rb
│   │   ├── forms_helper.rb
│   │   ├── homepage_helper.rb
│   │   ├── labs_helper.rb
│   │   ├── ls_ps_helper.rb
│   │   ├── reminders_helper.rb
│   │   ├── students_helper.rb
│   │   ├── uni_modules_helper.rb
│   │   ├── uploads_helper.rb
│   │   └── users_helper.rb
│   ├── inputs
│   │   ├── date_string_input.rb
│   │   ├── inline_check_boxes_input.rb
│   │   └── inline_radio_buttons_input.rb
│   ├── javascript
│   │   ├── channels
│   │   │   ├── consumer.js
│   │   │   └── index.js
│   │   └── packs
│   │       └── application.js
│   ├── jobs
│   │   └── application_job.rb
│   ├── mailers
│   │   ├── application_mailer.rb
│   │   └── user_mailer.rb
│   ├── models
│   │   ├── concerns
│   │   │   └── .keep
│   │   ├── ability.rb
│   │   ├── aea.rb
│   │   ├── application_record.rb
│   │   ├── department.rb
│   │   ├── faculty.rb
│   │   ├── lab.rb
│   │   ├── lsp.rb
│   │   ├── student.rb
│   │   ├── students_uni_module.rb
│   │   ├── students_user.rb
│   │   ├── uni_module.rb
│   │   ├── uni_modules_user.rb
│   │   └── user.rb
│   ├── services
│   │   ├── imports
│   │   │   ├── importer_labs.rb
│   │   │   ├── importer_modules.rb
│   │   │   ├── importer_pdf.rb
│   │   │   └── importer.rb
│   │   ├── standard_ajax_responder.rb
│   │   ├── standard_destroyer.rb
│   │   ├── standard_resource_decorator.rb
│   │   ├── standard_responder.rb
│   │   └── standard_updater.rb
│   └── views
│       ├── academics
│       │   └── index.html.haml
│       ├── aeas
│       │   ├── _form.html.haml
│       │   ├── edit.html.haml
│       │   ├── index.html.haml
│       │   ├── new.html.haml
│       │   └── show.html.haml
│       ├── ddss
│       │   ├── index.html.haml
│       │   └── upload_aea.html.haml
│       ├── departments
│       │   ├── _form.html.haml
│       │   ├── edit.html.haml
│       │   ├── index.html.haml
│       │   ├── new.html.haml
│       │   └── show.html.haml
│       ├── devise
│       │   └── sessions
│       │       └── new.html.haml
│       ├── dlos
│       │   └── index.html.haml
│       ├── errors
│       │   ├── error_403.html.haml
│       │   ├── error_404.html.haml
│       │   ├── error_422.html.haml
│       │   ├── error_500.html.haml
│       │   ├── ie_warning.html.haml
│       │   └── javascript_warning.html.haml
│       ├── faculties
│       │   └── index.html.haml
│       ├── homepage
│       │   └── home.html.haml
│       ├── labs
│       │   ├── _form.html.haml
│       │   ├── edit.html.haml
│       │   ├── index.html.haml
│       │   ├── new.html.haml
│       │   └── show.html.haml
│       ├── layouts
│       │   ├── _environment_notice.html.haml
│       │   ├── application.html.haml
│       │   ├── mailer.html.erb
│       │   ├── mailer.html.haml
│       │   ├── mailer.text.erb
│       │   ├── mailer.text.haml
│       │   └── plain_error.html.haml
│       ├── lsps
│       │   ├── _edit_form.html.haml
│       │   ├── _form.html.haml
│       │   ├── edit.html.haml
│       │   ├── index.html.haml
│       │   ├── new.html.haml
│       │   └── show.html.haml
│       ├── pages
│       │   └── home.html.haml
│       ├── reminders
│       │   └── new.html.haml
│       ├── students
│       │   ├── _form_for_DLO.html.haml
│       │   ├── _form_for_edit.html.haml
│       │   ├── _form.html.haml
│       │   ├── edit.html.haml
│       │   ├── index.html.haml
│       │   ├── new.html.haml
│       │   └── show.html.haml
│       ├── uni_modules
│       │   ├── _form.html.haml
│       │   ├── edit.html.haml
│       │   ├── index.html.haml
│       │   ├── new.html.haml
│       │   └── show.html.haml
│       ├── uploads
│       │   ├── new.html.haml
│       │   └── show.html.haml
│       ├── user_mailer
│       │   ├── changes_to_student_email.html.haml
│       │   ├── send_reminder_email.html.haml
│       │   └── send_reminder_email.text.erb
│       └── users
│           ├── _form.html.haml
│           ├── _show_fields.html.haml
│           ├── _users_table.html.haml
│           ├── edit.html.haml
│           ├── index.html.haml
│           ├── new.html.haml
│           ├── show.html.haml
│           ├── update_failure.js.haml
│           └── update_success.js.haml
├── config
│   ├── deploy
│   │   ├── demo.rb
│   │   └── qa.rb
│   ├── environments
│   │   ├── demo.rb
│   │   ├── development.rb
│   │   ├── production.rb
│   │   ├── qa.rb
│   │   └── test.rb
│   ├── initializers
│   │   ├── application_controller_renderer.rb
│   │   ├── assets.rb
│   │   ├── backtrace_silencers.rb
│   │   ├── content_security_policy.rb
│   │   ├── cookies_serializer.rb
│   │   ├── delayed_job.rb
│   │   ├── devise.rb
│   │   ├── errbit.rb
│   │   ├── filter_parameter_logging.rb
│   │   ├── inflections.rb
│   │   ├── mime_types.rb
│   │   ├── session_store.rb
│   │   ├── sheffield_ldap_lookup.rb
│   │   ├── simple_form_bootstrap_input_group.rb
│   │   ├── simple_form_bootstrap.rb
│   │   ├── simple_form.rb
│   │   ├── version.rb
│   │   └── wrap_parameters.rb
│   ├── locales
│   │   ├── devise.en.yml
│   │   ├── en.yml
│   │   └── simple_form.en.yml
│   ├── application.rb
│   ├── boot.rb
│   ├── cable.yml
│   ├── credentials.yml.enc
│   ├── database_pg.yml
│   ├── database_sample-pg 2.yml
│   ├── database_sample-pg.yml
│   ├── database.yml
│   ├── deploy.rb
│   ├── environment.rb
│   ├── epi_cas_settings.yml
│   ├── ldap.yml
│   ├── master.key
│   ├── puma.rb
│   ├── routes.rb
│   ├── schedule.rb
│   ├── spring.rb
│   └── storage.yml
├── db
│   ├── schema.rb
│   └── seeds.rb
├── spec
│   ├── factories
│   │   ├── aeas.rb
│   │   ├── departments.rb
│   │   ├── faculties.rb
│   │   ├── labs.rb
│   │   ├── lsps.rb
│   │   ├── students_uni_modules.rb
│   │   ├── students.rb
│   │   ├── uni_modules_users.rb
│   │   ├── uni_modules.rb
│   │   └── users.rb
│   ├── fixtures
│   │   └── files
│   │       ├── lsp_correct.pdf
│   │       ├── lsp_no_regno.pdf
│   │       ├── module_test.csv
│   │       ├── student_module_error.csv
│   │       └── student_test_works.csv
│   ├── helpers
│   │   ├── ae_as_helper_spec.rb
│   │   ├── departments_helper_spec.rb
│   │   ├── faculties_helper_spec.rb
│   │   ├── homepage_helper_spec.rb
│   │   ├── labs_helper_spec.rb
│   │   ├── ls_ps_helper_spec.rb
│   │   ├── reminders_helper_spec.rb
│   │   ├── students_helper_spec.rb
│   │   ├── uni_modules_helper_spec.rb
│   │   ├── uploads_helper_spec.rb
│   │   └── users_helper_spec.rb
│   ├── importers
│   │   ├── importer_labs_spec.rb
│   │   ├── importer_modules_spec.rb
│   │   ├── importer_pdf_spec.rb
│   │   └── importer_spec.rb
│   ├── mailers
│   │   ├── previews
│   │   │   └── user_mailer_preview.rb
│   │   └── user_mailer_spec.rb
│   ├── models
│   │   ├── department_spec.rb
│   │   ├── faculty_spec.rb
│   │   ├── lab_spec.rb
│   │   ├── lsp_spec.rb
│   │   ├── student_spec.rb
│   │   ├── students_uni_module_spec.rb
│   │   ├── students_user_spec.rb
│   │   ├── uni_module_spec.rb
│   │   ├── uni_modules_user_spec.rb
│   │   └── user_spec.rb
│   ├── requests
│   │   ├── departments_spec.rb
│   │   ├── faculties_request_spec.rb
│   │   ├── homepage_request_spec.rb
│   │   ├── labs_request_spec.rb
│   │   ├── labs_spec.rb
│   │   ├── ls_ps_spec.rb
│   │   ├── reminders_request_spec.rb
│   │   ├── students_spec.rb
│   │   ├── uni_modules_spec.rb
│   │   ├── uploads_request_spec.rb
│   │   └── users_spec.rb
│   ├── rails_helper.rb
│   └── spec_helper.rb
├── vendor
│   ├── assets
│   │   ├── javascripts
│   │   │   └── select2.js
│   │   └── stylesheets
│   │       ├── select2-bootstrap.css
│   │       └── select2.css
├── .gitattributes
├── .gitignore
├── .rspec
├── .rspec-examples
├── .ruby-version
├── .slugignore
├── Capfile
├── config.ru
├── Gemfile
├── Gemfile.lock
├── package.json
├── Procfile
├── Rakefile
└── README.md
```

### How to Build
First you must clone this repository and then run
` bundle install ` to install the necessary gems. Once the gems have been installed
run ` bundle exec rails db:migrate ` to ensure that the database is correct. You can then run the rails server using
` bundle exec rails s ` and go to ` https://localhost:3000 ` to view it. Note: You will need a university account to log in and you will need to be connected to the VPN.

### Deployment
This project can be deployed by running
` bundle exec epi_deploy release -d demo `. Only code in the master branch will be deployed so make sure that it is up to date before deploying. The database can also be seeded by running ` bundle exec cap demo deploy:seed `. The demo site is available at ` https://team03.demo1.hut.shefcompsci.org.uk/ `
