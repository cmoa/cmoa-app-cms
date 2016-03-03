class TourArtworksController < ApplicationController
  before_action :set_exhibition
  before_action :set_tour, only: [:edit, :update]
  cache_sweeper :cache_sweeper, :only => [:update]
  before_action do
    set_focus('tours')
  end

  def edit
    @artworks = @exhibition.artworks.order('title asc').all
  end

  def update
    # First remove all artworks for this tour
    @tour.tour_artworks.destroy_all
    @tour.tour_artworks.with_deleted.each do |tour_artwork|
      tour_artwork.updated_at = DateTime.now
      tour_artwork.save
    end

    # Add new artworks to this tour
    unless tour_params['tour_artworks'].nil?
      tour_params['tour_artworks'].each do |tour_artwork_data|
        tour_artwork = TourArtwork.new
        tour_artwork.tour_id = @tour.id
        tour_artwork.artwork_id = tour_artwork_data['artwork_id'].to_i
        tour_artwork.exhibition_id = @exhibition.id
        tour_artwork.position = tour_artwork_data['position'].to_i
        tour_artwork.save
      end
    end

    return redirect_to exhibition_tour_path(@exhibition, @tour), :notice => 'Artworks have been successfully modified for this tour.'
  end

  private
    def set_tour
      @tour = Tour.find(params[:tour_id])
    end

    def tour_params
      params.permit(:tour_artworks => [
        :artwork_id, :position
      ])
    end
end
