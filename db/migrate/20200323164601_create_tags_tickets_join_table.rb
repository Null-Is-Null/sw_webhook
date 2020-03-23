class CreateTagsTicketsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :tags, :tickets do |t|
      # t.index [:tag_id, :ticket_id]
      t.index [:ticket_id, :tag_id], unique: true
    end
  end
end
