<%@page contentType="text/css" %>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%
            String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request) + "flip/jornal/";
            br.com.maven.flip.javasql.FlipPreferenceTbl pref = (br.com.maven.flip.javasql.FlipPreferenceTbl) session.getAttribute("prefs_temp");
            if (pref == null || pref.getId() == null || pref.getId() == 0) {
                pref = new br.com.maven.flip.javasql.FlipPreferenceTbl();
                String px = request.getParameter("px");
                if (px != null && px.length() > 0) {
                    Integer prefId = Integer.parseInt(px);
                    pref = br.com.maven.flip.javasql.dao.FlipModeloPublicacaoDAO.getPrefs(prefId);
                    request.setAttribute("prefs_temp", pref);
                }
                session.setAttribute("prefs_temp", pref);
            }
%>
body,html {
min-height: 100%;
height: 100%;
margin: 0;
overflow: hidden;
text-align: center;
}

body{
font-family:<c:out value="${prefs_temp.fonte}" escapeXml="false"/>;
color: #<c:out value="${prefs_temp.dataColorCorpo}"/>;
<c:if test="${empty prefs_temp.effects || prefs_temp.effects ne 'daynight'}">    
    <c:if test="${empty KEY_BACKGROUND && (empty prefs_temp.backgroundImageCss || 'NULO' eq prefs_temp.backgroundImageCss) && empty prefs_temp.tema}">
        background: #<c:out value="${prefs_temp.background}"/>;
    </c:if>
</c:if>
<c:if test="${!empty prefs_temp.effects && prefs_temp.effects eq 'daynight'}">
    background:transparent;
</c:if>        
}
#content{
height: 100%;
<c:if test="${empty prefs_temp.tema && (empty prefs_temp.effects || prefs_temp.effects ne 'daynight')}">
    <c:choose>
        <c:when test="${empty KEY_BACKGROUND}">
            background: #<c:out value="${prefs_temp.background}"/> <c:if test="${!empty prefs_temp.backgroundImageCss && 'NULO' ne prefs_temp.backgroundImageCss}">url(<%= base%><c:out value="${prefs_temp.backgroundImageCss}"/>) center repeat-x</c:if>;
            background-size: 100%;
            background-size: contain;
        </c:when>
        <c:otherwise>
            <c:if test="${KEY_BACKGROUND.repetirX or KEY_BACKGROUND.repetirY}">
                <c:out value="${KEY_BACKGROUND.css}"/>
            </c:if>
        </c:otherwise>
    </c:choose>   
</c:if>  
<c:if test="${!empty prefs_temp.effects && prefs_temp.effects eq 'daynight'}">
    background:transparent;    
</c:if>    
}
#background {
text-align: center;
width: 100%; 
height: 100%; 
position: fixed;
left: 0px; 
top: 0px; 
z-index: -1;
}

.stretch {
margin: auto;
height:100%;
width:100%;
}

#top { /* pega toda a área do topo */
background: #<c:out value="${prefs_temp.backgroundTop}"/> <c:if test="${!empty prefs_temp.backgroundImageTopCss && 'NULO' ne prefs_temp.backgroundImageTopCss}">url(<%= base%><c:out value="${prefs_temp.backgroundImageTopCss}"/>) repeat-x </c:if>;
color: #<c:out value="${prefs_temp.dataColorCorpo}"/>;
<c:if test="${!empty prefs_temp.effects && prefs_temp.effects eq 'daynight'}">
    position:absolute;    
    z-index:999;
</c:if>
}

#jornal{
padding-top: <c:out value="${prefs_temp.alturaEspaco}"/>px;
position: absolute; 
display: block; 
*left:40px;
*top:70px;
width: 100%; 
<c:choose>
    <c:when test="${prefs_temp.pageWidth>prefs_temp.pageHeight}">
        height:<c:out value="${prefs_temp.pageHeight}"/>px;
    </c:when>
    <c:otherwise>
        <c:choose>
            <c:when test="${!empty prefs_temp.htmlTopo}">
                height:88%;
            </c:when>
            <c:otherwise>
                height:98%;
            </c:otherwise>
        </c:choose>        
    </c:otherwise>
