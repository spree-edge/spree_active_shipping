module Spree
  module ActiveShippingLineItemDecorator
    def self.prepended(base)
      base.has_many :product_packages, through: :product
    end
  end
end

if ::Spree::LineItem.included_modules.exclude?(
  Spree::ActiveShippingLineItemDecorator
)
  ::Spree::LineItem.prepend Spree::ActiveShippingLineItemDecorator
end
