<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>

<li class="indice" title="filtro">
    &nbsp; &nbsp;
    <a href="#">Filtrar por:</a> <input type="text" name="filter" id="filter" value="" size="30" class="CampoTexto"/>
</li>
<%
            String edicaoId = request.getParameter("edicao");
            java.util.List<br.com.maven.flip.util.comments.CommentsBean> list = br.com.maven.flip.util.comments.CommentsUtil.getListCommentsUsuario(null, edicaoId, request);
            String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
            if (list != null && !list.isEmpty()) {
                for (br.com.maven.flip.util.comments.CommentsBean bean : list) {

%>

<li class="indice" title="<%= bean.getComentario()%>" >
    <span class="dock_icone">&raquo;</span>
    <a href="#" onclick="freelock=true;abrePaginaIndice('anch<%= bean.getPagina()%>',<%= bean.getOrdem()%>,'<%= bean.getComentario()%>','<%= bean.getCoord()%>');">
        <%= bean.getData()%>  - Página <%= bean.getOrdem() %> -  <%= bean.getComentario()%>
    </a>
    <% if(bean.isMeu()){%>
    <span><img src="<%= base%>flip/jornal/images/cross.png" style="padding:0px;margin:0px;" onclick="apagaComentario(<%= bean.getId()%>);"/></span>
    <%} else{ %>
    <span><i>Feito por: <%= bean.getRemetente()%></i></span>
    <%}%>

</li>
<%
                }
            } else {%>
<h2> Nenhuma nota encontrada! </h2>
<%}%>