</c:choose>
*z-index:0px;
}
#megazine {
height:100%;
width:100%;
display:block;
top:0px;
vertical-align:text-top;
position:relative;
border:none;
vertical-align:top;
float:left;
<!--z-index:1;-->
}
<c:if test="${!empty prefs_temp.effects && prefs_temp.effects eq 'daynight'}">
    #megazineScript{
    position:absolute;
    left:0px;
    top:70px;
    width:100%;
    height:100%;
    z-index:999;
    }
    #multimidia{
    position:absolute;
    z-index:999;
    top:40px;
    }
    #tab_left{
    top:100px;
    z-index:99999;
    }
</c:if>
<c:if test="${prefs_temp.faleConosco && !empty prefs_temp.iconeContato}">
    .menu_contato a { background:url(<%= base%>../../<c:out value="${prefs_temp.iconeContato}"/>) no-repeat center center; width:30px; height:30px; display:block; behavior:url(<%= base%>flip/jornal/sking/king/css/iepngfix.htc); cursor:hand; }
    .menu_contato a:hover { background:url(<%= base%>../../<c:out value="${prefs_temp.iconeContato}"/>) no-repeat center center; width:30px; height:30px; display:block; behavior:url(<%= base%>flip/jornal/sking/king/css/iepngfix.htc); cursor:hand; }    
</c:if>    
<c:if test="${!empty prefs_temp.iconePesquisar}">
    .menu_procurar a { background:url(<%= base%>../../<c:out value="${prefs_temp.iconePesquisar}"/>) no-repeat center center; width:30px; height:30px; display:block; behavior:url(<%= base%>flip/jornal/sking/king/css/iepngfix.htc); cursor:hand; }
    .menu_procurar a:hover { background:url(<%= base%>../../<c:out value="${prefs_temp.iconePesquisar}"/>) no-repeat center center; width:30px; height:30px; display:block; behavior:url(<%= base%>flip/jornal/sking/king/css/iepngfix.htc); cursor:hand; }    
</c:if>  
<c:if test="${prefs_temp.exportar && !empty prefs_temp.iconeExportarPdf}">
    .menu_pdf a { background:url(<%= base%>../../<c:out value="${prefs_temp.iconeExportarPdf}"/>) no-repeat center center; width:30px; height:30px; display:block; behavior:url(<%= base%>flip/jornal/sking/king/css/iepngfix.htc); cursor:hand; }
    .menu_pdf a:hover { background:url(<%= base%>../../<c:out value="${prefs_temp.iconeExportarPdf}"/>) no-repeat center center; width:30px; height:30px; display:block; behavior:url(<%= base%>flip/jornal/sking/king/css/iepngfix.htc); cursor:hand; }    
</c:if>  
<c:if test="${prefs_temp.publicaRecomenda && !empty prefs_temp.iconeRecomendar}">
    .menu_recomendar a { background:url(<%= base%>../../<c:out value="${prefs_temp.iconeRecomendar}"/>) no-repeat center center; width:30px; height:30px; display:block; behavior:url(<%= base%>flip/jornal/sking/king/css/iepngfix.htc); cursor:hand; }
    .menu_recomendar a:hover { background:url(<%= base%>../../<c:out value="${prefs_temp.iconeRecomendar}"/>) no-repeat center center; width:30px; height:30px; display:block; behavior:url(<%= base%>flip/jornal/sking/king/css/iepngfix.htc); cursor:hand; }    
</c:if>  
<c:if test="${prefs_temp.impressao && !empty prefs_temp.iconeImprimir}">
    .menu_imprimir a { background:url(<%= base%>../../<c:out value="${prefs_temp.iconeImprimir}"/>) no-repeat center center; width:30px; height:30px; display:block; behavior:url(<%= base%>flip/jornal/sking/king/css/iepngfix.htc); cursor:hand; }
    .menu_imprimir a:hover { background:url(<%= base%>../../<c:out value="${prefs_temp.iconeImprimir}"/>) no-repeat center center; width:30px; height:30px; display:block; behavior:url(<%= base%>flip/jornal/sking/king/css/iepngfix.htc); cursor:hand; }    
