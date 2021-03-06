class CreateVotes < ActiveRecord::Migration
  def change
      create_table :votes do |t|
        t.float :number, default: 20
        t.string :key
        t.belongs_to :secret

        t.timestamps
    end
  end
end
