require 'open-uri'
require 'uuidtools'

class Document < ActiveRecord::Base
  attr_accessible :available_count, :downloaded_count, :drm, :mime_type, :uuid

  validates_presence_of :uuid, :mime_type
  validates :available_count, :numericality => { :only_integer => true}
  validates :downloaded_count, :numericality => { :only_integer => true}
  validates :drm, :inclusion => { :in => [true, false] }

  has_many :document_downloads, :dependent => :destroy

  before_destroy { |rec| FileUtils.rm rec.file_name, :force => true }

  def initialize(*args)
    super(*args)
    self.uuid ||= UUIDTools::UUID.timestamp_create.to_s
    self.available_count ||= config.default_available_count || 5
    # Create directory for file
    FileUtils.mkdir_p(File.dirname(file_name))
  end

  def self.new_from_request(request, drm)
    document = new( :mime_type => request.media_type )
    document.drm = drm == 'true' ? true : false
    File.open(document.file_name, 'wb') do |f|
      FileUtils.copy_stream(request.body, f)
    end
    document
  end

  def self.new_from_url(url, drm)
    document = new
    document.drm = drm == 'true' ? true : false
    if document.download_url(url)
      document
    else
      document.destroy
      nil
    end
  end

  def add_available_count
    self.available_count += 1
  end

  def download_url(url)
    begin
      open(url) do |s|
        self.mime_type = s.content_type
        File.open(file_name, 'wb') { |f| FileUtils.copy_stream(s, f) }
        true
      end
    rescue OpenURI::HTTPError
      logger.info "Download #{url} failed"
      false
    end
  end

  def file_name
    File.join(config.store_dir, uuid.gsub(/^(.)(.)/, '\1/\2/'))
  end

  def to_param
    self.uuid
  end

  private

  def config
    Rails.application.config
  end

end
