module Spree
  module Admin
    module ActiveShippingProductsControllerDecorator
      def product_packages
        @product = Spree::Product.find_by_slug!(params[:id])
        @packages = @product.product_packages
        @product.product_packages.build
    
        respond_with(@object) do |format|
          format.html { render layout: !request.xhr? }
          format.js { render layout: false }
        end
      end
    end
  end
end

if ::Spree::Admin::ProductsController.included_modules.exclude?(
  Spree::Admin::ActiveShippingProductsControllerDecorator
)
  ::Spree::Admin::ProductsController.prepend Spree::Admin::ActiveShippingProductsControllerDecorator
end
