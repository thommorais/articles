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

      fecharOutros();
      body.classList.remove('overlay-opened')

      console.warn('close')

    }

    openOverlay(el){

      this.close()

      this.over = document.querySelector(`[data-overlay="${el.id}"]`)
      body.classList.add('overlay-opened')

      if(this.over){

        this.over.style.display = 'block'
        this.over.querySelector('.close').addEventListener('click', this.close.bind(this))


      }else{
        console.warn('No Modal')
      }

    }

  }
