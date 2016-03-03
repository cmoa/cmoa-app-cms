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

  validate :single_attachment

  JSON_ATTRS = ["id", "major", "minor", "name", "location_id", "artwork_id"]


  def self.unassigned(selected)
    where_clause = "id not in (SELECT beacon_id FROM artworks where beacon_id is not null) AND id not in (SELECT beacon_id FROM locations where beacon_id is not null)"
    if selected.blank?

    else
      where_clause += " OR (id = '#{selected.id}')"
    end

    where(where_clause)
  end

  def self.attached
    where_clause = "id in (SELECT beacon_id FROM artworks where beacon_id is not null) OR id  in (SELECT beacon_id FROM locations where beacon_id is not null)"
    where(where_clause)
  end

  def self.exhibition_beacons(exhibition)
    e_beacons = Artwork.where("(beacon_id IS NOT NULL) AND (exhibition_id = ?)", exhibition.id).pluck("beacon_id")
    return e_beacons.uniq.count
  end

  def detach
    beacon = self.id
    Location.where(beacon_id: beacon).update_all(beacon_id: nil)
    Artwork.where(beacon_id: beacon).update_all(beacon_id: nil)
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
