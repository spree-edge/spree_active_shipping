(function() {
  ($('#cancel_link')).click(function(event) {
    event.preventDefault();
    ($('.no-objects-found')).show();
    ($('#new_product_package_link')).show();
    return ($('#product_packages')).html('');
  });

}).call(this);
