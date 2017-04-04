class PaymentsController < ApplicationController
  before_action :require_login

  def new
    @client_token = Braintree::ClientToken.generate
    @booking = Booking.find(params[:booking_id])
    @payment = Payment.new
  end

  def create
     amount = params[:payment][:total_price]
     nonce = params[:payment_method_nonce]

     render action :new and return unless nonce

     @result = Braintree::Transaction.sale(
      amount: amount,
      payment_method_nonce: params[:payment_method_nonce]
     )

     if @result.success?
       Payment.create(booking_id: params[:payment][:booking_id], braintree_payment_id: @result.transaction.id, status: @result.transaction.status, fourdigit: @result.transaction.credit_card_details.last_4)
       flash[:notice] = "Congratulations!"
       redirect_to bookings_path
     else
       Payment.create(booking_id: params[:payment][:booking_id], braintree_payment_id: @result.transaction.id, status: @result.transaction.status, fourdigit: @result.transaction.credit_card_details.last_4)
       flash[:error] = "Failure!"
       redirect_to new_booking_payment_path(Booking.find(params[:payment][:booking_id]))
     end
  end
end
