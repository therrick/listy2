// usage: isMobile.any() or isMobile.iOS() will return true or false
var isMobile = {
  Android: function() {
    return navigator.userAgent.match(/Android/i);
  },
  BlackBerry: function() {
    return navigator.userAgent.match(/BlackBerry/i);
  },
  iOS: function() {
    return navigator.userAgent.match(/iPhone|iPad|iPod/i);
  },
  Opera: function() {
    return navigator.userAgent.match(/Opera Mini/i);
  },
  Windows: function() {
    return navigator.userAgent.match(/IEMobile/i) || navigator.userAgent.match(/WPDesktop/i);
  },
  any: function() {
    return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
  }
};

// return true if device width is in bootstrap XS range
function isXS(){
  return (
  screen.width < 768
  );
}


// $(element).goTo will scroll element to top of screen
(function($) {
  $.fn.goTo = function() {
    $('html, body').animate({
      scrollTop: ($(this).offset().top - 51) + 'px'
    }, 'slow');
    return this; // for chaining...
  }
})(jQuery);
