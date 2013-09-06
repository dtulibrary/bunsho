class DocumentDownload < ActiveRecord::Base
  attr_accessible :document, :downloaded_at, :downloaded_from

  belongs_to :document

  validates_datetime :downloaded_at, :presence => true
  validates :downloaded_from, :presence => true
  validates :document, :presence => true
end
