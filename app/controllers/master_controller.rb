class MasterController < ApplicationController

  def section
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

  # -- Helpers -- #

 include BlogHelpers

end
