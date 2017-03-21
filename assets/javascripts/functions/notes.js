 class Note{

  constructor(notes) {
    this.main   = body.querySelector('#reader')
    this.imgWrp = this.main.querySelector('#readercontainer') || false
    this.modal  = body.querySelector('#notes')
    this.save   = this.modal.querySelector('#notes-form')
    this.note   = this.modal.querySelector('#note')
    this.close  = this.modal.querySelector('.md-close')
    this.span   = ''
    this.close.addEventListener( 'click', this.closer.bind(this))
    this.save.addEventListener( 'submit', this._add.bind(this))
  }

  init(notes){

    if(!this.imgWrp) this.imgWrp = this.main.querySelector('#readercontainer .pagecontainer')
    notes.map( e => this.imgWrp.appendChild( this.template(e.text, e.x, e.y, 1) ) )
  }

  opner() {

    this.modal.classList.add('md-show')
    this.main.style.opacity = 0.3
  }

  closer() {

    this.modal.classList.remove('md-show')
    this.main.style.opacity = 1
  }

  showNote(e){

    e.stopPropagation()

    let text = e.target.dataset.text
    let el   = document.createElement('div')
    let inner = `<div>${text}</div>`

    el.classList.add('note-element')
    el.addEventListener('click', function(e){ e.stopPropagation() })
    el.insertAdjacentHTML('beforeend',  inner)

    e.target.appendChild(el)
    e.target.style.opacity = 1
  }

  _add(e){
    e.preventDefault()

    if(!this.imgWrp) this.imgWrp = this.main.querySelector('#readercontainer .pagecontainer')
    if(this.note.value) this.imgWrp.appendChild(this.template(this.note.value, 15, 15, 1))

    this.closer()
  }

  handleDragStart(e){

    e.target.style.opacity = 0.3
    e.target.querySelector('.note-element').style.display = 'none'
  }

  handleDragEnd(e){


    let l = this.imgWrp.getBoundingClientRect().left - 5
    let t = this.imgWrp.getBoundingClientRect().top - 5

    let x = e.pageX - l
    let y = e.pageY - t - e.toElement.clientHeight

    e.target.style.left = `${x}px`
    e.target.style.top = `${y}px`
    e.target.style.position = 'absolute'
    e.target.style.opacity = 1

    e.target.querySelector('.note-element').style.display = 'block'


  }

  template(value, x, y, o) {

    this.span = document.createElement('span')
    this.span.classList.add('note-added')
    this.span.setAttribute('draggable', 'true')
    this.span.setAttribute('data-text', value)
    this.span.style.left = `${x}px`
    this.span.style.top = `${y}px`
    this.span.style.opacity = o

    let el   = document.createElement('div')
    let inner = `<div>${value}</div>`
    el.classList.add('note-element')

    el.insertAdjacentHTML('beforeend',  inner)
    this.span.appendChild(el)
    this.span.insertAdjacentHTML('beforeend',  `<i class="fa fa-sticky-note-o" aria-hidden="true"></i>`)

    this.span.addEventListener('dragstart', this.handleDragStart.bind(this), false)
    this.span.addEventListener('dragend', this.handleDragEnd.bind(this), false)
    console.log(this.span)
    return this.span
  }

}

function newNote(){
  note.opner()
}
