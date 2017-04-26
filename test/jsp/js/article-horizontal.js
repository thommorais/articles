function horizontalRead() {

    jQuery('.wide-title').addClass('dontend');

    var w = jQuery(window).width();
    var h = jQuery(window).height() - 70;
    if (w > 800) {
        w = w / 3;
    } else {
        if (w > 400) {
            w = w / 2;
        }
    }
    jQuery('.wide').columnize({
        width: w,
        height: h
    });
    
    jQuery("#article-reader").hide();
    jQuery("div:has('.wide-title')").addClass('wide-column-border-left');
    jQuery("div:has('.leiamais')").addClass('wide-column-border-right');

}

// jQuery(document).ready(function () {

// });



function loadJSON(file) {

    return new Promise((resolve, reject) => {

        var xobj = new XMLHttpRequest()
        xobj.overrideMimeType("application/json")
        xobj.open('GET', file, true)
        xobj.onreadystatechange = () => {

            if (xobj.readyState == 4 && xobj.status == "200") {
                if (xobj.status == 200) resolve(JSON.parse(xobj.responseText))
                else reject(Error(xobj.statusText))

            }
        }

        xobj.send(null)
    })
}

DomReady.ready(function () {
    // caching the article item template
    let newsTemplate = document.querySelector('#article-reader .wide')
    let news_json = 'http://thommorais.com/json/noticias.json'

    if(news_json){
        loadJSON(news_json)
            .then(response => {

                let list = response.data.campos.lista

                Object.keys(list).forEach( i => {
                    
                    let strings =
                    `<h1 class="wide-title dontend">${list[i].campos.info.titulo}</h1>
                    <h2>${list[i].campos.info.apoio}</h2>
                    <p style="font-family: Georgia, serif; font-size: 18px;">
                        "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. 
                        Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. 
                    </p>
          
                    <p>
                        Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"
      
                        <a href="javascript:abreArtigo('a87ff679a2f3e71d9181a67b7542122c');" class="btn  btn-block btn-primary btn-primary leiamais columnbreak">Leia essa matéria <span class="glyphicon glyphicon-arrow-right"></span></a>
                    </p>`
                        
                   newsTemplate.insertAdjacentHTML('afterbegin', strings)

                })

                horizontalRead()                

            })
    }


})





