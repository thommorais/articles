<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%
    String baseweb = br.com.maven.flip.util.UrlBaseUtil.getUrlStatic(request);    
    String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
    String cd=request.getParameter("cd");
    String mod=request.getParameter("mod");
    if(mod == null||"".equals(mod)){
        mod="89";
    }
    br.com.maven.flip.javasql.view.portal.MateriaHomeBean materia=br.com.maven.flip.javasql.dao.MateriaDAO.materia(cd,Integer.parseInt(mod));
    request.setAttribute("article",materia);
%>        
<!DOCTYPE html>
<html lang="pt">
    <head>        
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">		
        <meta name="viewport" content="width=device-width, initial-scale=1.0">        
        <title><c:out value="${article.titulo}"/></title>
        <meta name="description" content="<c:out value='${article.chamada}'/>" />
        <link href='//fonts.googleapis.com/css?family=Roboto:700,600,500,400,300,200' rel='stylesheet' type='text/css'>        
        <script type="text/javascript"  src="//ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script type="text/javascript"  src="//code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
        <link rel="stylesheet" type="text/css" href="<%= base%>flip/jornal/skins/article/css/reader-article.css" >                        
    </head>
    <body>
        <div id="wrapper">
            <div class="wide">	
                <c:if test="${!empty article.foto.pathImage}">
                    <div class="wide-image">
                        <img src="<%= base%><c:out value='${article.foto.pathImage}'/>"/>
                    </div>
                </c:if>
                <c:if test="${!empty article.videoObj.video}">
                    <div class="wide-video">
                        <div class="video-container">
                            <iframe width="853" height="480" src="https://www.youtube.com/embed/<c:out value='${article.videoObj.videoCode}'/>?autoplay=1" frameborder="0" allowfullscreen></iframe>
                        </div>                        
                    </div>
                </c:if>                                   
                <div class="wide-center">
                    <h1><c:out value="${article.titulo}"/></h1>
                    <h2><c:out value="${article.chamada}"/></h2>                
                    <div class="wide-content">                
                        <c:out value="${article.texto}" escapeXml="false"/>                
                    </div>
                </div>
            </div>
        </div>
        <br/><br/><br/>
    </body>
</html>
