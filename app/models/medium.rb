class Medium < ActiveRecord::Base
  belongs_to :exhibition
  belongs_to :exhibition_including_deleted, :class_name => 'Exhibition', :foreign_key => 'exhibition_id', :with_deleted => true

  belongs_to :artwork
  belongs_to :artwork_including_deleted, :class_name => 'Artwork', :foreign_key => 'artwork_id', :with_deleted => true

  # API
  JSON_ATTRS = ['uuid', 'created_at', 'updated_at', 'deleted_at', 'title', 'kind', 'width', 'height', 'position', 'alt'].freeze

  # Soft delete
  acts_as_paranoid

  # File attachment
  has_attached_file :file, :styles => {
    :thumb  => '200x200#',
    :small  => '300x300',
    :medium => '600x600',
    :large  => '1200x1200'
  }, :processors => lambda { |m| (m.kind == 'video') ? [ :video_thumbnail ] : [ :thumbnail ] }

  before_post_process :verify_content_type
  before_save :extract_dimensions

  # UUID
  before_create :set_uuid

  # Validations
  validates :exhibition_id, :presence => true
  validates :artwork_id, :presence => true
  validates :title, :presence => true
  validates :file, :attachment_presence => true
  validates_attachment_content_type :file, :content_type => [
    'image/jpeg', 'image/png',
    'audio/mpeg', 'audio/mp4', 'audio/mp3',
    'video/mpeg', 'video/mp4', 'video/quicktime'
  ], :message => 'is incorrect. Please upload either an image, audio or a video file'

  # Scopes
  scope :image, -> { where(:kind => 'image') }
  scope :audio, -> { where(:kind => 'audio') }
  scope :video, -> { where(:kind => 'video') }

  def as_json(options=nil)
    attributes.slice(*JSON_ATTRS).merge({
      :exhibition_uuid => exhibition_including_deleted.uuid,
      :artwork_uuid => artwork_including_deleted.uuid,
      :urlThumb => file.url(:thumb),
      :urlSmall => file.url(:small),
      :urlMedium => file.url(:medium),
      :urlLarge => file.url(:large),
      :urlFull => file.url(:original)
    })
  end

  private
    def set_uuid
      self.uuid = UUIDTools::UUID.timestamp_create().to_s
    end

    # Figure out the type of the file
    # Halt post-process if not an image
    def verify_content_type
      self.kind = 'image' if %w(image/jpeg image/png).include?(file_content_type)
      self.kind = 'audio' if %w(audio/mpeg audio/mp4 audio/mp3).include?(file_content_type)
      self.kind = 'video' if %w(video/mpeg video/mp4 video/quicktime).include?(file_content_type)

      # Only post process images and video (for thumb generation) (not audio)
      self.kind != 'audio'
    end

    # Retrieves dimensions for image assets
    def extract_dimensions
      return if self.kind == 'audio'

      if self.kind == 'image'
        tempfile = file.queued_for_write[:original]
      elsif self.kind == 'video'
        tempfile = file.queued_for_write[:large] # large thumbnail for video
      end

      unless tempfile.nil?
        geometry = Paperclip::Geometry.from_file(tempfile)
        self.width = geometry.width.to_i
        self.height = geometry.height.to_i
      end
    end
end
