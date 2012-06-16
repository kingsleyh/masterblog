class Admin::SettingsController < ApplicationController
  before_filter :authenticate_user!
  protect_from_forgery :except => [:update_key, :update_value]
  layout 'admin_layout'

  def new
    @settings = Setting.all
    @setting = Setting.new
  end

  def create
    @settings = Setting.all
    @setting = Setting.new(params[:setting])
    if @setting.save
      redirect_to admin_new_setting_path
    else
      render admin_new_setting_path
    end
  end

  def update_key
    value = params[:value]
    setting = Setting.find_by_id(params[:id])
    setting.key = params[:value]
    setting.save
    render :text => setting.key
  end

  def update_value
    value = params[:value]
    setting = Setting.find_by_id(params[:id])
    setting.value = params[:value]
    setting.save
    render :text => setting.value
  end

  #def update
  #  @settings = Setting.all
  #  @setting = Setting.new(params[:setting])
  #  if @setting.update_attributes(params[:setting])
  #    redirect_to admin_new_setting_path
  #  else
  #    render admin_edit_setting_path
  #  end
  #end

  def delete
    Setting.find(params[:id]).destroy
    redirect_to admin_new_setting_path
  end
end