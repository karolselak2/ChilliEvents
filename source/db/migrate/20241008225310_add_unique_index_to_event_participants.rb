class AddUniqueIndexToEventParticipants < ActiveRecord::Migration[7.2]
  def change
    add_index :event_participants, [:user_id, :event_id], unique: true
  end
end
