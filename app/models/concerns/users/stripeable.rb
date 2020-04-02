module Users
  module Stripeable
    extend ActiveSupport::Concern

    # Gets the Stripe customer from the Stripe API
    # Creates the Stripe customer in Stripe if one doesn't exist
    def stripe_customer
      return Stripe::Customer.retrieve(stripe_customer_id) if stripe_customer_id
      create_stripe_customer!
    end

    def create_stripe_charge!(source_id:, amount:, currency:, description:, metadata: {})
      customer = stripe_customer
      customer.source = source_id
      customer.save

      Stripe::Charge.create(
        customer: customer.id,
        amount: amount,
        currency: currency,
        description: description,
        metadata: metadata
      )
    end

    private

    def create_stripe_customer!
      stripe_customer ||= Stripe::Customer.create(
        email: email,
        metadata: {
          id: id,
          first_name: first_name,
          last_name: last_name,
          company_name: company_name,
          email: email
        }
      )
      update! stripe_customer_id: stripe_customer.id
      stripe_customer
    end
  end
end
