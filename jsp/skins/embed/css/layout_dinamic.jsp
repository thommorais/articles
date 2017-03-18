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
body{
font-family:<c:out value="${prefs_temp.fonte}"/>;
color: #<c:out value="${prefs_temp.dataColorCorpo}"/>;
background:transparent;
}

#top { /* pega toda a área do topo */
background: transparent;
color: #<c:out value="${prefs_temp.dataColorCorpo}"/>;
}
#jornal{
padding-top: <c:out value="${prefs_temp.alturaEspaco}"/>px;
}

<%
            session.removeAttribute("prefs_temp");
            session.removeAttribute("KEY_BACKGROUND");
%>