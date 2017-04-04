class ReservationsController < ApplicationController
  def create

    @host = "abc@gmail.com"
    if @reservation.save
      ReservationMailer.notification_email(current_user.email, @host, @reservation.listing.id, @reservation.id).deliver_now
      # ReservationMailer to send a notification email after save
    end
  end
end
