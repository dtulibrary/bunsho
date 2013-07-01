class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :available_count, :null => false
      t.string :uuid, :null => false
      t.string :mime_type, :null => false
      t.boolean :drm, :null => false, :default => false
      t.integer :downloaded_count, :default => 0

      t.timestamps
    end
  end
end
