class Artist < ActiveRecord::Base
  belongs_to :exhibition
  belongs_to :exhibition_including_deleted, :class_name => 'Exhibition', :foreign_key => 'exhibition_id', :with_deleted => true

  has_many :artist_artworks
  has_many :artworks, :through => :artist_artworks, :order => '"artworks"."title" asc'
  has_many :links, -> { order('position asc') }

  # API
  JSON_ATTRS = ['uuid', 'created_at', 'updated_at', 'deleted_at', 'first_name', 'last_name', 'country', 'bio', 'code'].freeze

  # Soft delete
  acts_as_paranoid

  # UUID
  before_create :set_uuid

  # Validations
  validates :exhibition_id, :presence => true
  validates :last_name, :presence => true
  validates :country, :presence => true
  validates :code, :presence => true
  validates_as_paranoid
  validates_uniqueness_of_without_deleted :code

  def as_json(options=nil)
    attributes.slice(*JSON_ATTRS).merge({
      :exhibition_uuid => exhibition_including_deleted.uuid
    })
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end

  private
    def set_uuid
      self.uuid = UUIDTools::UUID.timestamp_create().to_s
    end
end