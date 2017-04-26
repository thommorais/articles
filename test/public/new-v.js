(function(){

    var DomReady = window.DomReady = {};

	// Everything that has to do with properly supporting our document ready event. Brought over from the most awesome jQuery.

    var userAgent = navigator.userAgent.toLowerCase();

    // Figure out what browser is being used
    var browser = {
    	version: (userAgent.match( /.+(?:rv|it|ra|ie)[\/: ]([\d.]+)/ ) || [])[1],
    	safari: /webkit/.test(userAgent),
    	opera: /opera/.test(userAgent),
    	msie: (/msie/.test(userAgent)) && (!/opera/.test( userAgent )),
    	mozilla: (/mozilla/.test(userAgent)) && (!/(compatible|webkit)/.test(userAgent))
    };

	var readyBound = false;
	var isReady = false;
	var readyList = [];

	// Handle when the DOM is ready
	function domReady() {
		// Make sure that the DOM is not already loaded
		if(!isReady) {
			// Remember that the DOM is ready
			isReady = true;

	        if(readyList) {
	            for(var fn = 0; fn < readyList.length; fn++) {
	                readyList[fn].call(window, []);
	            }

	            readyList = [];
	        }
		}
	};

	// From Simon Willison. A safe way to fire onload w/o screwing up everyone else.
	function addLoadEvent(func) {
	  var oldonload = window.onload;
	  if (typeof window.onload != 'function') {
	    window.onload = func;
	  } else {
	    window.onload = function() {
	      if (oldonload) {
	        oldonload();
	      }
	      func();
	    }
	  }
	};

	// does the heavy work of working through the browsers idiosyncracies (let's call them that) to hook onload.
	function bindReady() {
		if(readyBound) {
		    return;
	    }

		readyBound = true;

		// Mozilla, Opera (see further below for it) and webkit nightlies currently support this event
		if (document.addEventListener && !browser.opera) {
			// Use the handy event callback
			document.addEventListener("DOMContentLoaded", domReady, false);
		}

		// If IE is used and is not in a frame
		// Continually check to see if the document is ready
		if (browser.msie && window == top) (function(){
			if (isReady) return;
			try {
				// If IE is used, use the trick by Diego Perini
				// http://javascript.nwbox.com/IEContentLoaded/
				document.documentElement.doScroll("left");
			} catch(error) {
				setTimeout(arguments.callee, 0);
				return;
			}
			// and execute any waiting functions
		    domReady();
		})();

		if(browser.opera) {
			document.addEventListener( "DOMContentLoaded", function () {
				if (isReady) return;
				for (var i = 0; i < document.styleSheets.length; i++)
					if (document.styleSheets[i].disabled) {
						setTimeout( arguments.callee, 0 );
						return;
					}
				// and execute any waiting functions
	            domReady();
			}, false);
		}

		if(browser.safari) {
		    var numStyles;
			(function(){
				if (isReady) return;
				if (document.readyState != "loaded" && document.readyState != "complete") {
					setTimeout( arguments.callee, 0 );
					return;
				}
				if (numStyles === undefined) {
	                var links = document.getElementsByTagName("link");
	                for (var i=0; i < links.length; i++) {
	                	if(links[i].getAttribute('rel') == 'stylesheet') {
	                	    numStyles++;
	                	}
	                }
	                var styles = document.getElementsByTagName("style");
	                numStyles += styles.length;
				}
				if (document.styleSheets.length != numStyles) {
					setTimeout( arguments.callee, 0 );
					return;
				}

				// and execute any waiting functions
				domReady();
			})();
		}

		// A fallback to window.onload, that will always work
	    addLoadEvent(domReady);
	};

	// This is the public function that people can use to hook up ready.
	DomReady.ready = function(fn, args) {
		// Attach the listeners
		bindReady();

		// If the DOM is already ready
		if (isReady) {
			// Execute the function immediately
			fn.call(window, []);
	    } else {
			// Add the function to the wait list
	        readyList.push( function() { return fn.call(window, []); } );
	    }
	};

	bindReady();

})();

var body = '';
DomReady.ready(function() {
   body = document.querySelector('body')
});

/*!
 * classie - class helper functions
 * from bonzo https://github.com/ded/bonzo
 * 
 * classie.has( elem, 'my-class' ) -> true/false
 * classie.add( elem, 'my-new-class' )
 * classie.remove( elem, 'my-unwanted-class' )
 * classie.toggle( elem, 'my-class' )
 */

/*jshint browser: true, strict: true, undef: true */
/*global define: false */

( function( window ) {

'use strict';

// class helper functions from bonzo https://github.com/ded/bonzo

function classReg( className ) {
  return new RegExp("(^|\\s+)" + className + "(\\s+|$)");
}

// classList support for class management
// altho to be fair, the api sucks because it won't accept multiple classes at once
var hasClass, addClass, removeClass;

if ( 'classList' in document.documentElement ) {
  hasClass = function( elem, c ) {
    return elem.classList.contains( c );
  };
  addClass = function( elem, c ) {
    elem.classList.add( c );
  };
  removeClass = function( elem, c ) {
    elem.classList.remove( c );
  };
}
else {
  hasClass = function( elem, c ) {
    return classReg( c ).test( elem.className );
  };
  addClass = function( elem, c ) {
    if ( !hasClass( elem, c ) ) {
      elem.className = elem.className + ' ' + c;
    }
  };
  removeClass = function( elem, c ) {
    elem.className = elem.className.replace( classReg( c ), ' ' );
  };
}

function toggleClass( elem, c ) {
  var fn = hasClass( elem, c ) ? removeClass : addClass;
  fn( elem, c );
}

var classie = {
  // full names
  hasClass: hasClass,
  addClass: addClass,
  removeClass: removeClass,
  toggleClass: toggleClass,
  // short names
  has: hasClass,
  add: addClass,
  remove: removeClass,
  toggle: toggleClass
};

// transport
if ( typeof define === 'function' && define.amd ) {
  // AMD
  define( classie );
} else {
  // browser global
  window.classie = classie;
}

})( window );

