class Admin::SectionsController < ApplicationController
  before_filter :authenticate_user!
  layout 'admin_layout'

  def new
    @sections = Section.all
    @section = Section.new
  end

  def create
    @sections = Section.all
    @section = Section.new(params[:section])
    if @section.save
      redirect_to admin_new_section_path
    else
      render admin_new_section_path
    end
  end

  def update
    @sections = Section.all
    @section = Section.find(params[:id])
    if @section.update_attributes(params[:section])
      redirect_to admin_new_section_path
    else
      render admin_edit_section_path
    end
  end

  def edit
    @sections = Section.all
    @section = Section.find(params[:id])
  end

  def delete
    Section.find(params[:id]).destroy
    redirect_to admin_new_section_path
  end
end