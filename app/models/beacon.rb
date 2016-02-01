class Beacon < ActiveRecord::Base
  validates_uniqueness_of :major, :scope => :minor
  validates_uniqueness_of :name
  validates_inclusion_of :major, :in => 1..65535
  validates_inclusion_of :minor, :in => 1..65535

  validates :major, :presence => true
  validates :minor, :presence => true
  validates :name, :presence => true
end
