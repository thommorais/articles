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

