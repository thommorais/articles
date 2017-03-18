<%@page contentType="text/css" %>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%

           String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request) + "flip/jornal/";
           
             br.com.maven.flip.javasql.FlipPreferenceTbl pref=(br.com.maven.flip.javasql.FlipPreferenceTbl)session.getAttribute("prefs_temp");
            if (pref == null || pref.getId() == null || pref.getId() == 0) {
                pref = new br.com.maven.flip.javasql.FlipPreferenceTbl();
                String px=request.getParameter("px");
                if(px != null && px.length()>0){
                 Integer prefId=Integer.parseInt(px);
                 pref = br.com.maven.flip.javasql.dao.FlipModeloPublicacaoDAO.getPrefs(prefId);
                 request.setAttribute("prefs_temp",pref);
                 }
                session.setAttribute("prefs_temp",pref);
            }
%>


body, html {
background: #<c:out value="${prefs_temp.background}"/> <c:if test="${!empty prefs_temp.backgroundImageCss && 'NULO' ne prefs_temp.backgroundImageCss}">url(<%= base%><c:out value="${prefs_temp.backgroundImageCss}"/>) repeat fixed</c:if>;
color: #<c:out value="${prefs_temp.dataColorCorpo}"/>;
}

#data, #data_login, #jornal_login {
color: #<c:out value="${prefs_temp.dataColor}"/>;
}

#topnav {        
color: #<c:out value="${prefs_temp.dataColorCorpo}"/>;
}

a.tab { /* tabs superior esquerda */
color: #<c:out value="${prefs_temp.dataColorCorpo}"/>;
background: url(flip/jornal/images/<c:out value="${prefs_temp.corPadrao}"/>/b_botao_fundo.png) no-repeat;
}

a.tab2 { /* tabs superior esquerda */
color: #<c:out value="${prefs_temp.dataColorCorpo}"/>;
background: url(flip/jornal/images/<c:out value="${prefs_temp.corPadrao}"/>/b_botao_fundo.png) no-repeat;
}

input.saltar {    
color: #<c:out value="${prefs_temp.dataColorCorpo}"/>;
}

#navcenter {
background: url(flip/jornal/images/<c:out value="${prefs_temp.corPadrao}"/>/back_nav.png) no-repeat top;
}

<%session.removeAttribute("prefs_temp");%>