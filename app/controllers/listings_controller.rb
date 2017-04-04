class ListingsController < ApplicationController
     before_action :find_listing, only: [:show,:edit, :update]

  def index
    @listings = Listing.order(updated_at: :desc).page params[:page]
  end

  def new
    @listing = Listing.new
      # authorization code
      # end authorization code

      # other code to make the new action work!
  end


  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id
    byebug
    if  @listing.save
      redirect_to listing_path(@listing)
    end
  end

  def show
    @booking = @listing.bookings.new
  end

  def edit

  end

  def update
    if @listing.update(listing_params)
      flash[:success] = "Successfully updated the listing"
      redirect_to @listing
    else
      flash[:danger] = "Error updating listing"
      render :edit
    end
  end

private
  def find_listing
  @listing = Listing.find (params[:id])
  end

  def listing_params
    params.require(:listing).permit(:title, :description, :max_guest, :price, {images:[]})
  end


end
