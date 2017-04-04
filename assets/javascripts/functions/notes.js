class Note {

  constructor(notes) {

    this.main = document.querySelector('#reader')
    this.imgWrp = this.main.querySelector('#readercontainer') || false

    
    this.modal = document.querySelector('#notes')
    this.save = this.modal.querySelector('#notes-form')
    this.note = this.modal.querySelector('#note')
    this.close = this.modal.querySelector('.md-close')
    this.text = ''
    this.span = ''
    this.close.addEventListener('click', this.closer.bind(this))
    this.save.addEventListener('submit', this._add.bind(this))
  }

  init(notes, especificNote) {

    if (!this.imgWrp) this.imgWrp = this.main.querySelector('#readercontainer .pagecontainer')

    notes.map(e => {
      if (e.page == especificNote) this.imgWrp.appendChild(this.template(e.text, e.x, e.y, e.id, 1))
    })
  }

  open(e) {

    this.modal.querySelector('h3').innerHtml = 'Editar Nota'
    this.save.querySelector('textarea').value = e.target.dataset.text
    this.opner()
  }

  opner() {

    this.modal.classList.add('md-show')
    this.main.style.opacity = 0.3
  }

  closer() {

    this.modal.classList.remove('md-show')
    this.main.style.opacity = 1
  }

  clear() {

    let n = document.querySelectorAll('.note-added')

    for (let i = 0; n.length > i; i++) {
      n[i].remove()
    }

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

  _add(e) {
    
    e.preventDefault()

    if (!this.imgWrp) this.imgWrp = this.main.querySelector('#readercontainer .pagecontainer')
    if (this.note.value) this.imgWrp.appendChild(this.template(this.note.value, 15, 15, Date.now(), 1))

    this.saving(this.note.value, 15, 15, Date.now())
    this.closer()
  }

  saving(txt, x, y, id) {

    console.log(txt, x, y, id)

    // return {
    //   x: x,
    //   y: y,
    //   text: txt,
    //   id: id
    // }
  }

  handleDragStart(e) {

    e.target.style.opacity = 0.3
    e.target.querySelector('.note-element').style.display = 'none'
  }

  handleDragEnd(e) {

    let l = this.imgWrp.getBoundingClientRect().left - 5
    let t = this.imgWrp.getBoundingClientRect().top - 5

    let x = e.pageX - l
    let y = e.pageY - t - e.toElement.clientHeight
    let i = e.target.dataset.id
    let tx = e.target.dataset.text

    e.target.style.left = `${x}px`
    e.target.style.top = `${y}px`
    e.target.style.position = 'absolute'
    e.target.style.opacity = 1

    e.target.querySelector('.note-element').style.display = 'block'

    this.saving(tx, x, y, i)

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

    return this.span
  }

}

function newNote() {
  note.opner()
}
