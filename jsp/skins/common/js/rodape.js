function setRodapeScroll(obj){
    obj = document.getElementById(obj);
    if(obj){
         try{ window.onscroll = setTimeout("placeFooterIt('rodape_baixo_id')",500); }catch(e){}
    }
}

 function f_scrollTop() {
	return f_filterResults (
		window.pageYOffset ? window.pageYOffset : 0,
		document.documentElement ? document.documentElement.scrollTop : 0,
		document.body ? document.body.scrollTop : 0
	);
}

function f_clientHeight() {
	return f_filterResults (
		window.innerHeight ? window.innerHeight : 0,
		document.documentElement ? document.documentElement.clientHeight : 0,
		document.body ? document.body.clientHeight : 0
	);
}
function f_filterResults(n_win, n_docel, n_body) {
	var n_result = n_win ? n_win : 0;
	if (n_docel && (!n_result || (n_result > n_docel)))
		n_result = n_docel;
	return n_body && (!n_result || (n_result > n_body)) ? n_body : n_result;
}




function placeFooterIt(obj){    
    obj = document.getElementById(obj);
    obj.style.left = '0px' ;
    obj.style.top = ((f_clientHeight()+f_scrollTop())-rodape_height)+'px' ;
    setTimeout("placeFooterIt('rodape_baixo_id')",500);
}

setRodapeScroll("rodape_baixo_id");