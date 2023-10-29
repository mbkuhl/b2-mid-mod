# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@department1 = Department.create!(name: "IT", floor: "Basement")
@department2 = Department.create!(name: "HR", floor: "The real Basement")
@employee1 = @department1.employees.create!(name: "Mike", level: "1")
@employee1 = @department1.employees.create!(name: "Bob", level: "2")
@employee1 = @department2.employees.create!(name: "Jim", level: "3")