/*! lightgallery - v1.3.9 - 2017-02-05
* http://sachinchoolur.github.io/lightGallery/
* Copyright (c) 2017 Sachin N; Licensed GPLv3 */

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    // AMD. Register as an anonymous module unless amdModuleId is set
    define(['jquery'], function (a0) {
      return (factory(a0));
    });
  } else if (typeof exports === 'object') {
    // Node. Does not work with strict CommonJS, but
    // only CommonJS-like environments that support module.exports,
    // like Node.
    module.exports = factory(require('jquery'));
  } else {
    factory(root["jQuery"]);
  }
}(this, function ($) {

(function() {
    'use strict';

    var defaults = {

        mode: 'lg-slide',

        // Ex : 'ease'
        cssEasing: 'ease',

        //'for jquery animation'
        easing: 'linear',
        speed: 600,
        height: '100%',
        width: '100%',
        addClass: '',
        startClass: 'lg-start-zoom',
        backdropDuration: 150,
        hideBarsDelay: 6000,

        useLeft: false,

        closable: true,
        loop: true,
        escKey: true,
        keyPress: true,
        controls: true,
        slideEndAnimatoin: true,
        hideControlOnEnd: false,
        mousewheel: true,

        getCaptionFromTitleOrAlt: true,

        // .lg-item || '.lg-sub-html'
        appendSubHtmlTo: '.lg-sub-html',

        subHtmlSelectorRelative: false,

        /**
         * @desc number of preload slides
         * will exicute only after the current slide is fully loaded.
         *
         * @ex you clicked on 4th image and if preload = 1 then 3rd slide and 5th
         * slide will be loaded in the background after the 4th slide is fully loaded..
         * if preload is 2 then 2nd 3rd 5th 6th slides will be preloaded.. ... ...
         *
         */
        preload: 1,
        showAfterLoad: true,
        selector: '',
        selectWithin: '',
        nextHtml: '',
        prevHtml: '',

        // 0, 1
        index: false,

        iframeMaxWidth: '100%',

        download: true,
        counter: true,
        appendCounterTo: '.lg-toolbar',

        swipeThreshold: 50,
        enableSwipe: true,
        enableDrag: true,

        dynamic: false,
        dynamicEl: [],
        galleryId: 1
    };

    function Plugin(element, options) {

        // Current lightGallery element
        this.el = element;

        // Current jquery element
        this.$el = $(element);

        // lightGallery settings
        this.s = $.extend({}, defaults, options);

        // When using dynamic mode, ensure dynamicEl is an array
        if (this.s.dynamic && this.s.dynamicEl !== 'undefined' && this.s.dynamicEl.constructor === Array && !this.s.dynamicEl.length) {
            throw ('When using dynamic mode, you must also define dynamicEl as an Array.');
        }

        // lightGallery modules
        this.modules = {};

        // false when lightgallery complete first slide;
        this.lGalleryOn = false;

        this.lgBusy = false;

        // Timeout function for hiding controls;
        this.hideBartimeout = false;

        // To determine browser supports for touch events;
        this.isTouch = ('ontouchstart' in document.documentElement);

        // Disable hideControlOnEnd if sildeEndAnimation is true
        if (this.s.slideEndAnimatoin) {
            this.s.hideControlOnEnd = false;
        }

        // Gallery items
        if (this.s.dynamic) {
            this.$items = this.s.dynamicEl;
        } else {
            if (this.s.selector === 'this') {
                this.$items = this.$el;
            } else if (this.s.selector !== '') {
                if (this.s.selectWithin) {
                    this.$items = $(this.s.selectWithin).find(this.s.selector);
                } else {
                    this.$items = this.$el.find($(this.s.selector));
                }
            } else {
                this.$items = this.$el.children();
            }
        }

        // .lg-item
        this.$slide = '';

        // .lg-outer
        this.$outer = '';

        this.init();

        return this;
    }

    Plugin.prototype.init = function() {

        var _this = this;

        // s.preload should not be more than $item.length
        if (_this.s.preload > _this.$items.length) {
            _this.s.preload = _this.$items.length;
        }

        // if dynamic option is enabled execute immediately
        var _hash = window.location.hash;
        if (_hash.indexOf('lg=' + this.s.galleryId) > 0) {

            _this.index = parseInt(_hash.split('&slide=')[1], 10);

            $('body').addClass('lg-from-hash');
            if (!$('body').hasClass('lg-on')) {
                setTimeout(function() {
                    _this.build(_this.index);
                });

                $('body').addClass('lg-on');
            }
        }

        if (_this.s.dynamic) {

            _this.$el.trigger('onBeforeOpen.lg');

            _this.index = _this.s.index || 0;

            // prevent accidental double execution
            if (!$('body').hasClass('lg-on')) {
                setTimeout(function() {
                    _this.build(_this.index);
                    $('body').addClass('lg-on');
                });
            }
        } else {

            // Using different namespace for click because click event should not unbind if selector is same object('this')
            _this.$items.on('click.lgcustom', function(event) {

                // For IE8
                try {
                    event.preventDefault();
                    event.preventDefault();
                } catch (er) {
                    event.returnValue = false;
                }

                _this.$el.trigger('onBeforeOpen.lg');

                _this.index = _this.s.index || _this.$items.index(this);

                // prevent accidental double execution
                if (!$('body').hasClass('lg-on')) {
                    _this.build(_this.index);
                    $('body').addClass('lg-on');
                }
            });
        }

    };

    Plugin.prototype.build = function(index) {

        var _this = this;

        _this.structure();

        // module constructor
        $.each($.fn.lightGallery.modules, function(key) {
            _this.modules[key] = new $.fn.lightGallery.modules[key](_this.el);
        });

        // initiate slide function
        _this.slide(index, false, false, false);

        if (_this.s.keyPress) {
            _this.keyPress();
        }

        if (_this.$items.length > 1) {

            _this.arrow();

            setTimeout(function() {
                _this.enableDrag();
                _this.enableSwipe();
            }, 50);

            if (_this.s.mousewheel) {
                _this.mousewheel();
            }
        }

        _this.counter();

        _this.closeGallery();

        _this.$el.trigger('onAfterOpen.lg');

        // Hide controllers if mouse doesn't move for some period
        _this.$outer.on('mousemove.lg click.lg touchstart.lg', function() {

            _this.$outer.removeClass('lg-hide-items');

            clearTimeout(_this.hideBartimeout);

            // Timeout will be cleared on each slide movement also
            _this.hideBartimeout = setTimeout(function() {
                _this.$outer.addClass('lg-hide-items');
            }, _this.s.hideBarsDelay);

        });

        _this.$outer.trigger('mousemove.lg');

    };

    Plugin.prototype.structure = function() {
        var list = '';
        var controls = '';
        var i = 0;
        var subHtmlCont = '';
        var template;
        var _this = this;

        $('body').append('<div class="lg-backdrop"></div>');
        $('.lg-backdrop').css('transition-duration', this.s.backdropDuration + 'ms');

        // Create gallery items
        for (i = 0; i < this.$items.length; i++) {
            list += '<div class="lg-item"></div>';
        }

        // Create controlls
        if (this.s.controls && this.$items.length > 1) {
            controls = '<div class="lg-actions">' +
                '<div class="lg-prev lg-icon">' + this.s.prevHtml + '</div>' +
                '<div class="lg-next lg-icon">' + this.s.nextHtml + '</div>' +
                '</div>';
        }

        if (this.s.appendSubHtmlTo === '.lg-sub-html') {
            subHtmlCont = '<div class="lg-sub-html"></div>';
        }

        template = '<div class="lg-outer ' + this.s.addClass + ' ' + this.s.startClass + '">' +
            '<div class="lg" style="width:' + this.s.width + '; height:' + this.s.height + '">' +
            '<div class="lg-inner">' + list + '</div>' +
            '<div class="lg-toolbar lg-group">' +
            '<span class="lg-close lg-icon"></span>' +
            '</div>' +
            controls +
            subHtmlCont +
            '</div>' +
            '</div>';

        $('body').append(template);
        this.$outer = $('.lg-outer');
        this.$slide = this.$outer.find('.lg-item');

        if (this.s.useLeft) {
            this.$outer.addClass('lg-use-left');

            // Set mode lg-slide if use left is true;
            this.s.mode = 'lg-slide';
        } else {
            this.$outer.addClass('lg-use-css3');
        }

        // For fixed height gallery
        _this.setTop();
        $(window).on('resize.lg orientationchange.lg', function() {
            setTimeout(function() {
                _this.setTop();
            }, 100);
        });

        // add class lg-current to remove initial transition
        this.$slide.eq(this.index).addClass('lg-current');

        // add Class for css support and transition mode
        if (this.doCss()) {
            this.$outer.addClass('lg-css3');
        } else {
            this.$outer.addClass('lg-css');

            // Set speed 0 because no animation will happen if browser doesn't support css3
            this.s.speed = 0;
        }

        this.$outer.addClass(this.s.mode);

        if (this.s.enableDrag && this.$items.length > 1) {
            this.$outer.addClass('lg-grab');
        }

        if (this.s.showAfterLoad) {
            this.$outer.addClass('lg-show-after-load');
        }

        if (this.doCss()) {
            var $inner = this.$outer.find('.lg-inner');
            $inner.css('transition-timing-function', this.s.cssEasing);
            $inner.css('transition-duration', this.s.speed + 'ms');
        }

        setTimeout(function() {
            $('.lg-backdrop').addClass('in');
        });

        setTimeout(function() {
            _this.$outer.addClass('lg-visible');
        }, this.s.backdropDuration);

        if (this.s.download) {
            this.$outer.find('.lg-toolbar').append('<a id="lg-download" target="_blank" download class="lg-download lg-icon"></a>');
        }

        // Store the current scroll top value to scroll back after closing the gallery..
        this.prevScrollTop = $(window).scrollTop();

    };

    // For fixed height gallery
    Plugin.prototype.setTop = function() {
        if (this.s.height !== '100%') {
            var wH = $(window).height();
            var top = (wH - parseInt(this.s.height, 10)) / 2;
            var $lGallery = this.$outer.find('.lg');
            if (wH >= parseInt(this.s.height, 10)) {
                $lGallery.css('top', top + 'px');
            } else {
                $lGallery.css('top', '0px');
            }
        }
    };

    // Find css3 support
    Plugin.prototype.doCss = function() {
        // check for css animation support
        var support = function() {
            var transition = ['transition', 'MozTransition', 'WebkitTransition', 'OTransition', 'msTransition', 'KhtmlTransition'];
            var root = document.documentElement;
            var i = 0;
            for (i = 0; i < transition.length; i++) {
                if (transition[i] in root.style) {
                    return true;
                }
            }
        };

        if (support()) {
            return true;
        }

        return false;
    };

    /**
     *  @desc Check the given src is video
     *  @param {String} src
     *  @return {Object} video type
     *  Ex:{ youtube  :  ["//www.youtube.com/watch?v=c0asJgSyxcY", "c0asJgSyxcY"] }
     */
    Plugin.prototype.isVideo = function(src, index) {

        var html;
        if (this.s.dynamic) {
            html = this.s.dynamicEl[index].html;
        } else {
            html = this.$items.eq(index).attr('data-html');
        }

        if (!src && html) {
            return {
                html5: true
            };
        }

        var youtube = src.match(/\/\/(?:www\.)?youtu(?:\.be|be\.com)\/(?:watch\?v=|embed\/)?([a-z0-9\-\_\%]+)/i);
        var vimeo = src.match(/\/\/(?:www\.)?vimeo.com\/([0-9a-z\-_]+)/i);
        var dailymotion = src.match(/\/\/(?:www\.)?dai.ly\/([0-9a-z\-_]+)/i);
        var vk = src.match(/\/\/(?:www\.)?(?:vk\.com|vkontakte\.ru)\/(?:video_ext\.php\?)(.*)/i);

        if (youtube) {
            return {
                youtube: youtube
            };
        } else if (vimeo) {
            return {
                vimeo: vimeo
            };
        } else if (dailymotion) {
            return {
                dailymotion: dailymotion
            };
        } else if (vk) {
            return {
                vk: vk
            };
        }
    };

    /**
     *  @desc Create image counter
     *  Ex: 1/10
     */
    Plugin.prototype.counter = function() {
        if (this.s.counter) {
            $(this.s.appendCounterTo).append('<div id="lg-counter"><span id="lg-counter-current">' + (parseInt(this.index, 10) + 1) + '</span> / <span id="lg-counter-all">' + this.$items.length + '</span></div>');
        }
    };

    /**
     *  @desc add sub-html into the slide
     *  @param {Number} index - index of the slide
     */
    Plugin.prototype.addHtml = function(index) {
        var subHtml = null;
        var subHtmlUrl;
        var $currentEle;
        if (this.s.dynamic) {
            if (this.s.dynamicEl[index].subHtmlUrl) {
                subHtmlUrl = this.s.dynamicEl[index].subHtmlUrl;
            } else {
                subHtml = this.s.dynamicEl[index].subHtml;
            }
        } else {
            $currentEle = this.$items.eq(index);
            if ($currentEle.attr('data-sub-html-url')) {
                subHtmlUrl = $currentEle.attr('data-sub-html-url');
            } else {
                subHtml = $currentEle.attr('data-sub-html');
                if (this.s.getCaptionFromTitleOrAlt && !subHtml) {
                    subHtml = $currentEle.attr('title') || $currentEle.find('img').first().attr('alt');
                }
            }
        }

        if (!subHtmlUrl) {
            if (typeof subHtml !== 'undefined' && subHtml !== null) {

                // get first letter of subhtml
                // if first letter starts with . or # get the html form the jQuery object
                var fL = subHtml.substring(0, 1);
                if (fL === '.' || fL === '#') {
                    if (this.s.subHtmlSelectorRelative && !this.s.dynamic) {
                        subHtml = $currentEle.find(subHtml).html();
                    } else {
                        subHtml = $(subHtml).html();
                    }
                }
            } else {
                subHtml = '';
            }
        }

        if (this.s.appendSubHtmlTo === '.lg-sub-html') {

            if (subHtmlUrl) {
                this.$outer.find(this.s.appendSubHtmlTo).load(subHtmlUrl);
            } else {
                this.$outer.find(this.s.appendSubHtmlTo).html(subHtml);
            }

        } else {

            if (subHtmlUrl) {
                this.$slide.eq(index).load(subHtmlUrl);
            } else {
                this.$slide.eq(index).append(subHtml);
            }
        }

        // Add lg-empty-html class if title doesn't exist
        if (typeof subHtml !== 'undefined' && subHtml !== null) {
            if (subHtml === '') {
                this.$outer.find(this.s.appendSubHtmlTo).addClass('lg-empty-html');
            } else {
                this.$outer.find(this.s.appendSubHtmlTo).removeClass('lg-empty-html');
            }
        }

        this.$el.trigger('onAfterAppendSubHtml.lg', [index]);
    };

    /**
     *  @desc Preload slides
     *  @param {Number} index - index of the slide
     */
    Plugin.prototype.preload = function(index) {
        var i = 1;
        var j = 1;
        for (i = 1; i <= this.s.preload; i++) {
            if (i >= this.$items.length - index) {
                break;
            }

            this.loadContent(index + i, false, 0);
        }

        for (j = 1; j <= this.s.preload; j++) {
            if (index - j < 0) {
                break;
            }

            this.loadContent(index - j, false, 0);
        }
    };

    /**
     *  @desc Load slide content into slide.
     *  @param {Number} index - index of the slide.
     *  @param {Boolean} rec - if true call loadcontent() function again.
     *  @param {Boolean} delay - delay for adding complete class. it is 0 except first time.
     */
    Plugin.prototype.loadContent = function(index, rec, delay) {

        var _this = this;
        var _hasPoster = false;
        var _$img;
        var _src;
        var _poster;
        var _srcset;
        var _sizes;
        var _html;
        var getResponsiveSrc = function(srcItms) {
            var rsWidth = [];
            var rsSrc = [];
            for (var i = 0; i < srcItms.length; i++) {
                var __src = srcItms[i].split(' ');

                // Manage empty space
                if (__src[0] === '') {
                    __src.splice(0, 1);
                }

                rsSrc.push(__src[0]);
                rsWidth.push(__src[1]);
            }

            var wWidth = $(window).width();
            for (var j = 0; j < rsWidth.length; j++) {
                if (parseInt(rsWidth[j], 10) > wWidth) {
                    _src = rsSrc[j];
                    break;
                }
            }
        };

        if (_this.s.dynamic) {

            if (_this.s.dynamicEl[index].poster) {
                _hasPoster = true;
                _poster = _this.s.dynamicEl[index].poster;
            }

            _html = _this.s.dynamicEl[index].html;
            _src = _this.s.dynamicEl[index].src;

            if (_this.s.dynamicEl[index].responsive) {
                var srcDyItms = _this.s.dynamicEl[index].responsive.split(',');
                getResponsiveSrc(srcDyItms);
            }

            _srcset = _this.s.dynamicEl[index].srcset;
            _sizes = _this.s.dynamicEl[index].sizes;

        } else {

            if (_this.$items.eq(index).attr('data-poster')) {
                _hasPoster = true;
                _poster = _this.$items.eq(index).attr('data-poster');
            }

            _html = _this.$items.eq(index).attr('data-html');
            _src = _this.$items.eq(index).attr('href') || _this.$items.eq(index).attr('data-src');

            if (_this.$items.eq(index).attr('data-responsive')) {
                var srcItms = _this.$items.eq(index).attr('data-responsive').split(',');
                getResponsiveSrc(srcItms);
            }

            _srcset = _this.$items.eq(index).attr('data-srcset');
            _sizes = _this.$items.eq(index).attr('data-sizes');

        }

        //if (_src || _srcset || _sizes || _poster) {

        var iframe = false;
        if (_this.s.dynamic) {
            if (_this.s.dynamicEl[index].iframe) {
                iframe = true;
            }
        } else {
            if (_this.$items.eq(index).attr('data-iframe') === 'true') {
                iframe = true;
            }
        }

        var _isVideo = _this.isVideo(_src, index);
        if (!_this.$slide.eq(index).hasClass('lg-loaded')) {
            if (iframe) {
                _this.$slide.eq(index).prepend('<div class="lg-video-cont" style="max-width:' + _this.s.iframeMaxWidth + '"><div class="lg-video"><iframe class="lg-object" frameborder="0" src="' + _src + '"  allowfullscreen="true"></iframe></div></div>');
            } else if (_hasPoster) {
                var videoClass = '';
                if (_isVideo && _isVideo.youtube) {
                    videoClass = 'lg-has-youtube';
                } else if (_isVideo && _isVideo.vimeo) {
                    videoClass = 'lg-has-vimeo';
                } else {
                    videoClass = 'lg-has-html5';
                }

                _this.$slide.eq(index).prepend('<div class="lg-video-cont ' + videoClass + ' "><div class="lg-video"><span class="lg-video-play"></span><img class="lg-object lg-has-poster" src="' + _poster + '" /></div></div>');

            } else if (_isVideo) {
                _this.$slide.eq(index).prepend('<div class="lg-video-cont "><div class="lg-video"></div></div>');
                _this.$el.trigger('hasVideo.lg', [index, _src, _html]);
            } else {
                _this.$slide.eq(index).prepend('<div class="lg-img-wrap"><img class="lg-object lg-image" src="' + _src + '" /></div>');
            }

            _this.$el.trigger('onAferAppendSlide.lg', [index]);

            _$img = _this.$slide.eq(index).find('.lg-object');
            if (_sizes) {
                _$img.attr('sizes', _sizes);
            }

            if (_srcset) {
                _$img.attr('srcset', _srcset);
                try {
                    picturefill({
                        elements: [_$img[0]]
                    });
                } catch (e) {
                    console.error('Make sure you have included Picturefill version 2');
                }
            }

            if (this.s.appendSubHtmlTo !== '.lg-sub-html') {
                _this.addHtml(index);
            }

            _this.$slide.eq(index).addClass('lg-loaded');
        }

        _this.$slide.eq(index).find('.lg-object').on('load.lg error.lg', function() {

            // For first time add some delay for displaying the start animation.
            var _speed = 0;

            // Do not change the delay value because it is required for zoom plugin.
            // If gallery opened from direct url (hash) speed value should be 0
            if (delay && !$('body').hasClass('lg-from-hash')) {
                _speed = delay;
            }

            setTimeout(function() {
                _this.$slide.eq(index).addClass('lg-complete');
                _this.$el.trigger('onSlideItemLoad.lg', [index, delay || 0]);
            }, _speed);

        });

        // @todo check load state for html5 videos
        if (_isVideo && _isVideo.html5 && !_hasPoster) {
            _this.$slide.eq(index).addClass('lg-complete');
        }

        if (rec === true) {
            if (!_this.$slide.eq(index).hasClass('lg-complete')) {
                _this.$slide.eq(index).find('.lg-object').on('load.lg error.lg', function() {
                    _this.preload(index);
                });
            } else {
                _this.preload(index);
            }
        }

        //}
    };

    /**
    *   @desc slide function for lightgallery
        ** Slide() gets call on start
        ** ** Set lg.on true once slide() function gets called.
        ** Call loadContent() on slide() function inside setTimeout
        ** ** On first slide we do not want any animation like slide of fade
        ** ** So on first slide( if lg.on if false that is first slide) loadContent() should start loading immediately
        ** ** Else loadContent() should wait for the transition to complete.
        ** ** So set timeout s.speed + 50
    <=> ** loadContent() will load slide content in to the particular slide
        ** ** It has recursion (rec) parameter. if rec === true loadContent() will call preload() function.
        ** ** preload will execute only when the previous slide is fully loaded (images iframe)
        ** ** avoid simultaneous image load
    <=> ** Preload() will check for s.preload value and call loadContent() again accoring to preload value
        ** loadContent()  <====> Preload();

    *   @param {Number} index - index of the slide
    *   @param {Boolean} fromTouch - true if slide function called via touch event or mouse drag
    *   @param {Boolean} fromThumb - true if slide function called via thumbnail click
    *   @param {String} direction - Direction of the slide(next/prev)
    */
    Plugin.prototype.slide = function(index, fromTouch, fromThumb, direction) {

        var _prevIndex = this.$outer.find('.lg-current').index();
        var _this = this;

        // Prevent if multiple call
        // Required for hsh plugin
        if (_this.lGalleryOn && (_prevIndex === index)) {
            return;
        }

        var _length = this.$slide.length;
        var _time = _this.lGalleryOn ? this.s.speed : 0;

        if (!_this.lgBusy) {

            if (this.s.download) {
                var _src;
                if (_this.s.dynamic) {
                    _src = _this.s.dynamicEl[index].downloadUrl !== false && (_this.s.dynamicEl[index].downloadUrl || _this.s.dynamicEl[index].src);
                } else {
                    _src = _this.$items.eq(index).attr('data-download-url') !== 'false' && (_this.$items.eq(index).attr('data-download-url') || _this.$items.eq(index).attr('href') || _this.$items.eq(index).attr('data-src'));

                }

                if (_src) {
                    $('#lg-download').attr('href', _src);
                    _this.$outer.removeClass('lg-hide-download');
                } else {
                    _this.$outer.addClass('lg-hide-download');
                }
            }

            this.$el.trigger('onBeforeSlide.lg', [_prevIndex, index, fromTouch, fromThumb]);

            _this.lgBusy = true;

            clearTimeout(_this.hideBartimeout);

            // Add title if this.s.appendSubHtmlTo === lg-sub-html
            if (this.s.appendSubHtmlTo === '.lg-sub-html') {

                // wait for slide animation to complete
                setTimeout(function() {
                    _this.addHtml(index);
                }, _time);
            }

            this.arrowDisable(index);

            if (!direction) {
                if (index < _prevIndex) {
                    direction = 'prev';
                } else if (index > _prevIndex) {
                    direction = 'next';
                }
            }

            if (!fromTouch) {

                // remove all transitions
                _this.$outer.addClass('lg-no-trans');

                this.$slide.removeClass('lg-prev-slide lg-next-slide');

                if (direction === 'prev') {

                    //prevslide
                    this.$slide.eq(index).addClass('lg-prev-slide');
                    this.$slide.eq(_prevIndex).addClass('lg-next-slide');
                } else {

                    // next slide
                    this.$slide.eq(index).addClass('lg-next-slide');
                    this.$slide.eq(_prevIndex).addClass('lg-prev-slide');
                }

                // give 50 ms for browser to add/remove class
                setTimeout(function() {
                    _this.$slide.removeClass('lg-current');

                    //_this.$slide.eq(_prevIndex).removeClass('lg-current');
                    _this.$slide.eq(index).addClass('lg-current');

                    // reset all transitions
                    _this.$outer.removeClass('lg-no-trans');
                }, 50);
            } else {

                this.$slide.removeClass('lg-prev-slide lg-current lg-next-slide');
                var touchPrev;
                var touchNext;
                if (_length > 2) {
                    touchPrev = index - 1;
                    touchNext = index + 1;

                    if ((index === 0) && (_prevIndex === _length - 1)) {

                        // next slide
                        touchNext = 0;
                        touchPrev = _length - 1;
                    } else if ((index === _length - 1) && (_prevIndex === 0)) {

                        // prev slide
                        touchNext = 0;
                        touchPrev = _length - 1;
                    }

                } else {
                    touchPrev = 0;
                    touchNext = 1;
                }

                if (direction === 'prev') {
                    _this.$slide.eq(touchNext).addClass('lg-next-slide');
                } else {
                    _this.$slide.eq(touchPrev).addClass('lg-prev-slide');
                }

                _this.$slide.eq(index).addClass('lg-current');
            }

            if (_this.lGalleryOn) {
                setTimeout(function() {
                    _this.loadContent(index, true, 0);
                }, this.s.speed + 50);

                setTimeout(function() {
                    _this.lgBusy = false;
                    _this.$el.trigger('onAfterSlide.lg', [_prevIndex, index, fromTouch, fromThumb]);
                }, this.s.speed);

            } else {
                _this.loadContent(index, true, _this.s.backdropDuration);

                _this.lgBusy = false;
                _this.$el.trigger('onAfterSlide.lg', [_prevIndex, index, fromTouch, fromThumb]);
            }

            _this.lGalleryOn = true;

            if (this.s.counter) {
                $('#lg-counter-current').text(index + 1);
            }

        }

    };

    /**
     *  @desc Go to next slide
     *  @param {Boolean} fromTouch - true if slide function called via touch event
     */
    Plugin.prototype.goToNextSlide = function(fromTouch) {
        var _this = this;
        var _loop = _this.s.loop;
        if (fromTouch && _this.$slide.length < 3) {
            _loop = false;
        }

        if (!_this.lgBusy) {
            if ((_this.index + 1) < _this.$slide.length) {
                _this.index++;
                _this.$el.trigger('onBeforeNextSlide.lg', [_this.index]);
                _this.slide(_this.index, fromTouch, false, 'next');
            } else {
                if (_loop) {
                    _this.index = 0;
                    _this.$el.trigger('onBeforeNextSlide.lg', [_this.index]);
                    _this.slide(_this.index, fromTouch, false, 'next');
                } else if (_this.s.slideEndAnimatoin && !fromTouch) {
                    _this.$outer.addClass('lg-right-end');
                    setTimeout(function() {
                        _this.$outer.removeClass('lg-right-end');
                    }, 400);
                }
            }
        }
    };

    /**
     *  @desc Go to previous slide
     *  @param {Boolean} fromTouch - true if slide function called via touch event
     */
    Plugin.prototype.goToPrevSlide = function(fromTouch) {
        var _this = this;
        var _loop = _this.s.loop;
        if (fromTouch && _this.$slide.length < 3) {
            _loop = false;
        }

        if (!_this.lgBusy) {
            if (_this.index > 0) {
                _this.index--;
                _this.$el.trigger('onBeforePrevSlide.lg', [_this.index, fromTouch]);
                _this.slide(_this.index, fromTouch, false, 'prev');
            } else {
                if (_loop) {
                    _this.index = _this.$items.length - 1;
                    _this.$el.trigger('onBeforePrevSlide.lg', [_this.index, fromTouch]);
                    _this.slide(_this.index, fromTouch, false, 'prev');
                } else if (_this.s.slideEndAnimatoin && !fromTouch) {
                    _this.$outer.addClass('lg-left-end');
                    setTimeout(function() {
                        _this.$outer.removeClass('lg-left-end');
                    }, 400);
                }
            }
        }
    };

    Plugin.prototype.keyPress = function() {
        var _this = this;
        if (this.$items.length > 1) {
            $(window).on('keyup.lg', function(e) {
                if (_this.$items.length > 1) {
                    if (e.keyCode === 37) {
                        e.preventDefault();
                        _this.goToPrevSlide();
                    }

                    if (e.keyCode === 39) {
                        e.preventDefault();
                        _this.goToNextSlide();
                    }
                }
            });
        }

        $(window).on('keydown.lg', function(e) {
            if (_this.s.escKey === true && e.keyCode === 27) {
                e.preventDefault();
                if (!_this.$outer.hasClass('lg-thumb-open')) {
                    _this.destroy();
                } else {
                    _this.$outer.removeClass('lg-thumb-open');
                }
            }
        });
    };

    Plugin.prototype.arrow = function() {
        var _this = this;
        this.$outer.find('.lg-prev').on('click.lg', function() {
            _this.goToPrevSlide();
        });

        this.$outer.find('.lg-next').on('click.lg', function() {
            _this.goToNextSlide();
        });
    };

    Plugin.prototype.arrowDisable = function(index) {

        // Disable arrows if s.hideControlOnEnd is true
        if (!this.s.loop && this.s.hideControlOnEnd) {
            if ((index + 1) < this.$slide.length) {
                this.$outer.find('.lg-next').removeAttr('disabled').removeClass('disabled');
            } else {
                this.$outer.find('.lg-next').attr('disabled', 'disabled').addClass('disabled');
            }

            if (index > 0) {
                this.$outer.find('.lg-prev').removeAttr('disabled').removeClass('disabled');
            } else {
                this.$outer.find('.lg-prev').attr('disabled', 'disabled').addClass('disabled');
            }
        }
    };

    Plugin.prototype.setTranslate = function($el, xValue, yValue) {
        // jQuery supports Automatic CSS prefixing since jQuery 1.8.0
        if (this.s.useLeft) {
            $el.css('left', xValue);
        } else {
            $el.css({
                transform: 'translate3d(' + (xValue) + 'px, ' + yValue + 'px, 0px)'
            });
        }
    };

    Plugin.prototype.touchMove = function(startCoords, endCoords) {

        var distance = endCoords - startCoords;

        if (Math.abs(distance) > 15) {
            // reset opacity and transition duration
            this.$outer.addClass('lg-dragging');

            // move current slide
            this.setTranslate(this.$slide.eq(this.index), distance, 0);

            // move next and prev slide with current slide
            this.setTranslate($('.lg-prev-slide'), -this.$slide.eq(this.index).width() + distance, 0);
            this.setTranslate($('.lg-next-slide'), this.$slide.eq(this.index).width() + distance, 0);
        }
    };

    Plugin.prototype.touchEnd = function(distance) {
        var _this = this;

        // keep slide animation for any mode while dragg/swipe
        if (_this.s.mode !== 'lg-slide') {
            _this.$outer.addClass('lg-slide');
        }

        this.$slide.not('.lg-current, .lg-prev-slide, .lg-next-slide').css('opacity', '0');

        // set transition duration
        setTimeout(function() {
            _this.$outer.removeClass('lg-dragging');
            if ((distance < 0) && (Math.abs(distance) > _this.s.swipeThreshold)) {
                _this.goToNextSlide(true);
            } else if ((distance > 0) && (Math.abs(distance) > _this.s.swipeThreshold)) {
                _this.goToPrevSlide(true);
            } else if (Math.abs(distance) < 5) {

                // Trigger click if distance is less than 5 pix
                _this.$el.trigger('onSlideClick.lg');
            }

            _this.$slide.removeAttr('style');
        });

        // remove slide class once drag/swipe is completed if mode is not slide
        setTimeout(function() {
            if (!_this.$outer.hasClass('lg-dragging') && _this.s.mode !== 'lg-slide') {
                _this.$outer.removeClass('lg-slide');
            }
        }, _this.s.speed + 100);

    };

    Plugin.prototype.enableSwipe = function() {
        var _this = this;
        var startCoords = 0;
        var endCoords = 0;
        var isMoved = false;

        if (_this.s.enableSwipe && _this.isTouch && _this.doCss()) {

            _this.$slide.on('touchstart.lg', function(e) {
                if (!_this.$outer.hasClass('lg-zoomed') && !_this.lgBusy) {
                    e.preventDefault();
                    _this.manageSwipeClass();
                    startCoords = e.originalEvent.targetTouches[0].pageX;
                }
            });

            _this.$slide.on('touchmove.lg', function(e) {
                if (!_this.$outer.hasClass('lg-zoomed')) {
                    e.preventDefault();
                    endCoords = e.originalEvent.targetTouches[0].pageX;
                    _this.touchMove(startCoords, endCoords);
                    isMoved = true;
                }
            });

            _this.$slide.on('touchend.lg', function() {
                if (!_this.$outer.hasClass('lg-zoomed')) {
                    if (isMoved) {
                        isMoved = false;
                        _this.touchEnd(endCoords - startCoords);
                    } else {
                        _this.$el.trigger('onSlideClick.lg');
                    }
                }
            });
        }

    };

    Plugin.prototype.enableDrag = function() {
        var _this = this;
        var startCoords = 0;
        var endCoords = 0;
        var isDraging = false;
        var isMoved = false;
        if (_this.s.enableDrag && !_this.isTouch && _this.doCss()) {
            _this.$slide.on('mousedown.lg', function(e) {
                // execute only on .lg-object
                if (!_this.$outer.hasClass('lg-zoomed')) {
                    if ($(e.target).hasClass('lg-object') || $(e.target).hasClass('lg-video-play')) {
                        e.preventDefault();

                        if (!_this.lgBusy) {
                            _this.manageSwipeClass();
                            startCoords = e.pageX;
                            isDraging = true;

                            // ** Fix for webkit cursor issue https://code.google.com/p/chromium/issues/detail?id=26723
                            _this.$outer.scrollLeft += 1;
                            _this.$outer.scrollLeft -= 1;

                            // *

                            _this.$outer.removeClass('lg-grab').addClass('lg-grabbing');

                            _this.$el.trigger('onDragstart.lg');
                        }

                    }
                }
            });

            $(window).on('mousemove.lg', function(e) {
                if (isDraging) {
                    isMoved = true;
                    endCoords = e.pageX;
                    _this.touchMove(startCoords, endCoords);
                    _this.$el.trigger('onDragmove.lg');
                }
            });

            $(window).on('mouseup.lg', function(e) {
                if (isMoved) {
                    isMoved = false;
                    _this.touchEnd(endCoords - startCoords);
                    _this.$el.trigger('onDragend.lg');
                } else if ($(e.target).hasClass('lg-object') || $(e.target).hasClass('lg-video-play')) {
                    _this.$el.trigger('onSlideClick.lg');
                }

                // Prevent execution on click
                if (isDraging) {
                    isDraging = false;
                    _this.$outer.removeClass('lg-grabbing').addClass('lg-grab');
                }
            });

        }
    };

    Plugin.prototype.manageSwipeClass = function() {
        var _touchNext = this.index + 1;
        var _touchPrev = this.index - 1;
        if (this.s.loop && this.$slide.length > 2) {
            if (this.index === 0) {
                _touchPrev = this.$slide.length - 1;
            } else if (this.index === this.$slide.length - 1) {
                _touchNext = 0;
            }
        }

        this.$slide.removeClass('lg-next-slide lg-prev-slide');
        if (_touchPrev > -1) {
            this.$slide.eq(_touchPrev).addClass('lg-prev-slide');
        }

        this.$slide.eq(_touchNext).addClass('lg-next-slide');
    };

    Plugin.prototype.mousewheel = function() {
        var _this = this;
        _this.$outer.on('mousewheel.lg', function(e) {

            if (!e.deltaY) {
                return;
            }

            if (e.deltaY > 0) {
                _this.goToPrevSlide();
            } else {
                _this.goToNextSlide();
            }

            e.preventDefault();
        });

    };

    Plugin.prototype.closeGallery = function() {

        var _this = this;
        var mousedown = false;
        this.$outer.find('.lg-close').on('click.lg', function() {
            _this.destroy();
        });

        if (_this.s.closable) {

            // If you drag the slide and release outside gallery gets close on chrome
            // for preventing this check mousedown and mouseup happened on .lg-item or lg-outer
            _this.$outer.on('mousedown.lg', function(e) {

                if ($(e.target).is('.lg-outer') || $(e.target).is('.lg-item ') || $(e.target).is('.lg-img-wrap')) {
                    mousedown = true;
                } else {
                    mousedown = false;
                }

            });

            _this.$outer.on('mouseup.lg', function(e) {

                if ($(e.target).is('.lg-outer') || $(e.target).is('.lg-item ') || $(e.target).is('.lg-img-wrap') && mousedown) {
                    if (!_this.$outer.hasClass('lg-dragging')) {
                        _this.destroy();
                    }
                }

            });

        }

    };

    Plugin.prototype.destroy = function(d) {

        var _this = this;

        if (!d) {
            _this.$el.trigger('onBeforeClose.lg');
            $(window).scrollTop(_this.prevScrollTop);
        }


        /**
         * if d is false or undefined destroy will only close the gallery
         * plugins instance remains with the element
         *
         * if d is true destroy will completely remove the plugin
         */

        if (d) {
            if (!_this.s.dynamic) {
                // only when not using dynamic mode is $items a jquery collection
                this.$items.off('click.lg click.lgcustom');
            }

            $.removeData(_this.el, 'lightGallery');
        }

        // Unbind all events added by lightGallery
        this.$el.off('.lg.tm');

        // Distroy all lightGallery modules
        $.each($.fn.lightGallery.modules, function(key) {
            if (_this.modules[key]) {
                _this.modules[key].destroy();
            }
        });

        this.lGalleryOn = false;

        clearTimeout(_this.hideBartimeout);
        this.hideBartimeout = false;
        $(window).off('.lg');
        $('body').removeClass('lg-on lg-from-hash');

        if (_this.$outer) {
            _this.$outer.removeClass('lg-visible');
        }

        $('.lg-backdrop').removeClass('in');

        setTimeout(function() {
            if (_this.$outer) {
                _this.$outer.remove();
            }

            $('.lg-backdrop').remove();

            if (!d) {
                _this.$el.trigger('onCloseAfter.lg');
            }

        }, _this.s.backdropDuration + 50);
    };

    $.fn.lightGallery = function(options) {
        return this.each(function() {
            if (!$.data(this, 'lightGallery')) {
                $.data(this, 'lightGallery', new Plugin(this, options));
            } else {
                try {
                    $(this).data('lightGallery').init();
                } catch (err) {
                    console.error('lightGallery has not initiated properly');
                }
            }
        });
    };

    $.fn.lightGallery.modules = {};

})();


}));

