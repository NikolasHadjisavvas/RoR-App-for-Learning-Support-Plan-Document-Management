##
# Deals with uploading data into the database through the upload views.
#
# @authors N.Hadjisavvas, M.Kyriacou
#

require 'csv'
class UploadsController < ApplicationController

  def new
  end

  def show
  end
  
  def upload_students
    if params[:upload_students].nil? then
      #output error if no file selected
      flash.alert = "You have not selected a file to upload."
      render :new
    else
      #compute import actions and output result as a notice
      file = params[:upload_students][:file].tempfile
      importer = Imports::Importer.new(file)
      result = importer.import
      if result == "File uploaded successfully." then
        flash.notice = result
        redirect_to students_path
      else
        flash.now[:alert] = result
        render :new
      end
    end
  end

  def upload_lsps

    if params[:upload_lsps].nil? then
      #output error if no file selected
      flash.alert = "You have not selected a file to upload."
      render :new
    else
      #compute import actions and output result as a notice
      file = params[:upload_lsps][:file].tempfile
      importer = Imports::ImporterPdf.new(file)
      result = importer.import
      if result == "LSP uploaded successfully." then
        flash.notice = result
        redirect_to students_path     
      else
        flash.now[:alert] = result
        render :new
      end
    end
  end


    def upload_uni_modules

      if params[:upload_uni_modules].nil? then
        #output error if no file selected
        flash.alert = "You have not selected a file to upload."
        render :new
      else
        #compute import actions and output result as a notice
        file = params[:upload_uni_modules][:file].tempfile
        importer = Imports::ImporterModules.new(file)
        result = importer.import
        if result == "File uploaded successfully." then
          flash.notice = result
          redirect_to users_path 
        else
          flash.now[:alert] = result
          render :new
        end
      end
    end

    def upload_labs

      if params[:upload_labs].nil? then
        #output error if no file selected
        flash.now[:alert] = "You have not selected a file to upload."
        render :new
      else
        #compute import actions and output result as a notice
        file = params[:upload_labs][:file].tempfile
        importer = Imports::ImporterLabs.new(file)
        result = importer.import
        if result == "File uploaded successfully." then
          flash.notice = result
          redirect_to labs_path
        else
          flash.now[:alert] = result
          render :new
        end
      end
    end
  end