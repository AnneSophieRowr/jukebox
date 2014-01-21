# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
User.create(  [
  {email: 'anne-sophie.rouaux@bpi.fr', password: 'password', last_name: 'Rouaux', first_name: 'Anne-Sophie'},
  {email: 'laurent.hugou@bpi.fr', password: 'password', last_name: 'Hugou', first_name: 'Laurent'},
  {email: 'enora.oulchen@bpi.fr', password: 'password', last_name: 'Oulchen', first_name: 'Enora'}
  ]
)
