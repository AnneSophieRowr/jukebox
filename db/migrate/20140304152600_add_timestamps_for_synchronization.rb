class AddTimestampsForSynchronization < ActiveRecord::Migration
  def change
    add_column(:albums_songs, :updated_at, :datetime)
    add_column(:artists, :updated_at, :datetime)
    add_column(:artists_songs, :updated_at, :datetime)
    add_column(:kinds_playlists, :updated_at, :datetime)
    add_column(:playlists_songs, :updated_at, :datetime)
    add_column(:playlists_types, :updated_at, :datetime)
    add_column(:types, :updated_at, :datetime)
  end
end
