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

  before_create :set_uuid

  JSON_ATTRS = ["uuid", "major", "minor", "name"]


  def self.unassigned(beacons = nil)
    where_clause = "(location_id IS NULL AND artwork_id IS NULL)"

    if beacons.blank?

    else
      beacon_ids = beacons.pluck(:id).join(',')

      where_clause += " OR (id IN (#{beacon_ids}))"
    end

    where(where_clause)
  end

  def self.attached
    where_clause = "(location_id IS NOT NULL OR artwork_id IS NOT NULL)"
    where(where_clause)
  end

  def self.exhibition_beacons(exhibition)
    e_beacons = Beacon.where(:artwork_id => Artwork.where(:exhibition_id => exhibition).select(:id)).pluck(:id)
    return e_beacons.uniq.count
  end

  def detach
    self.update_columns(:location_id => nil, :artwork_id => nil)
  end





  def as_json(options=nil)
    #Gather UUID from attachments
    if self.location_id.present?
      location_uuid = Location.where(:id => self.location_id).first.pluck(:uuid)
      return attributes.slice(*JSON_ATTRS).merge({
        :location_uuid => location_uuid
      })
    elsif self.artwork_id.present?
      artwork_uuid = Artwork.where(:id => self.artwork_id).first.pluck(:uuid)
      return attributes.slice(*JSON_ATTRS).merge({
        :artwork_uuid => artwork_uuid
      })
    else
      return attributes.slice(*JSON_ATTRS)
    end

  end


  def single_attachment
    if artwork.present?
      if location.present?
        errors.add(:base, "Can't attach a beacon to both a location and an object")
      end
    end
  end

private

  def set_uuid
    self.uuid = UUIDTools::UUID.timestamp_create().to_s
  end
end
