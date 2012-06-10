module AdminHelper

  def active?(controller,item,img)
    puts "------------------"
    p controller
    p item
    controller.strip == item.strip ? "#{img}-active.png" : "#{img}.png"
  end


end
