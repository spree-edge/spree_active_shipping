module Spree::ActiveShipping
end

module SpreeActiveShippingExtension
  class Engine < Rails::Engine
    config.after_initialize do
      Spree::ActiveShipping::Config = Spree::ActiveShippingConfiguration.new
    end

    def self.activate
      Dir[File.join(File.dirname(__FILE__), "../../app/models/spree/calculator/**/base.rb")].sort.each do |c|
        Rails.env.production? ? require(c) : load(c)
      end

      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end

      ActiveShipping::UPS.send(:include, Spree::ActiveShipping::UpsOverride)
      ActiveShipping::CanadaPost.send(:include, Spree::ActiveShipping::CanadaPostOverride)
    end

    config.autoload_paths += %W(#{config.root}/lib)
    config.to_prepare &method(:activate).to_proc

    config.after_initialize do
      if Rails.application.config.spree.calculators.shipping_methods
        calculators_path = File.expand_path("../../app/models/spree/calculator", __dir__)
    
        classes = Dir.glob(File.join(calculators_path, "**/*.rb"))
                     .reject { |path| path =~ /base\.rb$/ }
                     .map do |path|
                       base_path = "/home/ishan/apps/spree_active_shipping/app/models/"
                       path.sub(base_path, '').sub('.rb', '').gsub('/', '::').split('::').map { |word| word.split('_').map(&:capitalize).join }.join('::').constantize
                     end
        Rails.application.config.spree.calculators.shipping_methods.concat(classes)
      end
    end

    initializer "spree.assets.precompile", group: :all do |app|
      app.config.assets.precompile += %w[
        admin/product_packages/new.js
        admin/product_packages/edit.js
        admin/product_packages/index.js
      ]
    end
  end
end
