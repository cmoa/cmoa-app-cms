class Exhibition < ActiveRecord::Base
  has_many :artists
  has_many :artist_artworks
  has_many :artworks
  has_many :links
  has_many :media
  has_many :tours
  has_many :tourArtworks
  has_many :likes

  # API
  JSON_ATTRS = ['uuid', 'created_at', 'updated_at', 'deleted_at', 'title', 'subtitle', 'is_live', 'position', 'sponsor', 'bg_iphone_updated_at', 'bg_ipad_updated_at', 'bg_iphone_file_size', 'bg_ipad_file_size'].freeze

  # Soft delete
  acts_as_paranoid

  # File attachments
  has_attached_file :bg_iphone, :styles => {
    :thumb  => '200x200#',
    :normal => '320x568',
  }, :path => ':uuid/iphone/:style.:content_type_extension'
  has_attached_file :bg_ipad, :styles => {
    :thumb  => '200x200#',
    :normal => '703x704',
  }, :path => ':uuid/ipad/:style.:content_type_extension'

  # UUID
  before_create :set_uuid

  # Validations
  validates :title, :presence => true
  validates :subtitle, :presence => true
  validates_attachment_presence :bg_iphone
  validates_attachment_presence :bg_ipad
  validates_attachment_content_type :bg_iphone, :content_type => 'image/png', :message => 'is incorrect. Please upload a PNG image.'
  validates_attachment_content_type :bg_ipad, :content_type => 'image/png', :message => 'is incorrect. Please upload a PNG image.'
  validate :validate_dimensions, :unless => "errors.any?"

  def as_json(options=nil)
    attributes.slice(*JSON_ATTRS).merge({
      :bg_iphone_normal => bg_iphone.url(:normal),
      :bg_iphone_retina => bg_iphone.url(:original),
      :bg_ipad_normal   => bg_ipad.url(:normal),
      :bg_ipad_retina   => bg_ipad.url(:original)
    })
  end

  private
    def set_uuid
      self.uuid = UUIDTools::UUID.timestamp_create().to_s
    end

    # Validate dimensions
    def validate_dimensions
      # iPhone
      iphoneFile = bg_iphone.queued_for_write[:original]
      unless iphoneFile.nil?
        geometry = Paperclip::Geometry.from_file(iphoneFile)
        width = geometry.width.to_i
        height = geometry.height.to_i
        if width != 640 || height != 1136
          errors.add(:bg_iphone, 'image must be 640x1136 pixels')
        end
      end

      # iPad
      ipadFile = bg_ipad.queued_for_write[:original]
      unless ipadFile.nil?
        geometry = Paperclip::Geometry.from_file(ipadFile)
        width = geometry.width.to_i
        height = geometry.height.to_i
        if width != 1406 || height != 1408
          errors.add(:bg_ipad, 'image must be 1406x1408 pixels')
        end
      end
    end
end