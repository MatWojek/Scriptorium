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
Role.find_or_create_by!(name: "Programmer", description: "Builds software and applications")
Role.find_or_create_by!(name: "Writer", description: "Writes books and articles")
Role.find_or_create_by!(name: "Teacher", description: "Educates students")
Role.find_or_create_by!(name: "Journalist", description: "Published news")

