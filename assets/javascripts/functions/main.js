DomReady.ready(function () {

  $("#lightgallery").lightGallery();

  let btns = document.querySelectorAll('.menu-item')

  for (let btn of btns) {
    new Menu(btn)
  }

  let newFolder = document.querySelector('.new')
  new Folder(newFolder)


  var selector = '[data-rangeSlider]',
    elements = document.querySelectorAll(selector)


  // Basic rangeSlider initialization
  rangeSlider.create(elements, {
    // Callback function
    onInit: function () {
    },
    // Callback function
    onSlideStart: function (value, percent, position) {
      console.info('onSlideStart', 'value: ' + value, 'percent: ' + percent, 'position: ' + position);
    },
    // Callback function
    onSlide: function (value, percent, position) {
      console.log('onSlide', 'value: ' + value, 'percent: ' + percent, 'position: ' + position);
    },
    // Callback function
    onSlideEnd: function (value, percent, position) {
      console.warn('onSlideEnd', 'value: ' + value, 'percent: ' + percent, 'position: ' + position);
    }

  })


    function valueOutput(element) {
        var value = element.value,
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

    let hamburger = body.querySelector('.hamburger')

    hamburger.addEventListener('click', function() {
      body.classList.toggle('menu-opned')
      hamburger.classList.toggle('open')
    })

  load()

})



