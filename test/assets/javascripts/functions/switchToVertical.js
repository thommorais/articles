var switchToVertical = function(){


    let wide = body.querySelectorAll('.wide')
    let column = body.querySelectorAll('.column')

    if (document.body.classList.contains('articlesVerticalMode')) {
        
        body.classList.remove('articlesVerticalMode')


        for(el of column){

            // select element to unwrap
            // get the element's parent node
            var parent = el.parentNode

            // move all children out of the element
            while (el.firstChild) parent.insertBefore(el.firstChild, el)

            // remove the empty element
            parent.removeChild(el)

        }

        horizontalRead()
        jQuery("#article-reader").show();


    }else{

        body.classList.add('articlesVerticalMode')

        for(w of wide){
            w.removeAttribute('style')
            w.classList.remove('wide-column-border-right')
            w.classList.remove('wide-column-border-left')
        }

        for(col of column){
            col.removeAttribute('style')
            col.classList.remove('wide-column-border-right')
            col.classList.remove('wide-column-border-left')
            col.style.minHeight = 'auto'
        }


    }


    


}