/*! lg-thumbnail - v1.0.3 - 2017-02-05
* http://sachinchoolur.github.io/lightGallery
* Copyright (c) 2017 Sachin N; Licensed GPLv3 */

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    // AMD. Register as an anonymous module unless amdModuleId is set
    define(['jquery'], function (a0) {
      return (factory(a0));
    });
  } else if (typeof exports === 'object') {
    // Node. Does not work with strict CommonJS, but
    // only CommonJS-like environments that support module.exports,
    // like Node.
    module.exports = factory(require('jquery'));
  } else {
    factory(jQuery);
  }
}(this, function ($) {

(function() {

    'use strict';

    var defaults = {
        thumbnail: true,

        animateThumb: true,
        currentPagerPosition: 'middle',

        thumbWidth: 100,
        thumbContHeight: 100,
        thumbMargin: 5,

        exThumbImage: false,
        showThumbByDefault: true,
        toogleThumb: true,
        pullCaptionUp: true,

        enableThumbDrag: true,
        enableThumbSwipe: true,
        swipeThreshold: 50,

        loadYoutubeThumbnail: true,
        youtubeThumbSize: 1,

        loadVimeoThumbnail: true,
        vimeoThumbSize: 'thumbnail_small',

        loadDailymotionThumbnail: true
    };

    var Thumbnail = function(element) {

        // get lightGallery core plugin data
        this.core = $(element).data('lightGallery');

        // extend module default settings with lightGallery core settings
        this.core.s = $.extend({}, defaults, this.core.s);

        this.$el = $(element);
        this.$thumbOuter = null;
        this.thumbOuterWidth = 0;
        this.thumbTotalWidth = (this.core.$items.length * (this.core.s.thumbWidth + this.core.s.thumbMargin));
        this.thumbIndex = this.core.index;

        // Thumbnail animation value
        this.left = 0;

        this.init();

        return this;
    };

    Thumbnail.prototype.init = function() {
        var _this = this;
        if (this.core.s.thumbnail && this.core.$items.length > 1) {
            if (this.core.s.showThumbByDefault) {
                setTimeout(function(){
                    _this.core.$outer.addClass('lg-thumb-open');
                }, 700);
            }

            if (this.core.s.pullCaptionUp) {
                this.core.$outer.addClass('lg-pull-caption-up');
            }

            this.build();
            if (this.core.s.animateThumb) {
                if (this.core.s.enableThumbDrag && !this.core.isTouch && this.core.doCss()) {
                    this.enableThumbDrag();
                }

                if (this.core.s.enableThumbSwipe && this.core.isTouch && this.core.doCss()) {
                    this.enableThumbSwipe();
                }

                this.thumbClickable = false;
            } else {
                this.thumbClickable = true;
            }

            this.toogle();
            this.thumbkeyPress();
        }
    };

    Thumbnail.prototype.build = function() {
        var _this = this;
        var thumbList = '';
        var vimeoErrorThumbSize = '';
        var $thumb;
        var html = '<div class="lg-thumb-outer">' +
            '<div class="lg-thumb lg-group">' +
            '</div>' +
            '</div>';

        switch (this.core.s.vimeoThumbSize) {
            case 'thumbnail_large':
                vimeoErrorThumbSize = '640';
                break;
            case 'thumbnail_medium':
                vimeoErrorThumbSize = '200x150';
                break;
            case 'thumbnail_small':
                vimeoErrorThumbSize = '100x75';
        }

        _this.core.$outer.addClass('lg-has-thumb');

        _this.core.$outer.find('.lg').append(html);

        _this.$thumbOuter = _this.core.$outer.find('.lg-thumb-outer');
        _this.thumbOuterWidth = _this.$thumbOuter.width();

        if (_this.core.s.animateThumb) {
            _this.core.$outer.find('.lg-thumb').css({
                width: _this.thumbTotalWidth + 'px',
                position: 'relative'
            });
        }

        if (this.core.s.animateThumb) {
            _this.$thumbOuter.css('height', _this.core.s.thumbContHeight + 'px');
        }

        function getThumb(src, thumb, index) {
            var isVideo = _this.core.isVideo(src, index) || {};
            var thumbImg;
            var vimeoId = '';

            if (isVideo.youtube || isVideo.vimeo || isVideo.dailymotion) {
                if (isVideo.youtube) {
                    if (_this.core.s.loadYoutubeThumbnail) {
                        thumbImg = '//img.youtube.com/vi/' + isVideo.youtube[1] + '/' + _this.core.s.youtubeThumbSize + '.jpg';
                    } else {
                        thumbImg = thumb;
                    }
                } else if (isVideo.vimeo) {
                    if (_this.core.s.loadVimeoThumbnail) {
                        thumbImg = '//i.vimeocdn.com/video/error_' + vimeoErrorThumbSize + '.jpg';
                        vimeoId = isVideo.vimeo[1];
                    } else {
                        thumbImg = thumb;
                    }
                } else if (isVideo.dailymotion) {
                    if (_this.core.s.loadDailymotionThumbnail) {
                        thumbImg = '//www.dailymotion.com/thumbnail/video/' + isVideo.dailymotion[1];
                    } else {
                        thumbImg = thumb;
                    }
                }
            } else {
                thumbImg = thumb;
            }

            thumbList += '<div data-vimeo-id="' + vimeoId + '" class="lg-thumb-item" style="width:' + _this.core.s.thumbWidth + 'px; margin-right: ' + _this.core.s.thumbMargin + 'px"><img src="' + thumbImg + '" /></div>';
            vimeoId = '';
        }

        if (_this.core.s.dynamic) {
            for (var i = 0; i < _this.core.s.dynamicEl.length; i++) {
                getThumb(_this.core.s.dynamicEl[i].src, _this.core.s.dynamicEl[i].thumb, i);
            }
        } else {
            _this.core.$items.each(function(i) {

                if (!_this.core.s.exThumbImage) {
                    getThumb($(this).attr('href') || $(this).attr('data-src'), $(this).find('img').attr('src'), i);
                } else {
                    getThumb($(this).attr('href') || $(this).attr('data-src'), $(this).attr(_this.core.s.exThumbImage), i);
                }

            });
        }

        _this.core.$outer.find('.lg-thumb').html(thumbList);

        $thumb = _this.core.$outer.find('.lg-thumb-item');

        // Load vimeo thumbnails
        $thumb.each(function() {
            var $this = $(this);
            var vimeoVideoId = $this.attr('data-vimeo-id');

            if (vimeoVideoId) {
                $.getJSON('//www.vimeo.com/api/v2/video/' + vimeoVideoId + '.json?callback=?', {
                    format: 'json'
                }, function(data) {
                    $this.find('img').attr('src', data[0][_this.core.s.vimeoThumbSize]);
                });
            }
        });

        // manage active class for thumbnail
        $thumb.eq(_this.core.index).addClass('active');
        _this.core.$el.on('onBeforeSlide.lg.tm', function() {
            $thumb.removeClass('active');
            $thumb.eq(_this.core.index).addClass('active');
        });

        $thumb.on('click.lg touchend.lg', function() {
            var _$this = $(this);
            setTimeout(function() {

                // In IE9 and bellow touch does not support
                // Go to slide if browser does not support css transitions
                if ((_this.thumbClickable && !_this.core.lgBusy) || !_this.core.doCss()) {
                    _this.core.index = _$this.index();
                    _this.core.slide(_this.core.index, false, true, false);
                }
            }, 50);
        });

        _this.core.$el.on('onBeforeSlide.lg.tm', function() {
            _this.animateThumb(_this.core.index);
        });

        $(window).on('resize.lg.thumb orientationchange.lg.thumb', function() {
            setTimeout(function() {
                _this.animateThumb(_this.core.index);
                _this.thumbOuterWidth = _this.$thumbOuter.width();
            }, 200);
        });

    };

    Thumbnail.prototype.setTranslate = function(value) {
        // jQuery supports Automatic CSS prefixing since jQuery 1.8.0
        this.core.$outer.find('.lg-thumb').css({
            transform: 'translate3d(-' + (value) + 'px, 0px, 0px)'
        });
    };

    Thumbnail.prototype.animateThumb = function(index) {
        var $thumb = this.core.$outer.find('.lg-thumb');
        if (this.core.s.animateThumb) {
            var position;
            switch (this.core.s.currentPagerPosition) {
                case 'left':
                    position = 0;
                    break;
                case 'middle':
                    position = (this.thumbOuterWidth / 2) - (this.core.s.thumbWidth / 2);
                    break;
                case 'right':
                    position = this.thumbOuterWidth - this.core.s.thumbWidth;
            }
            this.left = ((this.core.s.thumbWidth + this.core.s.thumbMargin) * index - 1) - position;
            if (this.left > (this.thumbTotalWidth - this.thumbOuterWidth)) {
                this.left = this.thumbTotalWidth - this.thumbOuterWidth;
            }

            if (this.left < 0) {
                this.left = 0;
            }

            if (this.core.lGalleryOn) {
                if (!$thumb.hasClass('on')) {
                    this.core.$outer.find('.lg-thumb').css('transition-duration', this.core.s.speed + 'ms');
                }

                if (!this.core.doCss()) {
                    $thumb.animate({
                        left: -this.left + 'px'
                    }, this.core.s.speed);
                }
            } else {
                if (!this.core.doCss()) {
                    $thumb.css('left', -this.left + 'px');
                }
            }

            this.setTranslate(this.left);

        }
    };

    // Enable thumbnail dragging and swiping
    Thumbnail.prototype.enableThumbDrag = function() {

        var _this = this;
        var startCoords = 0;
        var endCoords = 0;
        var isDraging = false;
        var isMoved = false;
        var tempLeft = 0;

        _this.$thumbOuter.addClass('lg-grab');

        _this.core.$outer.find('.lg-thumb').on('mousedown.lg.thumb', function(e) {
            if (_this.thumbTotalWidth > _this.thumbOuterWidth) {
                // execute only on .lg-object
                e.preventDefault();
                startCoords = e.pageX;
                isDraging = true;

                // ** Fix for webkit cursor issue https://code.google.com/p/chromium/issues/detail?id=26723
                _this.core.$outer.scrollLeft += 1;
                _this.core.$outer.scrollLeft -= 1;

                // *
                _this.thumbClickable = false;
                _this.$thumbOuter.removeClass('lg-grab').addClass('lg-grabbing');
            }
        });

        $(window).on('mousemove.lg.thumb', function(e) {
            if (isDraging) {
                tempLeft = _this.left;
                isMoved = true;
                endCoords = e.pageX;

                _this.$thumbOuter.addClass('lg-dragging');

                tempLeft = tempLeft - (endCoords - startCoords);

                if (tempLeft > (_this.thumbTotalWidth - _this.thumbOuterWidth)) {
                    tempLeft = _this.thumbTotalWidth - _this.thumbOuterWidth;
                }

                if (tempLeft < 0) {
                    tempLeft = 0;
                }

                // move current slide
                _this.setTranslate(tempLeft);

            }
        });

        $(window).on('mouseup.lg.thumb', function() {
            if (isMoved) {
                isMoved = false;
                _this.$thumbOuter.removeClass('lg-dragging');

                _this.left = tempLeft;

                if (Math.abs(endCoords - startCoords) < _this.core.s.swipeThreshold) {
                    _this.thumbClickable = true;
                }

            } else {
                _this.thumbClickable = true;
            }

            if (isDraging) {
                isDraging = false;
                _this.$thumbOuter.removeClass('lg-grabbing').addClass('lg-grab');
            }
        });

    };

    Thumbnail.prototype.enableThumbSwipe = function() {
        var _this = this;
        var startCoords = 0;
        var endCoords = 0;
        var isMoved = false;
        var tempLeft = 0;

        _this.core.$outer.find('.lg-thumb').on('touchstart.lg', function(e) {
            if (_this.thumbTotalWidth > _this.thumbOuterWidth) {
                e.preventDefault();
                startCoords = e.originalEvent.targetTouches[0].pageX;
                _this.thumbClickable = false;
            }
        });

        _this.core.$outer.find('.lg-thumb').on('touchmove.lg', function(e) {
            if (_this.thumbTotalWidth > _this.thumbOuterWidth) {
                e.preventDefault();
                endCoords = e.originalEvent.targetTouches[0].pageX;
                isMoved = true;

                _this.$thumbOuter.addClass('lg-dragging');

                tempLeft = _this.left;

                tempLeft = tempLeft - (endCoords - startCoords);

                if (tempLeft > (_this.thumbTotalWidth - _this.thumbOuterWidth)) {
                    tempLeft = _this.thumbTotalWidth - _this.thumbOuterWidth;
                }

                if (tempLeft < 0) {
                    tempLeft = 0;
                }

                // move current slide
                _this.setTranslate(tempLeft);

            }
        });

        _this.core.$outer.find('.lg-thumb').on('touchend.lg', function() {
            if (_this.thumbTotalWidth > _this.thumbOuterWidth) {

                if (isMoved) {
                    isMoved = false;
                    _this.$thumbOuter.removeClass('lg-dragging');
                    if (Math.abs(endCoords - startCoords) < _this.core.s.swipeThreshold) {
                        _this.thumbClickable = true;
                    }

                    _this.left = tempLeft;
                } else {
                    _this.thumbClickable = true;
                }
            } else {
                _this.thumbClickable = true;
            }
        });

    };

    Thumbnail.prototype.toogle = function() {
        var _this = this;
        if (_this.core.s.toogleThumb) {
            _this.core.$outer.addClass('lg-can-toggle');
            _this.$thumbOuter.append('<span class="lg-toogle-thumb lg-icon"></span>');
            _this.core.$outer.find('.lg-toogle-thumb').on('click.lg', function() {
                _this.core.$outer.toggleClass('lg-thumb-open');
            });
        }
    };

    Thumbnail.prototype.thumbkeyPress = function() {
        var _this = this;
        $(window).on('keydown.lg.thumb', function(e) {
            if (e.keyCode === 38) {
                e.preventDefault();
                _this.core.$outer.addClass('lg-thumb-open');
            } else if (e.keyCode === 40) {
                e.preventDefault();
                _this.core.$outer.removeClass('lg-thumb-open');
            }
        });
    };

    Thumbnail.prototype.destroy = function() {
        if (this.core.s.thumbnail && this.core.$items.length > 1) {
            $(window).off('resize.lg.thumb orientationchange.lg.thumb keydown.lg.thumb');
            this.$thumbOuter.remove();
            this.core.$outer.removeClass('lg-has-thumb');
        }
    };

    $.fn.lightGallery.modules.Thumbnail = Thumbnail;

})();

}));

