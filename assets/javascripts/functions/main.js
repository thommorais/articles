// Menu


  class Menu {

    constructor(btn){
      this.btn   = btn
      this.over  = ''
      this.overlay = document.querySelectorAll('.overlay-content')

      this.btn.addEventListener('click', () => this.openOverlay(this.btn) )

    }

    close(){

      Array.prototype.forEach.call(this.overlay, function(ovrl) {
        ovrl.style.display = 'none'
      })

      body.classList.remove('overlay-opened')

    }

    openOverlay(el){

      this.close()

      this.over = document.querySelector(`[data-overlay="${el.id}"]`)

      if(this.over){

        this.over.style.display = 'block'
        this.over.querySelector('.close').addEventListener('click', this.close.bind(this))
        body.classList.add('overlay-opened')

      }else{
        console.info('A modal não existe')
      }

    }

  }

  let btns = document.querySelectorAll('.btn')

  for(let btn of btns){
    new Menu(btn)
  }
