module Spree
  module ActiveShippingProductDecorator
    def prepended(base)
      base.has_many :product_packages, dependent: :destroy

      base.accepts_nested_attributes_for :product_packages, allow_destroy: true, reject_if: lambda { |pp| (pp[:weight].blank? || (Integer(pp[:weight]) < 1)) }
    end
  end
end

if ::Spree::Product.included_modules.exclude?(
  Spree::ActiveShippingProductDecorator
)
  ::Spree::Product.prepend Spree::ActiveShippingProductDecorator
end
