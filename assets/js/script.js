(function($) {

 function init() {
    /**
     * Tags  activation based on hash value. If hash is undefined then first tab is activated.
     */
    function activateTab() {
      if(['/tags/', '/categories/'].indexOf(window.location.pathname) > -1) {
        var hash = window.location.hash;
        if(hash) {
        	$('.blog-list').hide();
        	$('.blog-list').length && $(hash).show();
        }
      }
    }

    // watch hash change and activate relevant tab
    $(window).on('hashchange', activateTab);
  };

  // run init on document ready
  $(document).ready(init);

})(jQuery);