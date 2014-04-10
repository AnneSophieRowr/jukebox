User.delete_all
User.create!(  [
  {email: 'anne-sophie.rouaux@bpi.fr', password: 'password', last_name: 'Rouaux', first_name: 'Anne-Sophie'},
  {email: 'laurent.hugou@bpi.fr', password: 'password', last_name: 'Hugou', first_name: 'Laurent'},
  {email: 'enora.oulchen@bpi.fr', password: 'password', last_name: 'Oulchen', first_name: 'Enora'}
  ]
)

Parameter.delete_all
Parameter.create!( name: 'playlist_delay', value: '30' )

Type.delete_all
Type.create!(id: 1, name: 'Playlists des lecteurs')
Type.create!(id: 2, name: 'Actualités musicales')