/*! lg-video - v1.0.0 - 2016-09-20
* http://sachinchoolur.github.io/lightGallery
* Copyright (c) 2016 Sachin N; Licensed GPLv3 */

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    // AMD. Register as an anonymous module unless amdModuleId is set
    define([], function () {
      return (factory());
    });
  } else if (typeof exports === 'object') {
    // Node. Does not work with strict CommonJS, but
    // only CommonJS-like environments that support module.exports,
    // like Node.
    module.exports = factory();
  } else {
    factory();
  }
}(this, function () {

(function($, window, document, undefined) {

    'use strict';

    var defaults = {
        videoMaxWidth: '855px',
        youtubePlayerParams: false,
        vimeoPlayerParams: false,
        dailymotionPlayerParams: false,
        vkPlayerParams: false,
        videojs: false,
        videojsOptions: {}
    };

    var Video = function(element) {

        this.core = $(element).data('lightGallery');

        this.$el = $(element);
        this.core.s = $.extend({}, defaults, this.core.s);
        this.videoLoaded = false;

        this.init();

        return this;
    };

    Video.prototype.init = function() {
        var _this = this;

        // Event triggered when video url found without poster
        _this.core.$el.on('hasVideo.lg.tm', function(event, index, src, html) {
            _this.core.$slide.eq(index).find('.lg-video').append(_this.loadVideo(src, 'lg-object', true, index, html));
            if (html) {
                if (_this.core.s.videojs) {
                    try {
                        videojs(_this.core.$slide.eq(index).find('.lg-html5').get(0), _this.core.s.videojsOptions, function() {
                            if (!_this.videoLoaded) {
                                this.play();
                            }
                        });
                    } catch (e) {
                        console.error('Make sure you have included videojs');
                    }
                } else {
                    _this.core.$slide.eq(index).find('.lg-html5').get(0).play();
                }
            }
        });

        // Set max width for video
        _this.core.$el.on('onAferAppendSlide.lg.tm', function(event, index) {
            _this.core.$slide.eq(index).find('.lg-video-cont').css('max-width', _this.core.s.videoMaxWidth);
            _this.videoLoaded = true;
        });

        var loadOnClick = function($el) {
            // check slide has poster
            if ($el.find('.lg-object').hasClass('lg-has-poster') && $el.find('.lg-object').is(':visible')) {

                // check already video element present
                if (!$el.hasClass('lg-has-video')) {

                    $el.addClass('lg-video-playing lg-has-video');

                    var _src;
                    var _html;
                    var _loadVideo = function(_src, _html) {

                        $el.find('.lg-video').append(_this.loadVideo(_src, '', false, _this.core.index, _html));

                        if (_html) {
                            if (_this.core.s.videojs) {
                                try {
                                    videojs(_this.core.$slide.eq(_this.core.index).find('.lg-html5').get(0), _this.core.s.videojsOptions, function() {
                                        this.play();
                                    });
                                } catch (e) {
                                    console.error('Make sure you have included videojs');
                                }
                            } else {
                                _this.core.$slide.eq(_this.core.index).find('.lg-html5').get(0).play();
                            }
                        }

                    };

                    if (_this.core.s.dynamic) {

                        _src = _this.core.s.dynamicEl[_this.core.index].src;
                        _html = _this.core.s.dynamicEl[_this.core.index].html;

                        _loadVideo(_src, _html);

                    } else {

                        _src = _this.core.$items.eq(_this.core.index).attr('href') || _this.core.$items.eq(_this.core.index).attr('data-src');
                        _html = _this.core.$items.eq(_this.core.index).attr('data-html');

                        _loadVideo(_src, _html);

                    }

                    var $tempImg = $el.find('.lg-object');
                    $el.find('.lg-video').append($tempImg);

                    // @todo loading icon for html5 videos also
                    // for showing the loading indicator while loading video
                    if (!$el.find('.lg-video-object').hasClass('lg-html5')) {
                        $el.removeClass('lg-complete');
                        $el.find('.lg-video-object').on('load.lg error.lg', function() {
                            $el.addClass('lg-complete');
                        });
                    }

                } else {

                    var youtubePlayer = $el.find('.lg-youtube').get(0);
                    var vimeoPlayer = $el.find('.lg-vimeo').get(0);
                    var dailymotionPlayer = $el.find('.lg-dailymotion').get(0);
                    var html5Player = $el.find('.lg-html5').get(0);
                    if (youtubePlayer) {
                        youtubePlayer.contentWindow.postMessage('{"event":"command","func":"playVideo","args":""}', '*');
                    } else if (vimeoPlayer) {
                        try {
                            $f(vimeoPlayer).api('play');
                        } catch (e) {
                            console.error('Make sure you have included froogaloop2 js');
                        }
                    } else if (dailymotionPlayer) {
                        dailymotionPlayer.contentWindow.postMessage('play', '*');

                    } else if (html5Player) {
                        if (_this.core.s.videojs) {
                            try {
                                videojs(html5Player).play();
                            } catch (e) {
                                console.error('Make sure you have included videojs');
                            }
                        } else {
                            html5Player.play();
                        }
                    }

                    $el.addClass('lg-video-playing');

                }
            }
        };

        if (_this.core.doCss() && _this.core.$items.length > 1 && ((_this.core.s.enableSwipe && _this.core.isTouch) || (_this.core.s.enableDrag && !_this.core.isTouch))) {
            _this.core.$el.on('onSlideClick.lg.tm', function() {
                var $el = _this.core.$slide.eq(_this.core.index);
                loadOnClick($el);
            });
        } else {

            // For IE 9 and bellow
            _this.core.$slide.on('click.lg', function() {
                loadOnClick($(this));
            });
        }

        _this.core.$el.on('onBeforeSlide.lg.tm', function(event, prevIndex, index) {

            var $videoSlide = _this.core.$slide.eq(prevIndex);
            var youtubePlayer = $videoSlide.find('.lg-youtube').get(0);
            var vimeoPlayer = $videoSlide.find('.lg-vimeo').get(0);
            var dailymotionPlayer = $videoSlide.find('.lg-dailymotion').get(0);
            var vkPlayer = $videoSlide.find('.lg-vk').get(0);
            var html5Player = $videoSlide.find('.lg-html5').get(0);
            if (youtubePlayer) {
                youtubePlayer.contentWindow.postMessage('{"event":"command","func":"pauseVideo","args":""}', '*');
            } else if (vimeoPlayer) {
                try {
                    $f(vimeoPlayer).api('pause');
                } catch (e) {
                    console.error('Make sure you have included froogaloop2 js');
                }
            } else if (dailymotionPlayer) {
                dailymotionPlayer.contentWindow.postMessage('pause', '*');

            } else if (html5Player) {
                if (_this.core.s.videojs) {
                    try {
                        videojs(html5Player).pause();
                    } catch (e) {
                        console.error('Make sure you have included videojs');
                    }
                } else {
                    html5Player.pause();
                }
            } if (vkPlayer) {
                $(vkPlayer).attr('src', $(vkPlayer).attr('src').replace('&autoplay', '&noplay'));
            }

            var _src;
            if (_this.core.s.dynamic) {
                _src = _this.core.s.dynamicEl[index].src;
            } else {
                _src = _this.core.$items.eq(index).attr('href') || _this.core.$items.eq(index).attr('data-src');

            }

            var _isVideo = _this.core.isVideo(_src, index) || {};
            if (_isVideo.youtube || _isVideo.vimeo || _isVideo.dailymotion || _isVideo.vk) {
                _this.core.$outer.addClass('lg-hide-download');
            }

            //$videoSlide.addClass('lg-complete');

        });

        _this.core.$el.on('onAfterSlide.lg.tm', function(event, prevIndex) {
            _this.core.$slide.eq(prevIndex).removeClass('lg-video-playing');
        });
    };

    Video.prototype.loadVideo = function(src, addClass, noposter, index, html) {
        var video = '';
        var autoplay = 1;
        var a = '';
        var isVideo = this.core.isVideo(src, index) || {};

        // Enable autoplay for first video if poster doesn't exist
        if (noposter) {
            if (this.videoLoaded) {
                autoplay = 0;
            } else {
                autoplay = 1;
            }
        }

        if (isVideo.youtube) {

            a = '?wmode=opaque&autoplay=' + autoplay + '&enablejsapi=1';
            if (this.core.s.youtubePlayerParams) {
                a = a + '&' + $.param(this.core.s.youtubePlayerParams);
            }

            video = '<iframe class="lg-video-object lg-youtube ' + addClass + '" width="560" height="315" src="//www.youtube.com/embed/' + isVideo.youtube[1] + a + '" frameborder="0" allowfullscreen></iframe>';

        } else if (isVideo.vimeo) {

            a = '?autoplay=' + autoplay + '&api=1';
            if (this.core.s.vimeoPlayerParams) {
                a = a + '&' + $.param(this.core.s.vimeoPlayerParams);
            }

            video = '<iframe class="lg-video-object lg-vimeo ' + addClass + '" width="560" height="315"  src="//player.vimeo.com/video/' + isVideo.vimeo[1] + a + '" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>';

        } else if (isVideo.dailymotion) {

            a = '?wmode=opaque&autoplay=' + autoplay + '&api=postMessage';
            if (this.core.s.dailymotionPlayerParams) {
                a = a + '&' + $.param(this.core.s.dailymotionPlayerParams);
            }

            video = '<iframe class="lg-video-object lg-dailymotion ' + addClass + '" width="560" height="315" src="//www.dailymotion.com/embed/video/' + isVideo.dailymotion[1] + a + '" frameborder="0" allowfullscreen></iframe>';

        } else if (isVideo.html5) {
            var fL = html.substring(0, 1);
            if (fL === '.' || fL === '#') {
                html = $(html).html();
            }

            video = html;

        } else if (isVideo.vk) {

            a = '&autoplay=' + autoplay;
            if (this.core.s.vkPlayerParams) {
                a = a + '&' + $.param(this.core.s.vkPlayerParams);
            }

            video = '<iframe class="lg-video-object lg-vk ' + addClass + '" width="560" height="315" src="http://vk.com/video_ext.php?' + isVideo.vk[1] + a + '" frameborder="0" allowfullscreen></iframe>';

        }

        return video;
    };

    Video.prototype.destroy = function() {
        this.videoLoaded = false;
    };

    $.fn.lightGallery.modules.video = Video;

})(jQuery, window, document);


}));

