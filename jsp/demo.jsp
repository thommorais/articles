<%@ page language="java" buffer="8kb" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%
            String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
            String skin = request.getAttribute("skin").toString();
            if(skin == null || skin.trim().length() <=0 ){
                skin="default";
            }

            String head= "skins/"+skin+"/head.jsp";
            String body= "skins/"+skin+"/body.jsp";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>
            <c:out value="${prefs.titulo}"/>
        </title>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta http-equiv="expires" content="Fri, 1 Jan 1990 00:00:00 GMT"/>
        <meta http-equiv="Pragma" content="no-cache"/>
        <meta name="MSSmartTagsPreventParsing" content="true" />
        <meta name="revisit-after" content="5 days" />
        <meta name="resource-type" content="document" />
        <meta name="revisit" content="5 days" />
        <meta name="rating" content="General" />
        <meta name="robots" content="ALL" />
        <meta http-equiv="cache-control" content="no-cache, no-store, must-revalidate"/>
        <meta name="Description" content="Folheando revistas e publicações na internet - Mais completa plataforma multimídia interativa que combina a única experiência de folhear uma revista." />
        <meta name="Keywords" content="pageflip, revista digital, folheando revista, jornal digital, jornal virtual, documentos eletrônicos, revista em flash, papel virtual" />
        <script type="text/javascript" src="<%= base%>flip/jornal/js/flipsite.js" charset="utf-8"></script>
        <script type="text/javascript">
            var base='<%= base%>';
            var online=<c:out value="${empty offline || offline eq 'false' || !empty logado}"/>;
            var folder='<c:out value="${folder}"/>';
            var sumarioFotos='<c:out value="${prefs.sumarioFotos}"/>';
            var zoomBlocked=<c:out value="${prefs.bloquearZoomNaoAssinantes}"/>;
            var linkedicao='<c:out value="${edicao_dia}"/>';

            <c:if test="${!empty prefs.paginasEditoriasPublicasList}">
                <c:forEach var="item" items="${prefs.paginasEditoriasPublicasList}" varStatus="i">
                    freePagesList[<c:out value="${i.index}"/>]='<c:out value="${item}"/>';
                </c:forEach>
            </c:if>
            var ipg=null;
            <c:if test="${!empty param.ipg}">
                ipg = 'anch<c:out value="${param.ipg}"/>';
            </c:if>

                function getCurrentEdition(){
                    return <c:out value="${page.id}"/>;
                }
        </script>
        <script type="text/javascript" src="<%= base%>flip/jornal/swfobject/swfobject.js"  charset="utf-8"></script>
        <script type="text/javascript" src="<%= base%>flip/jornal/player/mavenflip.js"  charset="utf-8"></script>

        <jsp:include page="<%= head %>" flush="true">
            <jsp:param name="base" value="<%= base %>"/>
        </jsp:include>
    </head>
    <body oncontextmenu="return false" id="pageDiv" >

        <jsp:include page="<%= body %>" flush="true">
            <jsp:param name="base" value="<%= base %>"/>
        </jsp:include>

        <c:if test="${!empty prefs.rodape}">
            <link href="<%= base%>flip/jornal/skins/common/css/rodape.css" rel="stylesheet" type="text/css" media="screen"/>
            <div class="rodape_baixo" id="rodape_baixo_id">
                <c:if test="${prefs.contadorVisitas}">
                10 pessoas visitaram essa edição
                <br/>
                </c:if>
                <c:out value="${prefs.rodape}"/>
            </div>
            <script type="text/javascript" src="<%= base%>flip/jornal/skins/common/js/rodape.js" charset="utf-8"></script>
        </c:if>

    </body>

</html>
