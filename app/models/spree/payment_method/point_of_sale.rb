module Spree
  class PaymentMethod::PointOfSale < PaymentMethod
    
    def actions
      %i{capture void}
    end

    # Indicates whether its possible to capture the payment
    def can_capture?(payment)
      ['checkout', 'pending'].include?(payment.state)
    end

    # Indicates whether its possible to void the payment.
    def can_void?(payment)
      payment.state != 'void'
    end

    def capture(*args)
      ActiveMerchant::Billing::Response.new(true, "", {}, {})
    end
    alias_method :void, :capture

    def source_required?
      false
    end
  end
end