/*! lg-hash - v1.0.0 - 2016-09-20
* http://sachinchoolur.github.io/lightGallery
* Copyright (c) 2016 Sachin N; Licensed GPLv3 */

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    // AMD. Register as an anonymous module unless amdModuleId is set
    define([], function () {
      return (factory());
    });
  } else if (typeof exports === 'object') {
    // Node. Does not work with strict CommonJS, but
    // only CommonJS-like environments that support module.exports,
    // like Node.
    module.exports = factory();
  } else {
    factory();
  }
}(this, function () {

(function($, window, document, undefined) {

    'use strict';

    var defaults = {
        hash: true
    };

    var Hash = function(element) {

        this.core = $(element).data('lightGallery');

        this.core.s = $.extend({}, defaults, this.core.s);

        if (this.core.s.hash) {
            this.oldHash = window.location.hash;
            this.init();
        }

        return this;
    };

    Hash.prototype.init = function() {
        var _this = this;
        var _hash;

        // Change hash value on after each slide transition
        _this.core.$el.on('onAfterSlide.lg.tm', function(event, prevIndex, index) {
            window.location.hash = 'lg=' + _this.core.s.galleryId + '&slide=' + index;
        });

        // Listen hash change and change the slide according to slide value
        $(window).on('hashchange.lg.hash', function() {
            _hash = window.location.hash;
            var _idx = parseInt(_hash.split('&slide=')[1], 10);

            // it galleryId doesn't exist in the url close the gallery
            if ((_hash.indexOf('lg=' + _this.core.s.galleryId) > -1)) {
                _this.core.slide(_idx, false, false);
            } else if (_this.core.lGalleryOn) {
                _this.core.destroy();
            }

        });
    };

    Hash.prototype.destroy = function() {

        if (!this.core.s.hash) {
            return;
        }

        // Reset to old hash value
        if (this.oldHash && this.oldHash.indexOf('lg=' + this.core.s.galleryId) < 0) {
            window.location.hash = this.oldHash;
        } else {
            if (history.pushState) {
                history.pushState('', document.title, window.location.pathname + window.location.search);
            } else {
                window.location.hash = '';
            }
        }

        this.core.$el.off('.lg.hash');

    };

    $.fn.lightGallery.modules.hash = Hash;

})(jQuery, window, document);


}));

/*! lg-pager - v1.0.2 - 2017-01-22
* http://sachinchoolur.github.io/lightGallery
* Copyright (c) 2017 Sachin N; Licensed GPLv3 */

(function (root, factory) {
  if (typeof define === 'function' && define.amd) {
    // AMD. Register as an anonymous module unless amdModuleId is set
    define(['jquery'], function (a0) {
      return (factory(a0));
    });
  } else if (typeof exports === 'object') {
    // Node. Does not work with strict CommonJS, but
    // only CommonJS-like environments that support module.exports,
    // like Node.
    module.exports = factory(require('jquery'));
  } else {
    factory(jQuery);
  }
}(this, function ($) {

(function() {

    'use strict';

    var defaults = {
        pager: false
    };

    var Pager = function(element) {

        this.core = $(element).data('lightGallery');

        this.$el = $(element);
        this.core.s = $.extend({}, defaults, this.core.s);
        if (this.core.s.pager && this.core.$items.length > 1) {
            this.init();
        }

        return this;
    };

    Pager.prototype.init = function() {
        var _this = this;
        var pagerList = '';
        var $pagerCont;
        var $pagerOuter;
        var timeout;

        _this.core.$outer.find('.lg').append('<div class="lg-pager-outer"></div>');

        if (_this.core.s.dynamic) {
            for (var i = 0; i < _this.core.s.dynamicEl.length; i++) {
                pagerList += '<span class="lg-pager-cont"> <span class="lg-pager"></span><div class="lg-pager-thumb-cont"><span class="lg-caret"></span> <img src="' + _this.core.s.dynamicEl[i].thumb + '" /></div></span>';
            }
        } else {
            _this.core.$items.each(function() {

                if (!_this.core.s.exThumbImage) {
                    pagerList += '<span class="lg-pager-cont"> <span class="lg-pager"></span><div class="lg-pager-thumb-cont"><span class="lg-caret"></span> <img src="' + $(this).find('img').attr('src') + '" /></div></span>';
                } else {
                    pagerList += '<span class="lg-pager-cont"> <span class="lg-pager"></span><div class="lg-pager-thumb-cont"><span class="lg-caret"></span> <img src="' + $(this).attr(_this.core.s.exThumbImage) + '" /></div></span>';
                }

            });
        }

        $pagerOuter = _this.core.$outer.find('.lg-pager-outer');

        $pagerOuter.html(pagerList);

        $pagerCont = _this.core.$outer.find('.lg-pager-cont');
        $pagerCont.on('click.lg touchend.lg', function() {
            var _$this = $(this);
            _this.core.index = _$this.index();
            _this.core.slide(_this.core.index, false, true, false);
        });

        $pagerOuter.on('mouseover.lg', function() {
            clearTimeout(timeout);
            $pagerOuter.addClass('lg-pager-hover');
        });

        $pagerOuter.on('mouseout.lg', function() {
            timeout = setTimeout(function() {
                $pagerOuter.removeClass('lg-pager-hover');
            });
        });

        _this.core.$el.on('onBeforeSlide.lg.tm', function(e, prevIndex, index) {
            $pagerCont.removeClass('lg-pager-active');
            $pagerCont.eq(index).addClass('lg-pager-active');
        });

    };

    Pager.prototype.destroy = function() {

    };

    $.fn.lightGallery.modules.pager = Pager;

})();


}));

