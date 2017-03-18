<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>

<div class="modal-bg"></div>
<div class="padding"> <a class="btn-fechar" href="javascript:void(0);" onClick="fecharComentar()"><i class="fa fa-times" aria-hidden="true"></i></a>
    <p class="titulo">COMENTAR</p>
    <p class="pergunta"><fmt:message key= 'site.qualpagina'/></p>


    <form method="POST" action="#" name="comentaForm" id="comentaForm" accept-charset="ISO-8859-1">
        <input type="hidden" name="edicao" value="<%= request.getParameter("idEdicao")%>"/>
        <input type="hidden" name="pagina_anchor" id="pagina_anchor" value=""/>
        <input type="hidden" name="comentario"  value="true"/>


<p class="edicao duplo">
    <%
        Object email = request.getSession().getAttribute("username");
        String emailtxt = "";
        if (email != null) {
            emailtxt = email.toString();
        }

        String base = br.com.maven.flip.util.UrlBaseUtil.getUrlBase(request);
        String anchorId = request.getParameter("idForm");
        anchorId = anchorId.replaceAll("anch", "");
        String edicao = request.getParameter("idEdicao");
        boolean markup = "true".equals(request.getParameter("markup"));
        java.util.List<String[]> list = br.com.maven.flip.util.ImpressaoPaginas.readImages(anchorId, edicao, request);

        for (String[] string : list) {
            String bigImage = string[0];
            String image = string[1];
            String id = string[3];
    %>

    <a class="btn" href="javascript:void(0);" onClick="marcarParaComentar(this, <%= id%>);">
        <input type="hidden" name="selecaoComentar-<%= id%>" id="selecaoComentar-<%= id%>" value="0" />
        <i class="fa fa-check" aria-hidden="true"></i> 
        <img src="<%= base + image%>" height="129" /> 
    </a>              
    <% }%>

</p>
<div class="clear"></div>
<div class="comentario">
    <p class="col linha"> <span>Nome*</span>
        <input type="text" name="nome" id="nomeId" value="<%= emailtxt%>" />
    </p>
    <p class="col linha"> <span>E-mail*</span>
        <input type="text" name="email" id="emailId" value="<%= emailtxt %>" />
    </p>
    <p class="col linha"> <span>Seu comentário para o editor*</span>
        <textarea name="mensagem" id="mensagem"></textarea>        
    </p>
    <div class="clear"></div>
    <a class="btn-modal" href="javascript:void(0);" onclick="comentaPagina();">Enviar</a> 
    <a class="btn-modal" href="javascript:void(0);" onclick="fechaJanela();">Cancelar</a> 
    <span class="obrigatorios">* Campos obrigatórios</span> 
</div>
<div class="clear"></div>

    </form>
</div>