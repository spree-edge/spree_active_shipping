# handle shipping errors gracefully during checkout
module SpreeActiveShippingExtension::CheckoutControllerDecorator
  def self.prepended(base)
    # base.rescue_from Spree::ShippingError, with: :handle_shipping_error
  end

  private

  def handle_shipping_error(e)
    flash[:error] = e.message
    redirect_to checkout_state_path(:address)
  end
end

::Spree::CheckoutController.prepend(SpreeActiveShippingExtension::CheckoutControllerDecorator)