/*! Copyright (c) 2013 Brandon Aaron (http://brandon.aaron.sh)
 * Licensed under the MIT License (LICENSE.txt).
 *
 * Version: 3.1.12
 *
 * Requires: jQuery 1.2.2+
 */
!function(a){"function"==typeof define&&define.amd?define(["jquery"],a):"object"==typeof exports?module.exports=a:a(jQuery)}(function(a){function b(b){var g=b||window.event,h=i.call(arguments,1),j=0,l=0,m=0,n=0,o=0,p=0;if(b=a.event.fix(g),b.type="mousewheel","detail"in g&&(m=-1*g.detail),"wheelDelta"in g&&(m=g.wheelDelta),"wheelDeltaY"in g&&(m=g.wheelDeltaY),"wheelDeltaX"in g&&(l=-1*g.wheelDeltaX),"axis"in g&&g.axis===g.HORIZONTAL_AXIS&&(l=-1*m,m=0),j=0===m?l:m,"deltaY"in g&&(m=-1*g.deltaY,j=m),"deltaX"in g&&(l=g.deltaX,0===m&&(j=-1*l)),0!==m||0!==l){if(1===g.deltaMode){var q=a.data(this,"mousewheel-line-height");j*=q,m*=q,l*=q}else if(2===g.deltaMode){var r=a.data(this,"mousewheel-page-height");j*=r,m*=r,l*=r}if(n=Math.max(Math.abs(m),Math.abs(l)),(!f||f>n)&&(f=n,d(g,n)&&(f/=40)),d(g,n)&&(j/=40,l/=40,m/=40),j=Math[j>=1?"floor":"ceil"](j/f),l=Math[l>=1?"floor":"ceil"](l/f),m=Math[m>=1?"floor":"ceil"](m/f),k.settings.normalizeOffset&&this.getBoundingClientRect){var s=this.getBoundingClientRect();o=b.clientX-s.left,p=b.clientY-s.top}return b.deltaX=l,b.deltaY=m,b.deltaFactor=f,b.offsetX=o,b.offsetY=p,b.deltaMode=0,h.unshift(b,j,l,m),e&&clearTimeout(e),e=setTimeout(c,200),(a.event.dispatch||a.event.handle).apply(this,h)}}function c(){f=null}function d(a,b){return k.settings.adjustOldDeltas&&"mousewheel"===a.type&&b%120===0}var e,f,g=["wheel","mousewheel","DOMMouseScroll","MozMousePixelScroll"],h="onwheel"in document||document.documentMode>=9?["wheel"]:["mousewheel","DomMouseScroll","MozMousePixelScroll"],i=Array.prototype.slice;if(a.event.fixHooks)for(var j=g.length;j;)a.event.fixHooks[g[--j]]=a.event.mouseHooks;var k=a.event.special.mousewheel={version:"3.1.12",setup:function(){if(this.addEventListener)for(var c=h.length;c;)this.addEventListener(h[--c],b,!1);else this.onmousewheel=b;a.data(this,"mousewheel-line-height",k.getLineHeight(this)),a.data(this,"mousewheel-page-height",k.getPageHeight(this))},teardown:function(){if(this.removeEventListener)for(var c=h.length;c;)this.removeEventListener(h[--c],b,!1);else this.onmousewheel=null;a.removeData(this,"mousewheel-line-height"),a.removeData(this,"mousewheel-page-height")},getLineHeight:function(b){var c=a(b),d=c["offsetParent"in a.fn?"offsetParent":"parent"]();return d.length||(d=a("body")),parseInt(d.css("fontSize"),10)||parseInt(c.css("fontSize"),10)||16},getPageHeight:function(b){return a(b).height()},settings:{adjustOldDeltas:!0,normalizeOffset:!0}};a.fn.extend({mousewheel:function(a){return a?this.bind("mousewheel",a):this.trigger("mousewheel")},unmousewheel:function(a){return this.unbind("mousewheel",a)}})});
/**
 * @see handleDragEnd functions to get the return
 **/

let boxes_ = document.querySelectorAll('.drag'),
    dragSrcEl_ = null,
    target = null,
    folders = {}

handleDragStart = function(e) {

    dragSrcEl_ = this
    this.classList.add('moving')
    folders = {}
    folders.folder = this.dataset.name

}

handleDragOver = function(e) {

    e.preventDefault && e.preventDefault()
    e.dataTransfer.dropEffect = 'move'
    target = this
    return false

}

handleDragEnter = function(e) {

  this.classList.add('over')
  if(this.dataset.folder == 'false') this.style.opacity = '0.3'

}

handleDragLeave = function(e) {

    this.classList.remove('over')
    if(this.dataset.folder == 'false') this.style.opacity = '1'

}

handleDrop = function(e) {

    e.stopPropagation && e.stopPropagation()
    if (dragSrcEl_ != this) folders.target = this.dataset.name

    return false
}

/**
 * @desc this is the last event o drag and drop of folder and files.
 * @param {event}
 * @return {object} with the folder target who will receive the dragged folder
 **/
handleDragEnd = function(e) {

    Array.prototype.forEach.call(boxes_, function(box) {
        box.classList.remove('over')
        box.classList.remove('moving')
    })


    if (folders.target && target.dataset.folder != 'false') {

        let folderTarget = document.querySelector(`[data-name="${folders.folder}"]`)

        folderTarget.style.display = 'none'

        console.log(folders)

        return folders

    }

}



function load() {

    boxes_ = document.querySelectorAll('.drag')
    dragSrcEl_ = null

    Array.prototype.forEach.call(boxes_, function(box) {
        box.setAttribute('draggable', 'true')
        box.addEventListener('dragstart', handleDragStart, false)
        box.addEventListener('dragenter', handleDragEnter, false)
        box.addEventListener('dragover', handleDragOver, false)
        box.addEventListener('dragleave', handleDragLeave, false)
        box.addEventListener('drop', handleDrop, false)
        box.addEventListener('dragend', handleDragEnd, false)
    })

}

// Favorite Folders
class Folder {
  
  constructor(el) {

    this.wrapper = document.querySelector('#folders')
    this.modal = document.querySelector('#new-favorite-folder')
    this.save  = this.modal.querySelector('#new-folder-form')
    this.input = this.modal.querySelector('#name-of-folder')
    this.close = this.modal.querySelector('.md-close')

    this.close.addEventListener( 'click', this.closer.bind(this))
    this.save.addEventListener( 'submit', this._add.bind(this))
    el.addEventListener('click', this.opner.bind(this))
  }

  opner(e) {

    this.modal.classList.add('md-show')
  }

  closer() {

    this.modal.classList.remove('md-show')
  }

  _add(e) {

    e.preventDefault()

    if(!this.input.value) return

    this.wrapper.insertAdjacentHTML('beforeend', this.template(this.input.value))
    this.input.value = ''
    this.closer()
    load()
  }

  template(value) {

    return `<a href="#" class="folder drag" data-folder="true" data-name="${value}" draggable="true">
              <svg class="svg folder-svg" role="img" title="Folder">
                <use xlink:href="#folder"></use>
              </svg>
              <span>${value}</span>
            </a>`
  }
}


function cached(url){
  let lastUrl = null
  return lastUrl
}

function addtoFavorite(){

  let ins   = body.querySelector('.page_left .pageimg'),
      page  = ins.getAttribute('page-id'),
      url   = ins.querySelector('img').getAttribute('src'),
      fav = document.querySelector('[data-overlay="mdl-favoritos"] #folders'),
      template = `<a class="file favorited drag" data-folder="false" data-name="${page}" href="javascript:void(0);" onclick="gotoAnchor('anch${page}',false); return false;" class="multimidia-item">
                    <figure><img class="img-responsive" src="${url.replace('normal', 'thumb')}"></figure>
                  </a>`

  //fav.insertAdjacentHTML('beforeend', template)

    let obj = {
          id : page,
          url : url,
          template : template
        }


  //load()
  console.log(obj)
  return obj

}

class Note {

  constructor(notes) {

    this.main = ''
    this.imgWrp = document.querySelector('#readercontainer') || false

    this.modal = document.querySelector('#notes')
    this.save = this.modal.querySelector('#notes-form')
    this.note = this.modal.querySelector('#note')
    this.close = this.modal.querySelector('.md-close')
    this.text = ''
    this.span = ''
    this.x = 30
    this.y = 30
    this.current = false
    this.id = Date.now()
    this.close.addEventListener('click', this.closerModal.bind(this))
    this.save.addEventListener('submit', this._add.bind(this))
  }

  clear() {

    let n = document.querySelectorAll('.note-added')

    for (let i = 0; n.length > i; i++) {
      n[i].remove()
    }
  }

  init(notes, especificNote) {

    this.main = document.querySelector('#reader')
    if (!this.imgWrp) this.imgWrp = document.querySelector('#readercontainer .pagecontainer')

    notes.map(e => {
      if (e.page == especificNote) {
        this.x = e.x
        this.y = e.y
        this.id = e.id
        this.imgWrp.appendChild(this.template(e.text, e.x, e.y, e.id, 1))
      }
    })
  }

  open(e) {

    this.save.querySelector('textarea').value = e.target.dataset.text
    this._edit(e)
    this.opnerModal()
  }

  opnerModal() {

    this.modal.classList.add('md-show')
    this.main.style.opacity = 0.3
  }

  closerModal() {

    this.modal.classList.remove('md-show')
    this.main.style.opacity = 1


  }

  showNote(e) {

    e.stopPropagation()

    let text = e.target.dataset.text
    let el = document.createElement('div')
    let inner = `<div>${text}</div>`

    el.classList.add('note-element')
    el.addEventListener('click', function (e) { e.stopPropagation() })
    el.insertAdjacentHTML('beforeend', inner)

    e.target.appendChild(el)
    e.target.style.opacity = 0.6
  }

  _edit(e) {

    this.x = e.x
    this.y = e.y
    this.id = e.target.dataset.id
    this.current = e
  }

  _add(e) {

    e.preventDefault()

    this.current && this.current.target.remove()
    this.current = false
    if (!this.imgWrp) this.imgWrp = this.main.querySelector('#readercontainer .pagecontainer')
    if (this.note.value) this.imgWrp.appendChild(this.template(this.note.value, this.x, this.y, this.id, 1))

    this.saving(this.note.value, this.x, this.y, this.id)
    this.closerModal()

  }

  saving(txt, x, y, id) {

    let ins = body.querySelector('.page_left .pageimg'),
      page = ins.getAttribute('page-id')

    let obj = {
      x: x,
      y: y,
      text: txt,
      id: id,
      page: page
    }

    console.log(obj)

    return obj
  }

  handleDragStart(e) {

    e.target.style.opacity = 0.3
    e.target.querySelector('.note-element').style.display = 'none'
  }

  handleDragEnd(e) {

    let l = this.imgWrp.getBoundingClientRect().left - 5
    let t = this.imgWrp.getBoundingClientRect().top - 5

    this.x = e.pageX - l
    this.y = e.pageY - t - e.toElement.clientHeight
    let i = e.target.dataset.id
    let tx = e.target.dataset.text

    e.target.style.left = `${this.x}px`
    e.target.style.top = `${this.y}px`
    e.target.style.position = 'absolute'
    e.target.style.opacity = 1

    e.target.querySelector('.note-element').style.display = 'block'

    this.saving(tx, this.x, this.y, i)

  }

  template(value, x, y, id, o) {

    this.span = document.createElement('span')
    this.span.classList.add('note-added')
    this.span.setAttribute('draggable', 'true')
    this.span.setAttribute('data-text', value)
    this.span.setAttribute('data-id', id)

    this.span.style.left = `${x}px`
    this.span.style.top = `${y}px`
    this.span.style.opacity = o

    this.text = value

    let el = document.createElement('div')
    let inner = `<div>${value}</div>`

    el.classList.add('note-element')
    el.insertAdjacentHTML('beforeend', inner)

    this.span.appendChild(el)
    this.span.insertAdjacentHTML('beforeend', `<i class="fa fa-sticky-note" aria-hidden="true"></i>`)
    this.span.addEventListener('dragstart', this.handleDragStart.bind(this), false)
    this.span.addEventListener('dragend', this.handleDragEnd.bind(this), false)
    this.span.addEventListener('click', this.open.bind(this), false)
    
    this.x = 30
    this.y = 30

    return this.span
  }

}

function newNote() {
  note.opnerModal()
}

// Menu

class Menu {

  constructor(btn) {

    this.btn = btn
    this.over = ''
    this.overlay = body.querySelectorAll('.overlay-content')
    this.Allbtn = body.querySelectorAll('#header li a')

    this.btn.addEventListener('click', () => this.openOverlay(this.btn))

  }

  close() {

    Array.prototype.forEach.call(this.overlay, function (ovrl) {
      ovrl.style.display = 'none'
    })

    Array.prototype.forEach.call(this.Allbtn, function (btn) {
      btn.classList.remove('ativo')
    })

    body.classList.remove('overlay-opened')

    fecharOutros()

  }

  openOverlay(el) {

    this.close()

    this.btn.classList.add('ativo')

    this.over = body.querySelector(`[data-overlay="${el.id}"]`)
    body.classList.add('overlay-opened')

    if (this.over) {

      this.over.style.display = 'block'
      this.over.querySelector('.close').addEventListener('click', this.close.bind(this))


    } else {

      throw new Error(`there is no ${el.id}`)

    }

  }

}


