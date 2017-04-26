function cached(url){
  let lastUrl = null
  return lastUrl
}

function addtoFavorite(){

  let ins   = body.querySelector('.page_left .pageimg'),
      page  = ins.getAttribute('page-id'),
      url   = ins.querySelector('img').getAttribute('src'),
      fav = document.querySelector('[data-overlay="mdl-favoritos"] #folders'),
      template = `<a class="file favorited drag" data-folder="false" data-name="${page}" href="javascript:void(0);" onclick="gotoAnchor('anch${page}',false); return false;" class="multimidia-item">
                    <figure><img class="img-responsive" src="${url.replace('normal', 'thumb')}"></figure>
                  </a>`

  //fav.insertAdjacentHTML('beforeend', template)

    let obj = {
          id : page,
          url : url,
          template : template
        }


  //load()
  console.log(obj)
  return obj

}
