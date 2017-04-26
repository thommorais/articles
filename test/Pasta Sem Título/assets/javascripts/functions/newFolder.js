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