(function (factory) {
    'use strict';

    if (typeof define === 'function' && define.amd) {
        // AMD. Register as an anonymous module.
        define([], factory);
    }
    else if (typeof module === 'object' && module !== null && module.exports) {
        // CommonJS
        module.exports = factory();
    } else {
        // Browser globals
        /* jshint ignore:start */
        window['rangeSlider'] = factory();
        /* jshint ignore:end */
    }
}(function () {
        'use strict';

        var EVENT_LISTENER_LIST = 'eventListenerList';
        var newLineAndTabRegexp = new RegExp('/[\\n\\t]/', 'g');
        var MAX_SET_BY_DEFAULT = 100;
        var HANDLE_RESIZE_DELAY = 300;
        var HANDLE_RESIZE_DEBOUNCE = 50;

        /**
         * Range feature detection
         * @return {Boolean}
         */
        function supportsRange() {
            var input = document.createElement('input');
            input.setAttribute('type', 'range');
            return input.type !== 'text';
        }

        var pluginName = 'rangeSlider',
            pluginIdentifier = 0,
            inputrange = supportsRange(),
            defaults = {
                polyfill: true,
                rangeClass: 'rangeSlider',
                disabledClass: 'rangeSlider--disabled',
                fillClass: 'rangeSlider__fill',
                bufferClass: 'rangeSlider__buffer',
                handleClass: 'rangeSlider__handle',
                startEvent: ['mousedown', 'touchstart', 'pointerdown'],
                moveEvent: ['mousemove', 'touchmove', 'pointermove'],
                endEvent: ['mouseup', 'touchend', 'pointerup'],
                min: null,
                max: null,
                step: null,
                value: null,
                buffer: null,
                stick: null,
                borderRadius: 10
            };

        /**
         * Delays a function for the given number of milliseconds, and then calls
         * it with the arguments supplied.
         *
         * @param  {Function} fn   [description]
         * @param  {Number}   wait [description]
         * @return {Function}
         */
        function delay(fn, wait) {
            var args = Array.prototype.slice.call(arguments, 2);
            return setTimeout(function () {
                return fn.apply(null, args);
            }, wait);
        }

        /**
         * Returns a debounced function that will make sure the given
         * function is not triggered too much.
         *
         * @param  {Function} fn Function to debounce.
         * @param  {Number}   debounceDuration OPTIONAL. The amount of time in milliseconds for which we will debounce the function. (defaults to 100ms)
         * @return {Function}
         */
        function debounce(fn, debounceDuration) {
            debounceDuration = debounceDuration || 100;
            return function () {
                if (!fn.debouncing) {
                    var args = Array.prototype.slice.apply(arguments);
                    fn.lastReturnVal = fn.apply(window, args);
                    fn.debouncing = true;
                }
                clearTimeout(fn.debounceTimeout);
                fn.debounceTimeout = setTimeout(function () {
                    fn.debouncing = false;
                }, debounceDuration);
                return fn.lastReturnVal;
            };
        }

        /**
         * Check if a `element` is visible in the DOM
         *
         * @param  {Element}  element
         * @return {Boolean}
         */
        function isHidden(element) {
            return !!(element.offsetWidth === 0 || element.offsetHeight === 0 || element.open === false);

        }

        /**
         * Get hidden parentNodes of an `element`
         *
         * @param  {Element} element
         * @return {[type]}
         */
        function getHiddenParentNodes(element) {
            var parents = [],
                node = element.parentNode;

            while (isHidden(node)) {
                parents.push(node);
                node = node.parentNode;
            }
            return parents;
        }

        /**
         * Returns dimensions for an element even if it is not visible in the DOM.
         *
         * @param  {Element} element
         * @param  {string}  key     (e.g. offsetWidth …)
         * @return {Number}
         */
        function getDimension(element, key) {
            var hiddenParentNodes = getHiddenParentNodes(element),
                hiddenParentNodesLength = hiddenParentNodes.length,
                displayProperty = [],
                dimension = element[key];

            // Used for native `<details>` elements
            function toggleOpenProperty(element) {
                if (typeof element.open !== 'undefined') {
                    element.open = (element.open) ? false : true;
                }
            }

            if (hiddenParentNodesLength) {
                for (var i = 0; i < hiddenParentNodesLength; i++) {
                    // Cache the display property to restore it later.
                    displayProperty[i] = hiddenParentNodes[i].style.display;

                    hiddenParentNodes[i].style.display = 'block';
                    hiddenParentNodes[i].style.height = '0';
                    hiddenParentNodes[i].style.overflow = 'hidden';
                    hiddenParentNodes[i].style.visibility = 'hidden';
                    toggleOpenProperty(hiddenParentNodes[i]);
                }

                dimension = element[key];

                for (var j = 0; j < hiddenParentNodesLength; j++) {
                    toggleOpenProperty(hiddenParentNodes[j]);
                    hiddenParentNodes[j].style.display = displayProperty[j];
                    hiddenParentNodes[j].style.height = '';
                    hiddenParentNodes[j].style.overflow = '';
                    hiddenParentNodes[j].style.visibility = '';
                }
            }
            return dimension;
        }

        function isString(obj) {
            return obj === '' + obj;
        }

        function isArray(obj) {
            return Object.prototype.toString.call(obj) === '[object Array]';
        }

        function isNumberLike(obj) {
            return (obj !== null && obj !== undefined && (isString(obj) && isFinite(parseFloat(obj)) || (isFinite(obj))));
        }

        function getFirsNumberLike() {
            if (!arguments.length) {
                return null;
            }
            for (var i = 0, len = arguments.length; i < len; i++) {
                if (isNumberLike(arguments[i])) {
                    return arguments[i];
                }
            }
        }

        function isObject(obj) {
            return Object.prototype.toString.call(obj) === '[object Object]';
        }

        function simpleExtend(defaultOpt, options) {
            var opt = {}, key;
            for (key in defaultOpt) {
                opt[key] = defaultOpt[key];
            }
            for (key in options) {
                opt[key] = options[key];
            }

            return opt;
        }

        /**
         *
         * @param {HTMLElement} el
         * @param {Object} cssObj
         * @returns {*}
         */
        function setCss(el, cssObj) {
            for (var key in cssObj) {
                el.style[key] = cssObj[key];
            }
            return el.style;
        }

        /**
         *
         * @param {HTMLElement} elem
         * @param {string} className
         */
        function hasClass(elem, className) {
            return new RegExp(' ' + className + ' ').test(' ' + elem.className + ' ');
        }

        /**
         *
         * @param {HTMLElement} elem
         * @param {string} className
         */
        function addClass(elem, className) {
            if (!hasClass(elem, className)) {
                elem.className += ' ' + className;
            }
        }

        /**
         *
         * @param {HTMLElement} elem
         * @param {string} className
         */
        function removeClass(elem, className) {
            var newClass = ' ' + elem.className.replace(/[\t\r\n]/g, ' ') + ' ';
            if (hasClass(elem, className)) {
                while (newClass.indexOf(' ' + className + ' ') >= 0) {
                    newClass = newClass.replace(' ' + className + ' ', ' ');
                }
                elem.className = newClass.replace(/^\s+|\s+$/g, '');
            }
        }


        /**
         *
         * @param {HTMLElement} el
         * @callback callback
         * @param {boolean} andForElement - apply callback for el
         * @returns {HTMLElement}
         */
        function forEachAncestors(el, callback, andForElement) {
            if (andForElement) {
                callback(el);
            }

            while (el.parentNode && !callback(el)) {
                el = el.parentNode;
            }

            return el;
        }

        /**
         *
         * @param {HTMLElement} el
         * @param {string} name event name
         * @param {Object} data
         */
        function triggerEvent(el, name, data) {
            if (!isString(name)) {
                throw new TypeError('event name must be String');
            }
            if (!(el instanceof HTMLElement)) {
                throw new TypeError('element must be HTMLElement');
            }
            name = name.trim();
            var event = document.createEvent('CustomEvent');
            event.initCustomEvent(name, false, false, data);
            el.dispatchEvent(event);
        }

        /**
         * @param {Object} referenceNode after this
         * @param {Object} newNode insert this
         */
        function insertAfter(referenceNode, newNode) {
            referenceNode.parentNode.insertBefore(newNode, referenceNode.nextSibling);
        }

        /**
         * Add event listeners and push them to el[EVENT_LISTENER_LIST]
         * @param {HTMLElement} el DOM element
         * @param {Array} events
         * @callback listener
         */
        function addEventListeners(el, events, listener) {
            events.forEach(function (eventName) {
                if (!el[EVENT_LISTENER_LIST]) {
                    el[EVENT_LISTENER_LIST] = {};
                }
                if (!el[EVENT_LISTENER_LIST][eventName]) {
                    el[EVENT_LISTENER_LIST][eventName] = [];
                }

                el.addEventListener(
                    eventName,
                    listener,
                    false
                );
                if (el[EVENT_LISTENER_LIST][eventName].indexOf(listener) < 0) {
                    el[EVENT_LISTENER_LIST][eventName].push(listener);
                }
            });
        }

        /**
         * Remove event listeners and remove them from el[EVENT_LISTENER_LIST]
         * @param {HTMLElement} el DOM element
         * @param {Array} events
         * @callback listener
         */
        function removeEventListeners(el, events, listener) {
            events.forEach(function (eventName) {
                el.removeEventListener(
                    eventName,
                    listener,
                    false
                );

                var index;
                if (el[EVENT_LISTENER_LIST] && el[EVENT_LISTENER_LIST][eventName] &&
                    (index = el[EVENT_LISTENER_LIST][eventName].indexOf(listener)) > -1
                ) {
                    el[EVENT_LISTENER_LIST][eventName].splice(index, 1);
                }
            });
        }

        /**
         * Remove ALL event listeners which exists in el[EVENT_LISTENER_LIST]
         * @param {HTMLElement} el DOM element
         */
        function removeAllListenersFromEl(el) {
            if (!el[EVENT_LISTENER_LIST]) {
                return;
            }
            /* jshint ignore:start */
            var instance = this;

            /**
             *
             * @callback listener
             * @this {Object} event name
             */
            function rm(listener) {
                if (listener === instance._startEventListener) {
                    this.el.removeEventListener(this.eventName, listener, false);
                }
            }

            for (var eventName in el[EVENT_LISTENER_LIST]) {
                el[EVENT_LISTENER_LIST][eventName].forEach(rm, {eventName: eventName, el: el});
            }

            el[EVENT_LISTENER_LIST] = {};
            /* jshint ignore:end */
        }


        /**
         * Plugin
         * @param {HTMLElement} element
         * @param {this} options
         */
        function Plugin(element, options) {
            var minSetByDefault, maxSetByDefault, stepSetByDefault,
                stickAttribute,
                stickValues;
            this.element = element;
            this.options = simpleExtend(defaults, options);
            this.polyfill = this.options.polyfill;
            this.onInit = this.options.onInit;
            this.onSlide = this.options.onSlide;
            this.onSlideStart = this.options.onSlideStart;
            this.onSlideEnd = this.options.onSlideEnd;
            this.onSlideEventsCount = -1;
            this.isInteractsNow = false;
            this.needTriggerEvents = false;

            // Plugin should only be used as a polyfill
            if (!this.polyfill) {
                // Input range support?
                if (inputrange) {
                    return false;
                }
            }

            this.options.buffer = this.options.buffer || parseFloat(this.element.getAttribute('data-buffer'));

            this.identifier = 'js-' + pluginName + '-' + (pluginIdentifier++);
            this.min = getFirsNumberLike(this.options.min, parseFloat(this.element.getAttribute('min')), (minSetByDefault = 0));
            this.max = getFirsNumberLike(this.options.max, parseFloat(this.element.getAttribute('max')), (maxSetByDefault = MAX_SET_BY_DEFAULT));
            this.value = getFirsNumberLike(this.options.value, this.element.value,
                parseFloat(this.element.value || this.min + (this.max - this.min) / 2));
            this.step = getFirsNumberLike(this.options.step,
                parseFloat(this.element.getAttribute('step')) || (stepSetByDefault = 1));
            this.percent = null;
            if (isArray(this.options.stick) && this.options.stick.length >= 1) {
                this.stick = this.options.stick;
            } else if ((stickAttribute = this.element.getAttribute('stick'))) {
                stickValues = stickAttribute.split(' ');
                if (stickValues.length >= 1) {
                    this.stick = stickValues.map(parseFloat);
                }
            }
            if (this.stick && this.stick.length === 1) {
                this.stick.push(this.step * 1.5);
            }
            this._updatePercentFromValue();

            this.toFixed = this._toFixed(this.step);


            this.fill = document.createElement('div');
            this.fill.className = this.options.fillClass;

            this.handle = document.createElement('div');
            this.handle.className = this.options.handleClass;

            this.range = document.createElement('div');
            this.range.className = this.options.rangeClass;
            this.range.id = this.identifier;
            this.range.appendChild(this.handle);
            this.range.appendChild(this.fill);


            if (this.options.bufferClass) {
                this.buffer = document.createElement('div');
                this.buffer.className = this.options.bufferClass;
                this.range.appendChild(this.buffer);
            }

            if (isNumberLike(this.options.value)) {
                this._setValue(this.options.value, true);
                this.element.value = this.options.value;
            }

            if (isNumberLike(this.options.buffer)) {
                this.element.setAttribute('data-buffer', this.options.buffer);
            }

            if (isNumberLike(this.options.min) || minSetByDefault) {
                this.element.setAttribute('min', '' + this.min);
            }

            if (isNumberLike(this.options.max) || maxSetByDefault) {
                this.element.setAttribute('max', '' + this.max);
            }

            if (isNumberLike(this.options.step) || stepSetByDefault) {
                this.element.setAttribute('step', '' + this.step);
            }

            insertAfter(this.element, this.range);

            // visually hide the input
            setCss(this.element, {
                'position': 'absolute',
                'width': '1px',
                'height': '1px',
                'overflow': 'hidden',
                'opacity': '0'
            });

            // Store context
            this._handleDown = this._handleDown.bind(this);
            this._handleMove = this._handleMove.bind(this);
            this._handleEnd = this._handleEnd.bind(this);
            this._startEventListener = this._startEventListener.bind(this);
            this._changeEventListener = this._changeEventListener.bind(this);
            this._handleResize = this._handleResize.bind(this);

            this._init();

            //// Attach Events
            window.addEventListener('resize', this._handleResize, false);

            addEventListeners(document, this.options.startEvent, this._startEventListener);

            // Listen to programmatic value changes
            this.element.addEventListener('change', this._changeEventListener, false);
        }

        Plugin.prototype.constructor = Plugin;

        Plugin.prototype._toFixed = function (step) {
            return (step + '').replace('.', '').length - 1;
        };


        Plugin.prototype._init = function () {
            if (this.onInit && typeof this.onInit === 'function') {
                this.onInit();
            }
            this._update();
        };

        Plugin.prototype._updatePercentFromValue = function () {
            this.percent = (this.value - this.min) / (this.max - this.min);
        };

        /**
         * This method check if this.identifier exists in ev.target's ancestors
         * @param ev
         * @param data
         */
        Plugin.prototype._startEventListener = function (ev, data) {
            var _this = this;
            var el = ev.target;
            var isEventOnSlider = false;
            forEachAncestors(el, function (el) {
                return (isEventOnSlider = el.id === _this.identifier && !hasClass(el, _this.options.disabledClass));
            }, true);
            if (isEventOnSlider) {
                this._handleDown(ev, data);
            }
        };

        Plugin.prototype._changeEventListener = function (ev, data) {
            if (data && data.origin === this.identifier) {
                return;
            }

            var value = ev.target.value,
                pos = this._getPositionFromValue(value);
            this._setPosition(pos);
        };

        Plugin.prototype._update = function () {
            this.handleWidth = getDimension(this.handle, 'offsetWidth');
            this.rangeWidth = getDimension(this.range, 'offsetWidth');
            this.maxHandleX = this.rangeWidth - this.handleWidth;
            this.grabX = this.handleWidth / 2;
            this.position = this._getPositionFromValue(this.value);

            // Consider disabled state
            if (this.element.disabled) {
                addClass(this.range, this.options.disabledClass);
            } else {
                removeClass(this.range, this.options.disabledClass);
            }

            this._setPosition(this.position);
            if (this.options.bufferClass && this.options.buffer) {
                this._setBufferPosition(this.options.buffer);
            }
            this._updatePercentFromValue();
            triggerEvent(this.element, 'change', {origin: this.identifier});
        };


        Plugin.prototype._handleResize = function () {
            var _this = this;
            return debounce(function () {
                // Simulate resizeEnd event.
                delay(function () {
                    _this._update();
                }, HANDLE_RESIZE_DELAY);
            }, HANDLE_RESIZE_DEBOUNCE)();
        };

        Plugin.prototype._handleDown = function (e) {
            this.isInteractsNow = true;
            e.preventDefault();
            addEventListeners(document, this.options.moveEvent, this._handleMove);
            addEventListeners(document, this.options.endEvent, this._handleEnd);

            // If we click on the handle don't set the new position
            if ((' ' + e.target.className + ' ').replace(newLineAndTabRegexp, ' ').indexOf(this.options.handleClass) > -1) {
                return;
            }

            var posX = this._getRelativePosition(e),
                rangeX = this.range.getBoundingClientRect().left,
                handleX = this._getPositionFromNode(this.handle) - rangeX;

            this._setPosition(posX - this.grabX);

            if (posX >= handleX && posX < handleX + this.handleWidth) {
                this.grabX = posX - handleX;
            }
            this._updatePercentFromValue();
        };

        Plugin.prototype._handleMove = function (e) {
            this.isInteractsNow = true;
            e.preventDefault();
            var posX = this._getRelativePosition(e);
            this._setPosition(posX - this.grabX);
            //this.isInteractsNow = false;
        };

        Plugin.prototype._handleEnd = function (e) {
            e.preventDefault();
            removeEventListeners(document, this.options.moveEvent, this._handleMove);
            removeEventListeners(document, this.options.endEvent, this._handleEnd);

            // Ok we're done fire the change event
            triggerEvent(this.element, 'change', {origin: this.identifier});

            if (this.isInteractsNow || this.needTriggerEvents) {
                if (this.onSlideEnd && typeof this.onSlideEnd === 'function') {
                    this.onSlideEnd(this.value, this.percent, this.position);
                }
            }
            this.onSlideEventsCount = 0;
            this.isInteractsNow = false;
        };

        Plugin.prototype._cap = function (pos, min, max) {
            if (pos < min) {
                return min;
            }
            if (pos > max) {
                return max;
            }
            return pos;
        };

        Plugin.prototype._setPosition = function (pos) {
            var value, left,
                stickTo, stickRadius,
                restFromValue;

            // Snapping steps
            value = this._getValueFromPosition(this._cap(pos, 0, this.maxHandleX));

            // Stick to stick[0] in radius stick[1]
            if (this.stick) {
                stickTo = this.stick[0];
                stickRadius = this.stick[1] || 0.1;
                restFromValue = value % stickTo;
                if (restFromValue < stickRadius) {
                    value = value - restFromValue;
                } else if (Math.abs(stickTo - restFromValue) < stickRadius) {
                    value = value - restFromValue + stickTo;
                }
            }
            left = this._getPositionFromValue(value);

            // Update ui
            this.fill.style.width = (left + this.grabX) + 'px';
            this.handle.style.transform = 'translateX(' + left + 'px)';
            this._setValue(value);

            // Update globals
            this.position = left;
            this.value = value;
            this._updatePercentFromValue();

            if (this.isInteractsNow || this.needTriggerEvents) {
                if (this.onSlideStart && typeof this.onSlideStart === 'function' && this.onSlideEventsCount === 0) {
                    this.onSlideStart(this.value, this.percent, this.position);
                }

                if (this.onSlide && typeof this.onSlide === 'function') {
                    this.onSlide(this.value, this.percent, this.position);
                }
            }

            this.onSlideEventsCount++;
        };

        Plugin.prototype._setBufferPosition = function (pos) {
            var isPercent = true,
                bufferWidth,
                paddingWidth,
                bufferWidthWithPadding;
            if (isFinite(pos)) {
                pos = parseFloat(pos);
            } else if (isString(pos)) {
                if (pos.indexOf('px') > 0) {
                    isPercent = false;
                }
                pos = parseFloat(pos);
            } else {
                console.warn('New position must be XXpx or XX%');
                return;
            }

            if (isNaN(pos)) {
                console.warn('New position is NaN');
                return;
            }
            if (!this.options.bufferClass) {
                console.warn('You disabled buffer, it\'s className is empty');
                return;
            }
            bufferWidth = isPercent ? pos : (pos / this.rangeWidth * 100);
            if (bufferWidth < 0) {
                bufferWidth = 0;
            }
            if (bufferWidth > 100) {
                bufferWidth = 100;
            }
            this.options.buffer = bufferWidth;

            paddingWidth = this.options.borderRadius / this.rangeWidth * 100;
            bufferWidthWithPadding = bufferWidth - paddingWidth;
            if (bufferWidthWithPadding < 0) {
                bufferWidthWithPadding = 0;
            }

            this.buffer.style.width = bufferWidthWithPadding + '%';
            this.buffer.style.left = paddingWidth * 0.5 + '%';
            this.element.setAttribute('data-buffer', bufferWidth);
        };

        // Returns element position relative to the parent
        Plugin.prototype._getPositionFromNode = function (node) {
            var i = 0;
            while (node !== null) {
                i += node.offsetLeft;
                node = node.offsetParent;
            }
            return i;
        };

        /**
         *
         * @param {(MouseEvent|TouchEvent)}e
         * @returns {number}
         */
        Plugin.prototype._getRelativePosition = function (e) {
            // Get the offset left relative to the viewport
            var rangeX = this.range.getBoundingClientRect().left,
                pageX = 0;

            if (typeof e.pageX !== 'undefined') {
                pageX = (e.touches && e.touches.length) ? e.touches[0].pageX : e.pageX;
            }
            else if (typeof e.originalEvent !== 'undefined') {
                if (typeof e.originalEvent.clientX !== 'undefined') {
                    pageX = e.originalEvent.clientX;
                }
                else if (e.originalEvent.touches && e.originalEvent.touches[0] && typeof e.originalEvent.touches[0].clientX !== 'undefined') {
                    pageX = e.originalEvent.touches[0].clientX;
                }
            }
            else if (e.touches && e.touches[0] && typeof e.touches[0].clientX !== 'undefined') {
                pageX = e.touches[0].clientX;
            }
            else if (e.currentPoint && typeof e.currentPoint.x !== 'undefined') {
                pageX = e.currentPoint.x;
            }

            return pageX - rangeX;
        };

        Plugin.prototype._getPositionFromValue = function (value) {
            var percentage, pos;
            percentage = (value - this.min) / (this.max - this.min);
            pos = percentage * this.maxHandleX;
            return pos;
        };

        Plugin.prototype._getValueFromPosition = function (pos) {
            var percentage, value;
            percentage = ((pos) / (this.maxHandleX || 1));
            value = this.step * Math.round(percentage * (this.max - this.min) / this.step) + this.min;
            return Number((value).toFixed(this.toFixed));
        };

        Plugin.prototype._setValue = function (value, force) {
            if (value === this.value && !force) {
                return;
            }

            // Set the new value and fire the `input` event
            this.element.value = value;
            this.value = value;
            triggerEvent(this.element, 'input', {origin: this.identifier});
        };


        /**
         *
         * @param {Object} obj like {min : Number, max : Number, value : Number, step : Number, buffer : [String|Number]}
         * @param {Boolean} triggerEvents
         * @returns {Plugin}
         */
        Plugin.prototype.update = function (obj, triggerEvents) {
            if (triggerEvents) {
                this.needTriggerEvents = true;
            }
            if (isObject(obj)) {
                if (isNumberLike(obj.min)) {
                    this.element.setAttribute('min', '' + obj.min);
                    this.min = obj.min;
                }

                if (isNumberLike(obj.max)) {
                    this.element.setAttribute('max', '' + obj.max);
                    this.max = obj.max;
                }

                if (isNumberLike(obj.step)) {
                    this.element.setAttribute('step', '' + obj.step);
                    this.step = obj.step;
                    this.toFixed = this._toFixed(obj.step);
                }

                if (isNumberLike(obj.buffer)) {
                    this._setBufferPosition(obj.buffer);
                }

                if (isNumberLike(obj.value)) {
                    this._setValue(obj.value);
                }
            }
            this._update();
            this.onSlideEventsCount = 0;
            this.needTriggerEvents = false;
            return this;
        };

        Plugin.prototype.destroy = function () {
            removeAllListenersFromEl.call(this, document);
            window.removeEventListener('resize', this._handleResize, false);
            this.element.removeEventListener('change', this._changeEventListener, false);

            this.element.style.cssText = '';
            delete this.element[pluginName];

            // Remove the generated markup
            if (this.range) {
                this.range.parentNode.removeChild(this.range);
            }
        };

        // A really lightweight plugin wrapper around the constructor,
        // preventing against multiple instantiations

        Plugin.create = function (el, options) {
            function createInstance(el) {
                var data = el[pluginName];

                // Create a new instance.
                if (!data) {
                    data = new Plugin(el, options);
                    el[pluginName] = data;
                }
            }

            if (el.length) {
                Array.prototype.slice.call(el).forEach(function (el) {
                    createInstance(el);
                });
            } else {
                createInstance(el);
            }
        };

        return Plugin;

    }
));
var switchToVertical = function(){


    let wide = body.querySelectorAll('.wide')
    let column = body.querySelectorAll('.column')

    if (document.body.classList.contains('articlesVerticalMode')) {
        
        body.classList.remove('articlesVerticalMode')


        for(el of column){

            // select element to unwrap
            // get the element's parent node
            var parent = el.parentNode

            // move all children out of the element
            while (el.firstChild) parent.insertBefore(el.firstChild, el)

            // remove the empty element
            parent.removeChild(el)

        }

        horizontalRead()
        jQuery("#article-reader").show();


    }else{

        body.classList.add('articlesVerticalMode')

        for(w of wide){
            w.removeAttribute('style')
            w.classList.remove('wide-column-border-right')
            w.classList.remove('wide-column-border-left')
        }

        for(col of column){
            col.removeAttribute('style')
            col.classList.remove('wide-column-border-right')
            col.classList.remove('wide-column-border-left')
            col.style.minHeight = 'auto'
        }


    }


    


}
var isMobile = {
	Android: function () {
		return navigator.userAgent.match(/Android/i)
	},
	BlackBerry: function () {
		return navigator.userAgent.match(/BlackBerry/i)
	},
	iOS: function () {
		return navigator.userAgent.match(/iPhone|iPad|iPod/i)
	},
	Opera: function () {
		return navigator.userAgent.match(/Opera Mini/i)
	},
	Windows: function () {
		return navigator.userAgent.match(/IEMobile/i) || navigator.userAgent.match(/WPDesktop/i)
	},
	any: function () {
		return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows())
	}
}

