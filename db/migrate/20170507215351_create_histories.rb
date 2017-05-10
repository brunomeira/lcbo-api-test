class CreateHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :histories do |t|
			t.references :user
      t.jsonb :data

      t.timestamps
    end
  end
end
