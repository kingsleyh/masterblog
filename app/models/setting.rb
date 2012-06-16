class Setting < ActiveRecord::Base
  attr_accessible :key, :value

  validates :key, :presence => true
  validates :value, :presence => true

  def self.get(key)
    Setting.find_by_key(key).value
  end

  def self.get?(key)
    key = Setting.find_by_key(key).value
    key == "true"
  end

end
