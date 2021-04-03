(function() {
  ($('#cancel_link')).click(function(event) {
    event.preventDefault();
    return ($('#product_packages')).html('');
  });

}).call(this);
