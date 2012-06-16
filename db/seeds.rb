# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



seeds_dir = File.dirname(__FILE__) + '/seeds/'
seeds = Dir.entries(seeds_dir).collect{|f| seeds_dir + f if f.match(".rb")}.compact
seeds.each{|seed| require seed }
