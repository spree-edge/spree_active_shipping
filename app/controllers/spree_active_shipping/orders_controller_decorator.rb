# handle shipping errors gracefully during order update
module SpreeActiveShippingExtension::OrdersControllerDecorator
  def self.prepended(base)
    base.rescue_from Spree::ShippingError, with: :handle_shipping_error
  end

  private

  def handle_shipping_error(e)
    flash[:error] = e.message
    redirect_back_or_default(root_path)
  end
end

::Spree::OrdersController.prepend(SpreeActiveShippingExtension::OrdersControllerDecorator)
