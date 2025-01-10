Rails.application.config.after_initialize do
  if Spree::Core::Engine.backend_available?
    Rails.application.config.spree_backend.tabs[:product].add(
      ::Spree::Admin::Tabs::TabBuilder.new(
        ::Spree.t(:product_packages),
        ->(resource) {
          ::Spree::Core::Engine.routes.url_helpers.admin_product_product_packages_path(resource)
        }
      )
      .with_icon_key('tasks')
      .with_manage_ability_check(::Spree::ProductPackage)
      .with_active_check
      .build
    )

    Rails.application.config.spree_backend.main_menu.add_to_section(
      'settings',
      ::Spree::Admin::MainMenu::ItemBuilder.new(
        'active_shipping_settings',
        ::Spree::Core::Engine.routes.url_helpers.edit_admin_active_shipping_settings_path
      )
      .with_manage_ability_check(::Spree::ActiveShippingSetting)
      .with_match_path('/active_shipping_settings')
      .build
    )
  end
end
