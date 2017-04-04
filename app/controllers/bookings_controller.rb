class BookingsController < ApplicationController

  def index

  end

  def create
    @listing = Listing.find(params[:listing_id])
    @booking = current_user.bookings.new(reformat_params)
    @booking.listing_id = @listing.id
      if @booking.save
        # ReservationMailer.notification_email(current_user.email, @listing.user, @booking.listing.id, @booking.id).deliver_now
        redirect_to current_user
      else
      flash[:error] = @booking.errors.full_messages
      render "listings/show"
  end
end

  def destroy
    @booking = Booking.find(params:id)
    @booking.destroy
    redirect_to @booking.user
  end

  def booking_params
    params.require(:booking).permit(:num_guests, :start_date, :end_date)
  end

  def reformat_params
    params = booking_params
    params[:start_date] = Date.strptime(params[:start_date], "%m/%d/%Y")
    params[:end_date] = Date.strptime(params[:end_date], "%m/%d/%Y")
    params
  end

end
