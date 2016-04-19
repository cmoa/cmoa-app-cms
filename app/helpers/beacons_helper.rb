module BeaconsHelper
  def detach_beacon_path(beacon)
    "/beacons/#{beacon.id}/detach"
  end
end
