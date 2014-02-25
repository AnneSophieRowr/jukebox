class Record < ActiveRecord::Base
  belongs_to :recordable, polymorphic: true

  def self.total(type, start_date, end_date)
    data = where('recordable_type = ? AND created_at BETWEEN ? AND ?', type, start_date, end_date).count(group: "recordable_id")
    labels = data.keys.collect {|id| Playlist.find(id).name.capitalize}
    values = data.values.collect {|v| v + 1}
    data = [labels, values]
  end

  def self.kind(type, start_date, end_date)
    data = joins("JOIN kinds_playlists kp ON kp.playlist_id = records.recordable_id").where('recordable_type = ? AND created_at BETWEEN ? AND ?', type, start_date, end_date).count(group: "kind_id")
    labels = data.keys.collect {|id| Kind.find(id).name.capitalize}
    values = data.values.collect {|v| v + 1}
    data = [labels, values]
  end

  def self.time(type, start_date, end_date)
    data = connection.select_all("  SELECT COUNT(SUBTIME(end_time, start_time)) AS count,
                                    CASE  WHEN MINUTE(SUBTIME(end_time, start_time)) < 15 AND HOUR(SUBTIME(end_time, start_time)) <1 THEN '0-15 min'
                                          WHEN MINUTE(SUBTIME(end_time, start_time)) BETWEEN 15 AND 29 THEN '15-30 min'
                                          WHEN MINUTE(SUBTIME(end_time, start_time)) BETWEEN 30 AND 44 THEN '30-45 min'
                                          WHEN MINUTE(SUBTIME(end_time, start_time)) BETWEEN 45 AND 59 THEN '45-60 min'
                                          WHEN HOUR(SUBTIME(end_time, start_time)) >= 1 THEN '60+ min'
                                    END AS intervals
                                    FROM records
                                    WHERE recordable_type = '#{type}'
                                    AND created_at between '#{start_date}' AND '#{end_date}'
                                    GROUP BY intervals") 
    labels = data.rows.collect {|r| r.last}
    values = data.rows.collect {|r| r.first + 1}
    data = [labels, values]
  end

end
