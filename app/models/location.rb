class Location < ActiveRecord::Base
  has_many :artworks
  belongs_to :beacon

  belongs_to :exhibition
  belongs_to :exhibition_including_deleted, :class_name => 'Exhibition', :foreign_key => 'exhibition_id', :with_deleted => true

  # API
  JSON_ATTRS = ['uuid', 'created_at', 'updated_at', 'deleted_at', 'name', 'beacon_id'].freeze

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

  private
    def set_uuid
      self.uuid = UUIDTools::UUID.timestamp_create().to_s
    end
end
