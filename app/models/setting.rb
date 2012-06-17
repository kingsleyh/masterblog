class Setting < ActiveRecord::Base
  attr_accessible :key, :value

  validates :key, :presence => true
  validates :value, :presence => true

  def self.get(key)
    setting = Setting.find_by_key(key)
    setting.value unless setting.nil?
  end

  def self.get?(key)
    setting = Setting.find_by_key(key)
    if !setting.nil?
      key = setting.value
      key == "true"
    end
  end

end
