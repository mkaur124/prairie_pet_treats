class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    event = Stripe::Event.construct_from(JSON.parse(request.body.read))

    case event.type
    when "checkout.session.completed"
      session = event.data.object
      order = Order.find_by(stripe_session_id: session.id)

      if order
        order.update(
          status_int: :paid,
          stripe_payment_intent_id: session.payment_intent,
          stripe_charge_id: session.charges&.data&.first&.id  # optional but helpful
        )
      end
    end

    render json: { message: "received" }
  end
end
