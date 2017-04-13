class CreateUrlShorts < ActiveRecord::Migration[5.0]
  def change
    create_table :url_shorts do |t|
      t.text :original_url, index: true
      t.text :short_url, index: true
      t.integer :hits_short_url, default: 0

      t.timestamps
    end
  end
end
