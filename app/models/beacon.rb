class Beacon < ActiveRecord::Base
  belongs_to :artwork
  belongs_to :location


  validates_uniqueness_of :major, :scope => :minor
  validates_uniqueness_of :name
  validates_inclusion_of :major, :in => 1..65535
  validates_inclusion_of :minor, :in => 1..65535

  validates_associated :artwork, :location

  validates :major, :presence => true
  validates :minor, :presence => true
  validates :name, :presence => true

  #validate :single_attachment

  JSON_ATTRS = ["id", "major", "minor", "name", "locations_id", "artworks_id"]


  def self.unassigned(beacons = nil)
    where_clause = "(locations_id IS NULL AND artworks_id IS NULL)"

    if beacons.blank?

    else
      beacon_ids = beacons.pluck(:id).join(',')

      where_clause += " OR (id IN (#{beacon_ids}))"
    end

    where(where_clause)
  end

  def self.attached
    where_clause = "(locations_id IS NOT NULL OR artworks_id IS NOT NULL)"
    where(where_clause)
  end

  def self.exhibition_beacons(exhibition)
    e_beacons = Beacon.where(:artworks_id => Artwork.where(:exhibitions_id => exhibition).select(:id)).pluck(:id)
    return e_beacons.uniq.count
  end

  def detach
    self.update_columns(:locations_id => nil, :artworks_id => nil)
  end





  def as_json(options=nil)
    attributes.slice(*JSON_ATTRS)
  end

  def single_attachment
    if artwork.present?
      if location.present?
        errors.add(:base, "Can't attach a beacon to both a location and an object")
      end
    end
  end
end
