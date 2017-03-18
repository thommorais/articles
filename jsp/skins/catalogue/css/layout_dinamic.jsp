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
html,body{
margin: 0px;
padding: 0px; 
overflow-x:hidden;
}
img:hover{
cursor:pointer;
}
#tudo{
width:100%;
}
.header{
background-color:#28287d;
float:left;
clear:both;
height:30px;
width:100%;
}
.corpo{
width:100%;
clear:both;
float:left;
min-height:auto;
position:relative;
text-align:center;
margin-left: auto ;
margin-right: auto ;
}
.footer{
background-color:#939598;
float:left;
clear:both;
height:30px;
width:100%;
overflow:hidden;
}
.header .titulo{
font: bold 14px <c:out value="${prefs_temp.fonte}"/>, sans-serif;
padding-left:18px;
padding-top:3px;
padding-bottom:3px;
float:left;
color:#<c:out value="${prefs_temp.dataColorCorpo}"/>;
}
.header .fechar{
padding-right:18px;
padding-top:3px;
padding-bottom:3px;
float:right;
}
.header .fechar a{
text-decoration: none;
font: bold 11px <c:out value="${prefs_temp.fonte}"/>, sans-serif;
color:#<c:out value="${prefs_temp.dataColorCorpo}"/>;
}
.header .fechar img{
border:none;
}

.footer .page{
width:20%;
font: bold 11px <c:out value="${prefs_temp.fonte}"/>, sans-serif;
padding-left:18px; 
float:left;
color:#<c:out value="${prefs_temp.dataColorCorpo}"/>;
margin-top:8px;
}

.footer .imprimir{
width:20%;
padding-right:18px;  
float:right;  
display: table-cell;
text-align: right;
vertical-align: middle;
height:30px;
}
.footer .imprimir * {
vertical-align: middle;
}
.footer .imprimir span {
display: inline-block;
height: 100%;
width: 7px;
}

.footer .imprimir a{
text-decoration: none;
font: bold 11px <c:out value="${prefs_temp.fonte}"/>, sans-serif;
color:#<c:out value="${prefs_temp.dataColorCorpo}"/>;
}
.footer.imprimir img{
border:none;  
}
.footer ftools img{
border:none;
}
.footer .ftools a{
text-decoration: none;
font: bold 11px <c:out value="${prefs_temp.fonte}"/>, sans-serif;
color:#<c:out value="${prefs_temp.dataColorCorpo}"/>;
}

.footer .ftools{
width:55%;
float:left; 
text-align:center;
margin-left: auto;
margin-right: auto;
overflow:hidden;
font: bold 11px <c:out value="${prefs_temp.fonte}"/>, sans-serif;
color:#<c:out value="${prefs_temp.dataColorCorpo}"/>;
display: table-cell;
text-align: center;
vertical-align: middle;
height:30px; 
}
.footer .ftools * {
vertical-align: middle;
}
.footer .ftools span {
display: inline-block;
height: 100%;
width: 2px;
}
.corpo .left{
width:1%;
float:left; 
padding-top:15%;
}
.corpo .center{
width:96%;
float:left; 
text-align:center;
padding-top:10px;
padding-bottom:10px;
padding-left:3px;
padding-right:3px;
margin-left: auto ;
margin-right: auto ;
overflow:hidden;
}
.corpo .right{
width:2%;
float:right; 
padding-top:15%;
}
#flip { width:100%; margin:0 auto; padding:1px 0; }
<%
            session.removeAttribute("prefs_temp");
            session.removeAttribute("KEY_BACKGROUND");
%>