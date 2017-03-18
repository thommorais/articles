<%@ page language="java" pageEncoding="iso-8859-1"%>
<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%
            String voto = request.getParameter("opcao");
            if (voto != null && voto.length() > 0) {
                br.com.maven.flip.javasql.dao.FlipEnqueteDAO.vota(voto, request);
            }
%>

<c:if test="${!empty result}">
    <div id="pool_itens">
        <span >
            Voto computado com sucesso!
        </span>
        <p>
            Resultados parciais:
        </p>
        <table>           
            <tbody>
                <c:forEach var="opcao" items="${result}">
                    <tr>
                        <td>
                            <c:out value="${opcao.opcao}"/>
                        </td>
                        <td>
                            <strong style="width:<c:out value="${opcao.votosPercent}"/>%" class="result_strong">
                                <c:out value="${opcao.votosPercent}"/>%
                            </strong>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <input type="button" class="BotaoBranco" value="Fechar" onclick="fechaJanela();"/>

    </div>
</c:if>