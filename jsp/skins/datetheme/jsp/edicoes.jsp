<%@ taglib uri="/WEB-INF/c" prefix="c" %>

<%
            String edicaoId = request.getParameter("idForm");
            String link = request.getParameter("linkedicao");
            String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
            java.util.List<br.com.maven.flip.javasql.view.EdicaoBean> list = br.com.maven.flip.javasql.dao.FlipEdicaoDAO.edicoes(Integer.parseInt(edicaoId), null ,null, 0,null);
            int i = 0;
            for (br.com.maven.flip.javasql.view.EdicaoBean bean : list) {
%>

<li>
    <div
        <% if (bean.getId().intValue() == Integer.parseInt(edicaoId)) {%>
        class="active"
        <% }%>
        >
        <a href="<%= base+link%>/index.jsp?edicao=<%= bean.getId()%>">
            <img src="<%= base + bean.getPath()%>" border="1" alt="Clique para ler" title="Clique para ler" width="50"/>
        </a>
        <p> Data<br/>
            <%= bean.getData()%>
             <p class="download">
                 <a href="<%= base+link%>/index.jsp?edicao=<%= bean.getId()%>">
                     visualizar
                 </a>
             </p>
        </p>
        <br class="clear" />
    </div>
</li>

<%   }%>