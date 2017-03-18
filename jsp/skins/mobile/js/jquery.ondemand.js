/*
* jQuery OnDemand Image Loader
*
* Developed by
* Copyright 2011 - Anthony McLin
* http://anthonymclin.com
* Version 1.0
* Licensed under GPLv2
*/
(function($){
  $.fn.onDemandLoader = function(options) {
 
    // Configuration
    options = $.extend({
      selector: null,
      spinner: null,
      callback : jQuery.noop
    }, options);
 
    //Change the source of all the images to point to the loading image
    $(options.selector).each( function() {
      //Write the original source to a temporary location
      $(this).attr('_src', $(this).attr('src'));
      //Change the image source to the loading image
      $(this).attr('src', options.spinner);
    });
  };
 
  //Load a specific image by changing the source back
  $.fn.onDemandLoader.loadImage = function(img) {
    $(img).attr('src', $(img).attr('_src'));
  };
})(jQuery);