<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%
            String edicao = request.getParameter("edicao");
            br.com.maven.flip.javasql.FlipPromocaoTbl promocao = br.com.maven.flip.javasql.dao.FlipPromocaoDAO.getPromocao(Integer.parseInt(edicao));
            if (promocao != null) {
                request.setAttribute("promocao", promocao);
%>
<div id="box650_440">
    <h2> <c:out value="${promocao.nome}"/> </h2>

    <form method="POST" action="#" name="promocaoForm" id="promocaoForm" onsubmit="return validatePromocao(frm)">
        <input type="hidden" name="edicao" value="<%= edicao%>"/>
        <input type="hidden" name="promocao"  value="<c:out value='${promocao.id}'/>"/>

        <p>
        <c:out value="${promocao.descricao}" escapeXml="false"/>
        </p>

        <table width="500px" align="left" border="0" cellpadding="3px" cellspacing="1px">
            <tr>
                <td class="TextoPreto" colspan="4">Todos os campos são obrigatórios</td>
            </tr>
            <tr>
                <td   class="TextoPreto">
                    Seu Nome *
                </td>
                <td   class="TextoPreto">
                    Seu e-mail *
                </td>
            </tr>
            <tr>
                <td >
                    <input type="text" name="nome" id="nomeId" value="" size="40" maxlength="150"  class="CampoTexto"/>
                </td>
                <td >
                    <input type="text" name="email" id="emailId" value="" size="36" maxlength="250"  class="CampoTexto" />
                </td>
            </tr>
            <tr>
                <td   class="TextoPreto">
                    Cidade/Estado *
                </td>
                <c:if test="${promocao.tipo eq 'P'}">
                     <td   class="TextoPreto">
                    Telefone *
                </td>
                </c:if>
            </tr>
            <tr>
                <td >
                    <input type="text" name="cidade" id="cidadeId" value="" size="36" maxlength="100"  class="CampoTexto" />
                </td>
                <c:if test="${promocao.tipo eq 'P'}">
                <td >
                    <input type="text" name="telefone" id="telefoneId" value="" size="15" maxlength="50"  class="CampoTexto"/>
                </td>
                </c:if>
            </tr>
            <c:if test="${promocao.tipo eq 'P'}">
            <tr>
                <td   class="TextoPreto">
                    Mensagem *
                </td>
            </tr>
            <tr>
                <td  colspan="4">
                    <textarea name="mensagem" id="mensagemId" cols="84" rows="6" class="CampoTexto"></textarea>
                </td>
            </tr>
            </c:if>
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="4">
            <c:choose>
                <c:when test="${promocao.tipo eq 'P'}">
                    <input type="button" name="submit" value="Enviar dados!" size="" class="BotaoBranco" onclick="participaPromocao();"/>
                    <input type="button" name="button" value="Não quero participar" size="" class="BotaoBranco" onclick="fechaTela();"/>
                </c:when>
                <c:otherwise>
                    <input type="button" name="submit" value="Cadastrar-se" size="" class="BotaoBranco" onclick="participaPromocao();"/>
                    <input type="button" name="button" value="Cancelar" size="" class="BotaoBranco" onclick="fechaJanela();"/>
                </c:otherwise>
            </c:choose>                    
                </td>
            </tr>
            <c:if test="${promocao.tipo eq 'P'}">
            <tr>
                <td colspan="4">
                    <span> * Essa promoção finaliza em <c:out value="${promocao.dataFinalFormatada}"/></span>
                </td>
            </tr>
            </c:if>
        </table>
    </form>

</div>

<% }%>

