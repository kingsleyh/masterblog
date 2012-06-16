class MasterController < ApplicationController


  def section
    $captcha_key = Time.now.to_i.to_s + rand(10000).to_s
    if Section.all.empty?
      render :text => "Nothing To See"
    else
      if params[:id].nil?
        render :text => ERB.new(Section.first.content).result(binding)
      else
        #begin
        section = Section.find(params[:id])
        render :text => ERB.new(section.content).result(binding)
        #rescue
        #  render :text => "Not Found"
        #end
      end
    end
  end


  def search
    criteria = params[:s]
    search_url = params[:searchurl]
    if criteria.nil? or criteria.empty?
      redirect_to root_url
    else
      criteria = criteria.gsub(/\W+/, '')
      if criteria.empty?
        redirect_to root_url
      else
        redirect_to search_url + "/" + criteria
      end
    end
  end

  # -- Helpers -- #

  include BlogHelpers
  include ActionView::Helpers::TextHelper

end
