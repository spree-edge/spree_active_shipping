(function() {
  $(function() {
    ($('#new_product_package_link')).click(function(event) {
      event.preventDefault();
      ($('.no-objects-found')).hide();
      ($(this)).hide();
      return $.ajax({
        type: 'GET',
        url: this.href,
        data: {
          authenticity_token: AUTH_TOKEN
        },
        success: function(r) {
          return ($('#product_packages')).html(r);
        }
      });
    });
    return ($('a.edit')).click(function(event) {
      event.preventDefault();
      ($('#product_packages')).html('');
      return $.ajax({
        type: 'GET',
        url: this.href,
        data: {
          authenticity_token: AUTH_TOKEN
        },
        success: function(r) {
          return ($('#product_packages')).html(r);
        }
      });
    });
  });

}).call(this);
