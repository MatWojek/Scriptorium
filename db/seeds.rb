# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Category
Category.find_or_create_by!(name: "Technology")
Category.find_or_create_by!(name: "Travel")
Category.find_or_create_by!(name: "Cooking")

# Language 
Language.find_or_create_by!(code: "en") { |l| l.name = "English" }
Language.find_or_create_by!(code: "pl") { |l| l.name = "Polski" }

# Role
Role.find_or_create_by!(code: "programmer") do |r|
  r.name = "Programmer"
  r.description = "Builds software and applications"
end

Role.find_or_create_by!(code: "writer") do |r|
  r.name = "Writer"
  r.description = "Writes books and articles"
end

Role.find_or_create_by!(code: "teacher") do |r|
  r.name = "Teacher"
  r.description = "Educates students"
end

Role.find_or_create_by!(code: "journalist") do |r|
  r.name = "Journalist"
  r.description = "Published news"
end