</c:if>  
<c:if test="${prefs_temp.comentarios && !empty prefs_temp.iconeComentar}">
    .menu_comentar a { background:url(<%= base%>../../<c:out value="${prefs_temp.iconeComentar}"/>) no-repeat center center; width:30px; height:30px; display:block; behavior:url(<%= base%>flip/jornal/sking/king/css/iepngfix.htc); cursor:hand; }
    .menu_comentar a:hover { background:url(<%= base%>../../<c:out value="${prefs_temp.iconeComentar}"/>) no-repeat center center; width:30px; height:30px; display:block; behavior:url(<%= base%>flip/jornal/sking/king/css/iepngfix.htc); cursor:hand; }    
</c:if>  
<c:if test="${prefs_temp.modoTexto && !empty prefs_temp.iconeTexto}">
    .menu_texto a { background:url(<%= base%>../../<c:out value="${prefs_temp.iconeTexto}"/>) no-repeat center center; width:30px; height:30px; display:block; behavior:url(<%= base%>flip/jornal/sking/king/css/iepngfix.htc); cursor:hand; }
    .menu_texto a:hover { background:url(<%= base%>../../<c:out value="${prefs_temp.iconeTexto}"/>) no-repeat center center; width:30px; height:30px; display:block; behavior:url(<%= base%>flip/jornal/sking/king/css/iepngfix.htc); cursor:hand; }    
</c:if>  
<c:if test="${!empty prefs_temp.iconeEdicaoAtual}">
    .menu_home a { background:url(<%= base%>../../<c:out value="${prefs_temp.iconeEdicaoAtual}"/>) no-repeat center center; width:30px; height:30px; display:block; behavior:url(<%= base%>flip/jornal/sking/king/css/iepngfix.htc); cursor:hand; }
    .menu_home a:hover { background:url(<%= base%>../../<c:out value="${prefs_temp.iconeEdicaoAtual}"/>) no-repeat center center; width:30px; height:30px; display:block; behavior:url(<%= base%>flip/jornal/sking/king/css/iepngfix.htc); cursor:hand; }    
</c:if>  
<c:if test="${!empty KEY_BANNER_SUPER}"> 
    .free{
    height:450px;
    }
</c:if>    
<c:if test="${!empty prefs_temp.iconeOutrasEdicoes}">
    #dock #edicoes_barra { background-image:url(<%= base %>../../<c:out value="${prefs_temp.iconeOutrasEdicoes}"/>); background-repeat:no-repeat; padding:0; cursor:hand; }
    #dock #edicoes_barra:hover{ background-position:-0px 0px;}
</c:if>
<c:if test="${!empty prefs_temp.iconeIndice}">
    #dock #indice_barra { background-image:url(<%= base %>../../<c:out value="${prefs_temp.iconeIndice}"/>); background-repeat:no-repeat; padding:0; cursor:hand; }
    #dock #indice_barra:hover{ background-position:-0px 0px;}
</c:if>
<c:if test="${!empty prefs_temp.iconeSumario}">
    #dock #sumario_barra { background-image:url(<%= base %>../../<c:out value="${prefs_temp.iconeSumario}"/>); background-repeat:no-repeat; padding:0; cursor:hand; }
    #dock #sumario_barra:hover{ background-position:-0px 0px;}
</c:if>
<c:if test="${empty prefs_temp.effects || prefs_temp.effects ne 'daynight'}">    
    <c:if test="${empty KEY_BACKGROUND && (empty prefs_temp.backgroundImageCss || 'NULO' eq prefs_temp.backgroundImageCss) && empty prefs_temp.tema}">
        #dock{background: #<c:out value="${prefs_temp.background}"/>;}
    </c:if>
</c:if>    
    
<%
            session.removeAttribute("prefs_temp");
            session.removeAttribute("KEY_BACKGROUND");
%>