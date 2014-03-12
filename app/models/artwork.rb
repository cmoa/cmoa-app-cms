class Artwork < ActiveRecord::Base
  belongs_to :exhibition
  belongs_to :exhibition_including_deleted, :class_name => 'Exhibition', :foreign_key => 'exhibition_id', :with_deleted => true

  belongs_to :category
  belongs_to :category_including_deleted, :class_name => 'Category', :foreign_key => 'category_id', :with_deleted => true

  belongs_to :location
  belongs_to :location_including_deleted, :class_name => 'Location', :foreign_key => 'location_id', :with_deleted => true

  has_many :tour_artwork
  has_many :tours, :through => :tour_artworks
  has_many :media, -> { order('position asc') }
  has_many :likes
  has_many :artist_artworks
  has_many :artists, -> { order('"artists"."last_name" asc') }, :through => :artist_artworks

  # API
  JSON_ATTRS = ['uuid', 'created_at', 'updated_at', 'deleted_at', 'title', 'code', 'body', 'share_url'].freeze

  # Soft delete
  acts_as_paranoid

  # UUID
  before_create :set_uuid

  # Validations
  validates :exhibition_id, :presence => true
  validates :category_id, :presence => true
  validates :location_id, :presence => true
  validates :title, :presence => true
  validates :code, :presence => true
  validates_as_paranoid
  validates_uniqueness_of_without_deleted :code

  def as_json(options=nil)
    attributes.slice(*JSON_ATTRS).merge({
      :exhibition_uuid => exhibition_including_deleted.uuid,
      :location_uuid => location_including_deleted.uuid,
      :category_uuid => category_including_deleted.uuid
    })
  end

  private
    def set_uuid
      self.uuid = UUIDTools::UUID.timestamp_create().to_s
    end
end