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

