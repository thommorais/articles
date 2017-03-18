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
font-family:<c:out value="${prefs_temp.fonte}"/>;
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
z-index:1;
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
<%
            session.removeAttribute("prefs_temp");
            session.removeAttribute("KEY_BACKGROUND");
%>