var cssTransform = (function () {
	var prefixes = 'transform webkitTransform mozTransform oTransform msTransform'.split(' '),
		el = document.createElement('div'),
		cssTransform, i = 0
	while (cssTransform === undefined) {
		cssTransform = document.createElement('div').style[prefixes[i]] != undefined ? prefixes[i] : undefined
		i++
	}
	console.log(cssTransform)
	return cssTransform
})()

DomReady.ready(function () {

	$("#lightgallery").lightGallery();

	let btns = document.querySelectorAll('.menu-item')

	for (let btn of btns) {
		new Menu(btn)
	}

	let newFolder = document.querySelector('.new')
	new Folder(newFolder)

	// SCALE RANGE
	var selector = '[data-rangeSlider]',
		elements = document.querySelectorAll(selector)

	// Basic rangeSlider initialization
	rangeSlider.create(elements, {

		// Callback function
		onSlideEnd: function (value, percent, position) {

			let img = body.querySelector('#reader-flow img')

			let v = value >= 10 ? 2 : `1.${value}`

			img.style[cssTransform] = `scale(${v})`

			//console.warn('onSlideEnd', 'value: ' + value, 'percent: ' + percent, 'position: ' + position);

		}

	})

	function valueOutput(element) {
		var value = (element.value * 10) + 100,
			output = element.parentNode.getElementsByTagName('output')[0]
		output.innerHTML = value
	}

	for (var i = elements.length - 1; i >= 0; i--) {
		valueOutput(elements[i])
	}

	Array.prototype.slice.call(body.querySelectorAll('input[type="range"]')).forEach(function (el) {
		el.addEventListener('input', function (e) {
			valueOutput(e.target)
		}, false)
	})


	// HAMBURGER MENU
	let hamburger = body.querySelector('.hamburger')

	hamburger.addEventListener('click', function () {
		body.classList.toggle('menu-opned')
		hamburger.classList.toggle('open')
	})


	if (isMobile.any()) {

		document.addEventListener('touchstart', handleTouchStart, false);
		document.addEventListener('touchmove', handleTouchMove, false);

		var xDown = null;
		var yDown = null;

		function handleTouchStart(evt) {
			xDown = evt.touches[0].clientX;
			yDown = evt.touches[0].clientY;
		};

		function handleTouchMove(evt) {
			if (!xDown || !yDown) {
				return;
			}

			var xUp = evt.touches[0].clientX;
			var yUp = evt.touches[0].clientY;

			var xDiff = xDown - xUp;
			var yDiff = yDown - yUp;

			if (Math.abs(xDiff) > Math.abs(yDiff)) {/*most significant*/
				if (xDiff > 0) {
					/* left swipe */
					console.log('left')
					let mn = document.querySelector('.multimidia_next')
					mn.click()


				} else {
					/* right swipe */
					console.log('right')

					let mp = document.querySelector('.multimidia_prev')
					mp.click()

				}
			}
			/* reset values */
			xDown = null;
			yDown = null;
		}

		var myElement = document.getElementById('pageDiv')

		var mc = new Hammer.Manager(myElement)

		// create a pinch and rotate recognizer
		// these require 2 pointers
		var pinch = new Hammer.Pinch()
		var tap = new Hammer.Tap()


		// add to the Manager
		mc.add([pinch, tap])

		mc.on("tap", function (ev) {
			if (zoomOpned) {
				increaseZoom(ev)
			}
		})

		mc.on("pinchin", function (ev) {
			if (zoomOpned) {
				//decreaseZoom(ev)
				closeZoom()
			}
		})

		// when change orientation on mobile
		window.addEventListener('orientationchange', refreshPageZoom)

	}

	load()

})

