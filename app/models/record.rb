class Record < ActiveRecord::Base
  belongs_to :recordable, polymorphic: true

  def self.total(type)
    data = where('recordable_type = ?', type).count(group: "recordable_id")
    labels = data.keys.collect {|id| Playlist.find(id).name.capitalize}
    data = [labels, data.values]
  end

  def self.kind(type)
    data = joins("join kinds_playlists kp on kp.playlist_id = records.recordable_id").where('recordable_type = ?', type).count(group: "kind_id")
    labels = data.keys.collect {|id| Kind.find(id).name.capitalize}
    data = [labels, data.values]
  end

  def self.time(type)
    data = connection.select_all("  SELECT COUNT(SUBTIME(end_time, start_time)) AS count,
                          CASE  WHEN MINUTE(SUBTIME(end_time, start_time)) < 15 AND HOUR(SUBTIME(end_time, start_time)) <1 THEN '0-15 min'
                                WHEN MINUTE(SUBTIME(end_time, start_time)) BETWEEN 15 AND 29 THEN '15-30 min'
                                WHEN MINUTE(SUBTIME(end_time, start_time)) BETWEEN 30 AND 44 THEN '30-45 min'
                                WHEN MINUTE(SUBTIME(end_time, start_time)) BETWEEN 45 AND 59 THEN '45-60 min'
                                WHEN HOUR(SUBTIME(end_time, start_time)) >= 1 THEN '60+ min'
                          END AS intervals
                          FROM records
                          WHERE recordable_type = '#{type}'
                          GROUP BY intervals") 
    data = [data.rows.collect {|r| r.last}, data.rows.collect {|r| r.first}]
  end

end
