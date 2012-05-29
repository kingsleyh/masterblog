class MasterController < ApplicationController

  def section
    if Section.all.empty?
      render :text => "Nothing To See"
    else
      if params[:id].nil?
        render :text => ERB.new(Section.first.content).result
      else
        section = Section.find(params[:id])
        render :text => ERB.new(section.content).result
      end
    end
  end

end
