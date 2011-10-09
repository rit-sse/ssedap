# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'Emptying the Mongo database...'
Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)

puts 'Setting up roles...'
%w(Admin Officer Committee\ Head Member).each do |role_name|
  role = Role.create name: role_name
  puts 'New role created: ' << role.name
end

%w(cjk7752).each do |user|
  user = DirectoryUser.create username: user
  user.role = Role.where(name: "Admin").first
  user.save
  puts 'New directory user created: ' << user.username
end

