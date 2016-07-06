# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# user = CreateAdminService.new.call
# puts 'CREATED ADMIN USER: ' << user.email
# Environment variables (ENV['...']) can be set in the file .env file.
user = User.new
user.name = 'David Ng'
user.phone_no = '93148325'
user.role = 2
user.email = 'david.ng@letsapp.mobi'
user.password = '$2a$11$ikFQL9l7Q2raTSw8ISMePOiXturjQooQnbyzvV/qy98ZmmSxf/ehy'
user.encrypted_password = '$2a$11$ikFQL9l7Q2raTSw8ISMePOiXturjQooQnbyzvV/qy98ZmmSxf/ehy'
user.confirmed_at = Time.now
user.save!