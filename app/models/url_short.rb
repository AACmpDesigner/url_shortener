class UrlShort < ApplicationRecord
  def self.remove_origin_short_url_pair
    real_time = Time.now
    time_for_remove = real_time - 15.days
    time_start = time_for_remove.beginning_of_day
    time_end = time_for_remove.end_of_day
    self.where(created_at: time_start..time_end).delete_all
  end
end
