<%@ taglib uri="/WEB-INF/c" prefix="c" %>

<div class="esq">
    <div class="conteudo" style="margin:0;padding:0">
        <h1 class="categoria">Índice</h1>
        <ul class="categoria">
            <%
            String edicaoId = request.getParameter("idForm");
            java.util.List<br.com.maven.flip.javasql.view.CadernoBean> list = br.com.maven.flip.javasql.dao.FlipPaginaEdicaoDAO.cadernosComComments(Integer.parseInt(edicaoId));
            String base = request.getParameter("base");
            for (br.com.maven.flip.javasql.view.CadernoBean bean : list) {
                String anchor = bean.getAnchor();
            %>
            <li title="Clique aqui para visualizar a página inicial dessa sessão">
                <a href="javascript:void(0)" onclick="MegaZine.gotoAnchor('<%= anchor%>',false);fechaTela(); return false;">
                    <% if (!bean.getChildren().isEmpty()) {%>
                    <b>
                        <% }%>
                        <%= bean.getNome()%>
                        <% if (!bean.getChildren().isEmpty()) {%>
                        (<%= bean.getChildren().size()%>)
                    </b>
                    <% }
                if (bean.isComments()) {
                    %>
                    <img src="<%= base%>flip/jornal/images/postit.png"  alt="Essa página possui comentários" width="13"/>
                    <% }%>

                </a>
                <% if (!bean.getChildren().isEmpty()) {
                %>
                <ul style="padding-left:6px"> <%
     for (br.com.maven.flip.javasql.view.CadernoBean beanFilho : bean.getChildren()) {
         String anchorW = beanFilho.getAnchor();
                    %>
                    <li title="Clique aqui para visualizar a página inicial dessa sessão">
                        <a href="javascript:void(0)" onclick="MegaZine.gotoAnchor('<%= anchorW%>',false);fechaTela(); return false;">
                            <%= beanFilho.getNome()%>
                            <%  if (beanFilho.isComments()) {
                            %>
                            <img src="<%= base%>flip/jornal/images/postit.png"  alt="Essa página possui comentários" width="13"/>
                            <% }%>
                        </a>
                    </li>
                    <%
     }
                    %>
                </ul>
                <% }%>
            </li>
            <%
            }%>
        </ul>
    </div>
</div>