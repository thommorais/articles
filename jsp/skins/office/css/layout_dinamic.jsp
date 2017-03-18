<%@page contentType="text/css" %>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%

            String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request) + "flip/jornal/";

            if (session.getAttribute("prefs_temp") == null) {
                session.setAttribute("prefs_temp", new br.com.maven.flip.javasql.FlipPreferenceTbl());
            }
%>


body, html {
background: #<c:out value="${prefs_temp.background}"/> <c:if test="${!empty prefs_temp.backgroundImageCss && 'NULO' ne prefs_temp.backgroundImageCss}">url(<%= base%><c:out value="${prefs_temp.backgroundImageCss}"/>) repeat fixed</c:if>;
font-family:<c:out value="${prefs_temp.fonte}"/>;
color: #<c:out value="${prefs_temp.dataColorCorpo}"/>;
}

#top { /* pega toda a área do topo */

background: #<c:out value="${prefs_temp.backgroundTop}"/> <c:if test="${!empty prefs_temp.backgroundImageTopCss && 'NULO' ne prefs_temp.backgroundImageTopCss}">url(<%= base%><c:out value="${prefs_temp.backgroundImageTopCss}"/>) repeat-x </c:if>;
}

#data {
color: #<c:out value="${prefs_temp.dataColor}"/>;
}

#topnav {
color: #<c:out value="${prefs_temp.dataColorCorpo}"/>;
}

a.tab { /* tabs superior esquerda */
color: #<c:out value="${prefs_temp.dataColorCorpo}"/>;
background: url(<%= base %>images/<c:out value="${prefs_temp.corPadrao}"/>/b_botao_fundo.png) no-repeat;
}

a.tab2 { /* tabs superior esquerda */
color: #<c:out value="${prefs_temp.dataColorCorpo}"/>;
background: url(<%= base %>images/<c:out value="${prefs_temp.corPadrao}"/>/b_botao_fundo.png) no-repeat;
}

input.saltar {
color: #<c:out value="${prefs_temp.dataColorCorpo}"/>;
}

#navcenter {
background: url(<%= base %>images/<c:out value="${prefs_temp.corPadrao}"/>/back_nav.png) no-repeat top;
}

<%
//session.removeAttribute("prefs_temp");
%>