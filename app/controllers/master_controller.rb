class MasterController < ApplicationController

  def section
    @apples = 34
    if Section.all.empty?
      render :text => "Nothing To See"
    else
      if params[:id].nil?
        render :text => ERB.new(Section.first.content).result(binding)
      else
        section = Section.find(params[:id])
        render :text => ERB.new(section.content).result(binding)
      end
    end
  end

end
