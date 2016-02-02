class Beacon < ActiveRecord::Base
  has_one :artwork
  has_one :location


  validates_uniqueness_of :major, :scope => :minor
  validates_uniqueness_of :name
  validates_inclusion_of :major, :in => 1..65535
  validates_inclusion_of :minor, :in => 1..65535

  validates_associated :artwork, :location

  validates :major, :presence => true
  validates :minor, :presence => true
  validates :name, :presence => true

  JSON_ATTRS = ["major", "minor", "name"]


  def self.unassigned(selected)
    where_clause = "(id NOT IN ( (SELECT DISTINCT(beacon_id) FROM artworks) UNION (SELECT DISTINCT(beacon_id) FROM locations) )"
    if selected.blank?
      where_clause += " )"
    else
      where_clause += " OR (id = '#{selected.id}') )"
    end

    where(where_clause)
  end



  def as_json(options=nil)
    attributes.slice(*JSON_ATTRS)
  end
end
