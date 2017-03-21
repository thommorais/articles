
 DomReady.ready(function() {

  $("#lightgallery").lightGallery();

  let btns = document.querySelectorAll('.menu-item')

  for(let btn of btns){
    new Menu(btn)
  }

  let newFolder = document.querySelector('.new')
  new Folder(newFolder)

  load()

  note.init(notes)

  let d  = document.querySelector('#reader')
  console.log(d)
})
