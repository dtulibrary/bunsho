class Document < ActiveRecord::Base
  attr_accessible :available_count, :downloaded_count, :drm, :mime_type, :uuid

  validates_presence_of :uuid, :mime_type
  validates :available_count, :numericality => { :only_integer => true}
  validates :downloaded_count, :numericality => { :only_integer => true}
  validates :drm, :inclusion => { :in => [true, false] }

  has_many :document_downloads, :dependent => :destroy

  def add_available_count
    self.available_count += 1
  end

end
