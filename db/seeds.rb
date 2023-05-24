# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Pet.destroy_all
Shelter.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all

shelter = Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
@mr_pirate = shelter.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
