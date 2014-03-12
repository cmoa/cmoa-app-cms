class Tour < ActiveRecord::Base
  belongs_to :exhibition
  belongs_to :exhibition_including_deleted, :class_name => 'Exhibition', :foreign_key => 'exhibition_id', :with_deleted => true

  has_many :tour_artworks
  has_many :artworks, :through => :tour_artworks, :order => '"tour_artworks"."position" asc'
  accepts_nested_attributes_for :tour_artworks

  # API
  JSON_ATTRS = ['uuid', 'created_at', 'updated_at', 'deleted_at', 'title', 'subtitle', 'body'].freeze

  # Soft delete
  acts_as_paranoid

  # UUID
  before_create :set_uuid

  # Validations
  validates :exhibition_id, :presence => true
  validates :title, :presence => true
  validates_as_paranoid
  validates_uniqueness_of_without_deleted :title, :scope => :exhibition_id

  def as_json(options=nil)
    attributes.slice(*JSON_ATTRS).merge({
      :exhibition_uuid => exhibition_including_deleted.uuid
    })
  end

  private
    def set_uuid
      self.uuid = UUIDTools::UUID.timestamp_create().to_s
    end
end