<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>

<div style='float: left; margin: 5px 2px 10px 10px'>
    <a class='share-button sb-facebook' href='http://www.facebook.com/sharer.php?u=<c:out value="${param.base}"/>&t=<c:out value="${param.titulo}"/>' target='_blank' title='Compartilhar no Facebook'>
        <span class='share-button-link-text'>
            Compartilhar no Facebook
        </span>
    </a>
    <a class='share-button sb-blog' title='BlogThis!'><span class='share-button-link-text'>BlogThis!</span></a>
    <a class='share-button sb-twitter' href='http://twitthis.com/twit?url=<c:out value="${param.base}"/>&title=<c:out value="${param.titulo}"/>' target='_blank' title='Compartilhar no Twitter'>
        <span class='share-button-link-text'>
            Compartilhar no Twitter
        </span></a>
 | 
        <iframe allowTransparency='true' frameborder='0' scrolling='no' src='http://www.facebook.com/plugins/like.php?href=<c:out value="${param.base}"/>&layout=button_count&show_faces=false&width=80&action=like&colorscheme=light' style='border:none; overflow:hidden; width:80px; height:20px'></iframe>       
</div>
