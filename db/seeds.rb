# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
company = Company.create([{ name: 'Mickeys Plaice', details: 'Fish Shop' }])
Employee.create(forename: 'Goofy', middlename: 'foo', surname: 'Cartoon', company: company.first)
Employee.create(forename: 'Minnie', middlename: 'foo', surname: 'Mouse', company: company.first)
Employee.create(forename: 'Donald', middlename: 'foo', surname: 'Duck', company: company.first)
Employee.create(forename: 'Daffy', middlename: 'foo', surname: 'Duck', company: company.first)

company = Company.create([{ name: 'Alans Autos', details: 'Garage' }])
Employee.create(forename: 'Dave', middlename: 'foo', surname: 'Grease', company: company.first)
Employee.create(forename: 'Bob', middlename: 'foo', surname: 'Spanner', company: company.first)
Employee.create(forename: 'John', middlename: 'foo', surname: 'Wrench', company: company.first)

company = Company.create([{ name: 'Gatwick', details: 'Airport' }])
Employee.create(forename: 'Michael', middlename: 'foo', surname: 'Plane', company: company.first)
Employee.create(forename: 'Janet', middlename: 'foo', surname: 'Board', company: company.first)
Employee.create(forename: 'Sarah', middlename: 'foo', surname: 'Desert', company: company.first)

company = Company.create([{ name: 'Curtains for u', details: 'Fabric Shop' }])
Employee.create(forename: 'David', middlename: 'foo', surname: 'Suede', company: company.first)
Employee.create(forename: 'Jess', middlename: 'foo', surname: 'Blinds', company: company.first)
Employee.create(forename: 'Fabian', middlename: 'foo', surname: 'Shades', company: company.first)
