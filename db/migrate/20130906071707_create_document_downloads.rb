class CreateDocumentDownloads < ActiveRecord::Migration
  def change
    create_table :document_downloads do |t|
      t.timestamp :downloaded_at
      t.string :downloaded_from
      t.references :document

      t.timestamps
    end
    add_index :document_downloads, :document_id
  end
end
