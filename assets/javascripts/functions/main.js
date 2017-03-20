
 DomReady.ready(function() {

  $("#lightgallery").lightGallery();

  let btns = document.querySelectorAll('.menu-item')

  for(let btn of btns){
    new Menu(btn)
  }

  let newFolder = document.querySelector('.new')
  new Folder(newFolder)

  load()


  let timer = setInterval( () => {

    let dm = document.querySelector('#readercontainer .pagecontainer') || false

    if(dm){
      clearTimeout(timer)
      note.init(notes)
    }

  }, 300)


})
