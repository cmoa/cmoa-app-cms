class Location < ActiveRecord::Base
  has_many :artworks
  has_many :beacons, :dependent => :nullify

  # API
  JSON_ATTRS = ['uuid', 'created_at', 'updated_at', 'deleted_at', 'name'].freeze

  # Soft delete
  acts_as_paranoid

  # UUID
  before_create :set_uuid

  # Validations
  validates :name, :presence => true
  validates_as_paranoid
  validates_uniqueness_of_without_deleted :name

  def as_json(options=nil)
    attributes.slice(*JSON_ATTRS)
  end

  def exhibition_artworks(exhibition)
    self.artworks.where(exhibition_id: exhibition)
  end

  private
    def set_uuid
      self.uuid = UUIDTools::UUID.timestamp_create().to_s
    end
end
