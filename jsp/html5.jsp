<!DOCTYPE html>
<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<%
    response.addHeader("P3P", "CP=\"CAO PSA OUR\"");
    String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);

%>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <title><c:out value="${page.flipModeloPublicacaoidid_modelo.prefs.titulo}"/> -  <fmt:message key="site.edicaonumero"/> <c:out value="${page.nrFixo}"/> - MavenApp web </title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
        <script src='//code.jquery.com/jquery-3.1.0.min.js'></script>
        <script src='//code.jquery.com/ui/1.12.1/jquery-ui.min.js'></script>




        <!-- para compartilhar -->
        <meta property="og:type" content="website" >
        <meta property="og:title" content="<c:out value='${page.nome}'/>" >
        <meta property="og:description" content="<c:out value='${page.sobre}'/>" >
        <meta property="og:image" content='<%= base%><c:out value="${page.img}"/>'>
        <meta name="twitter:card" content="summary" >
        <meta name="twitter:title" content="<c:out value='${page.nome}'/>" >
        <meta name="twitter:description" content="<c:out value='${page.sobre}'/>" >
        <meta name="twitter:image" content='<%= base%><c:out value="${page.img}"/>'>


<script type='text/javascript'>
            var doc_x = '<c:out value="${paginaWidth}"/>';
            var doc_y = '<c:out value="${paginaHeight}"/>';
            var base = '<%= base%>';
    var index = 0, indexmedia = 0, indexpic = 0, indextemplinks = 0;
    var pageslist = new Array();
    var pfmedias = new Array();
    var pfmediaspics = new Array();
    var pftemplinks = new Array();
    var iconVideo = <c:out value = "${page.flipModeloPublicacaoidid_modelo.prefs.iconVideo}"/>;
    <c:forEach var = "pag" items = "${paginaslist}" varStatus = "i">
        <c:choose>
            <c:when test = "${pag.app}">
                <c:choose>
                    <c:when test="${!empty pag.html5Zip}">
    pageslist[index++] = ["<c:out value='${pag.id}'/>", "<c:out value='${pag.html5}'/>", "<c:out value='${pag.html5Zip}'/>", "<c:out value='${pag.html5Zip}'/>"];
                    </c:when>
                    <c:otherwise>
    pageslist[index++] = ["<c:out value='${pag.id}'/>", "HTML5", "HTML5", "HTML5"];
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise>
    pageslist[index++] = ["<c:out value='${pag.id}'/>", "<c:out value='${pag.pathImage}'/>", "<c:out value='${pag.pathNormal}'/>", "<c:out value='${pag.pathThumb}'/>"];
            </c:otherwise>
        </c:choose>
        <c:if test = "${!empty pag.links}"><c:forEach var = "link" items = "${pag.links}">
    pfmedias[indexmedia++] = ['link', "<c:out value='${i.index+1}'/>", "<c:out value="${link.x}"/>", "<c:out value="${link.y}"/>", "<c:out value="${link.width}"/>", "<c:out value="${link.height}"/>", <c:choose><c:when test = "${!link.anchor}">base+"flip/jornal/link.jsp?id=<c:out value="${link.id}"/>"</c:when><c:otherwise>"<c:out value="${link.link}"/>"</c:otherwise></c:choose>, "<c:out value = "${link.percentualX}"/>", "<c:out value = "${link.percentualY}"/>", "<c:out value = "${link.id}"/>", "<c:out value = "${link.pagina.width}"/>", "<c:out value = "${link.pagina.height}"/>", "<c:out value = '${link.label}'/>", "<c:choose><c:when test = '${link.popupWeb}'>V</c:when><c:otherwise><c:out value='${link.tipo}'/></c:otherwise></c:choose>", "<c:if test = '${link.iconeWeb}'><c:out value = '${link.icone}'/></c:if>"];
            </c:forEach></c:if>
        <c:if test = "${!empty pag.videos}">
            <c:forEach var = "link" items = "${pag.videos}"><c:if test = "${!link.flash}">
        pfmedias[indexmedia++] = ['video', "<c:out value='${i.index+1}'/>", "<c:out value="${link.x}"/>", "<c:out value="${link.y}"/>", "<c:out value="${link.width}"/>", "<c:out value="${link.height}"/>", "<c:out value="${link.video.video}"/>", "<c:out value="${link.percentualX}"/>", "<c:out value="${link.percentualY}"/>", "<c:out value="${link.id}"/>", "<c:out value="${link.pagina.width}"/>", "<c:out value="${link.pagina.height}"/>", "<c:out value='${link.label}' escapeXml='true'/>", "V", "<c:out value='${link.icone}'/>"];
                </c:if></c:forEach></c:if>
        <c:if test = "${!empty pag.medias}">
            <c:forEach var = "link" items = "${pag.medias}">
        pfmedias[indexmedia++] = ['audiopicture', "<c:out value='${i.index+1}'/>", "<c:out value="${link.x}"/>", "<c:out value="${link.y}"/>", "<c:out value="${link.width}"/>", "<c:out value="${link.height}"/>", "<c:out value="${link.media.media}"/>", "<c:out value="${link.percentualX}"/>", "<c:out value="${link.percentualY}"/>", "<c:out value="${link.id}"/>", "<c:out value="${link.pagina.width}"/>", "<c:out value="${link.pagina.height}"/>", "<c:out value='${link.label}'/>", "<c:out value='${link.media.tipo}'/>", "<c:out value='${link.icone}'/>"];
            </c:forEach></c:if>
        <c:if test = "${!empty pag.galerias}"><c:forEach var = "link" items = "${pag.galerias}">
                <c:if test = "${!empty link.galeria.galeria}">
        pfmedias[indexmedia++] = ['gallery', "<c:out value='${i.index+1}'/>", "<c:out value="${link.x}"/>", "<c:out value="${link.y}"/>", "<c:out value="${link.width}"/>", "<c:out value="${link.height}"/>", "<c:out value='${link.galeria.cd}'/>", "<c:out value="${link.percentualX}"/>", "<c:out value="${link.percentualY}"/>", "<c:out value="${link.id}"/>", "<c:out value="${link.pagina.width}"/>", "<c:out value="${link.pagina.height}"/>", "<c:out value='${link.galeria.nome}'/>", "G", "<c:out value='${link.icone}'/>","<c:out value='${link.galeria.skin}'/>"];
                    <c:forEach var = "pic" items = "${link.galeria.galeria}">
        pfmediaspics[indexpic++] = ['pic', '<c:out value="${link.galeria.cd}"/>', '<c:out value="${pic.media}"/>', '<c:out value="${pic.nome}"/>']
                    </c:forEach>
                </c:if>
            </c:forEach></c:if>

    </c:forEach>
</script>
<link rel="stylesheet" href="<%= base %>flip/jornal/skins/mobileNovo/css/style.css">
<script type="text/javascript" src="<%= base%>flip/jornal/js/html5lightbox.js"></script>
<script type="text/javascript" src="<%= base%>flip/jornal/plugin/videoBox<fmt:message key='site.idioma'/>.js"></script>
<script type="text/javascript" src="<%= base%>flip/jornal/skins/html5full/flare/darkbox.js" ></script>
<script type="text/javascript" src="<%= base%>flip/jornal/skins/mobileNovo/js/iscroll.js"></script>
<script type="text/javascript" src="<%= base%>flip/jornal/skins/mobileNovo/js/iscroll-zoom.js"></script>
<script src="<%= base%>flip/jornal/skins/mobileNovo/js/script.js"></script>
    </head>
    <body>

        <div id='wrapper'>

    <div id="scroller">
        <ul id="thelist">
            <c:forEach var="pag" items="${paginaslist}" varStatus="i">
                <li id="pag<c:out value='${i.index}'/>" class="anch<c:out value='${pag.id}'/>">
                    <span id="empty" class="loadimg"></span>
                </li>
            </c:forEach>
        </ul>
    </div>


        </div>


    </body>
</html>
