Parameter.delete_all
Parameter.create!( name: 'playlist_delay', value: '30' )

Type.delete_all
Type.create!(id: 1, name: 'Playlists des lecteurs')
Type.create!(id: 2, name: 'Actualités musicales')
