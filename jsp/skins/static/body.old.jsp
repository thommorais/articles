<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<%
    String base = request.getParameter("base");
    String edicaoId = "" + request.getAttribute("edicaoId");
    
    //FIXO 
    request.setAttribute("ULTIMA_EDICAO","N");
    
%>
<script type="text/javascript">
    var datas=new Array();    
    var index=0;
        <c:forEach var="item" items="${datasEdicoes}">
        var data=new Array();
    data[0]=<c:out value="${item.nr}"/>
        data[1]="<c:out value="${item.data}"/>";
    datas[index]=data; index++;
        </c:forEach>       
</script>    
<div id="tudo">
    <div id="menu">        
        <c:if test="${ULTIMA_EDICAO ne 'S'}">
            <div id="box">
                <div id="title">
                    Edição em flash
                </div>
                <div id="capa" class="miniatura">
                    <ul>
                        <c:forEach var="pag" items="${paginaslist}" varStatus="i">                        
                            <li>
                                <div>
                                    <img src="<%= base%><c:out value='${pag.pathThumb}'/>"  class="miniatura"/>                        
                                </div>                                
                            </li>
                        </c:forEach> 
                    </ul>
                </div>
            </div>
        </c:if>        
        <div id="box">
            <div id="title">
                Edições anteriores
            </div>
            <div id="areapesquisa" style="display:none">
                <div class="labelpesquisa">Pesquisar</div>
                <div class="campospesquisa">
                    <div class="campo1">
                        <input name="textfield" type="text" class="pesquisa_textfield" id="pesquisa_textfield" value="" />  
                    </div>
                    <div class="campo2">
                        <img src="<%= base%>flip/jornal/skins/static/img/iconepesquisa.png"  alt="Pesquisa" class="botaopesquisa"/>
                    </div>
                </div>                                
            </div>
            <div id="calendar">
                <form>
                    <fieldset class="jcalendar">
                        <div class="jcalendar-wrapper">
                            <div class="jcalendar-selects">					 
                                <div id="barraano">
                                    <input name="" type="button" class="multimidia_ano_prev" title="Anterior" />
                                    <input type="text" name="ano" class="multimidia_select jcalendar-select-year" id="multimidia_select" value="2012" read-only/>
                                    <input name="" type="button" class="multimidia_ano_next" title="Próxima" />
                                    <input name="mes" type="hidden" value="" id="mes" />
                                    <input name="day" type="hidden" value="" id="day" value="1"/>
                                </div>
                                <div id="listaanos">
                                    <div class="itemano" id="1">Janeiro até Abril</div>
                                    <div class="itemano" id="5">Maio até Agosto</div>
                                    <div class="itemanolast" id="9">Setembro até Dezembro</div>                                    
                                </div>
                            </div>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
        <div id="boxbaixo">            
            <a href="http://www.camara.gov.br/internet/jornalcamara/default.asp?selecao=expediente"><img src="<%= base%>flip/jornal/skins/static/img/expediente.png"  alt="Expediente"/></a>            
            <a href="http://www2.camara.gov.br/participe/fale-conosco?contexto=jornal"><img src="<%= base%>flip/jornal/skins/static/img/faleconosco.png"  alt="Fale conosco"/></a>            
        </div>
    </div>
    <div id="centro">
        <div id="top">
            <div id="botoes">
                <span id="icone" class="download"><img src="<%= base%>flip/jornal/skins/static/img/download.png" alt="Fazer download"/></span>
                <span id="icone" class="imprimir"><img src="<%= base%>flip/jornal/skins/static/img/imprimir.png"  alt="Imprimir edição"/></span>
                <span id="icone" class="copiar"><img src="<%= base%>flip/jornal/skins/static/img/copiar.png"  alt="Copiar textos"/></span>
                <span id="icone" class="pdf"><img src="<%= base%>flip/jornal/skins/static/img/pdf.png"  alt="Exportar para PDF"/></span>
                <span id="icone" class="pesquisar"><img src="<%= base%>flip/jornal/skins/static/img/procurar.png" alt="Pesquisar"/></span>
                <span id="icone" class="ampliar"><img src="<%= base%>flip/jornal/skins/static/img/ampliador.png"  alt="Ampliar conteúdo"/></span>
                <span id="icone" class="indicar"><img src="<%= base%>flip/jornal/skins/static/img/indicar.png"  alt="Indicar para amigo"/></span>
                <span id="icone" class="comentar"><img src="<%= base%>flip/jornal/skins/static/img/comentar.png"  alt="Comentar"/></span>
            </div>
            <div id="navegador">            
                <div id="multimidia_box">
                    <input name="" type="button" class="multimidia_fr" title="Primeira"  alt="Primeira página"/>
                    <input name="" type="button" class="multimidia_prev" title="Anterior"  alt="Página anterior"/>
                </div>
                <div id="multimidia_box">
                    <input name="textfield" type="text" class="multimidia_textfield" id="multimidia_textfield" value="" />
                </div>	
                <div id="multimidia_box">
                    <input name="" type="button" class="multimidia_next" title="Próxima"  alt="Próxima página"/>
                    <input name="" type="button" class="multimidia_ff" title="Última"  alt="Última página"/>
                </div>            
            </div>
        </div>			
        <div id="leitor">			
            <ul>
                <c:forEach var="pag" items="${paginaslist}" varStatus="i">
                    <li id="anch<c:out value='${pag.id}'/>" class="page<c:out value='${i.index}'/>" style="height:1040px">
                        <div class="zoom">							                            
                            <img src="<%= base%><c:out value='${pag.pathImage}'/>" id="page<c:out value='${i.index}'/>img"/>
                        </div>		
                    </li>                    
                </c:forEach>
            </ul>					
        </div>
        <div id="top">
            <div id="botoes">
                <span id="icone" class="download"><img src="<%= base%>flip/jornal/skins/static/img/download.png" alt="Fazer download"/></span>
                <span id="icone" class="imprimir"><img src="<%= base%>flip/jornal/skins/static/img/imprimir.png"  alt="Imprimir edição"/></span>
                <span id="icone" class="copiar"><img src="<%= base%>flip/jornal/skins/static/img/copiar.png"  alt="Copiar textos"/></span>
                <span id="icone" class="pdf"><img src="<%= base%>flip/jornal/skins/static/img/pdf.png"  alt="Exportar para PDF"/></span>
                <span id="icone" class="pesquisar"><img src="<%= base%>flip/jornal/skins/static/img/pesquisar.png" alt="Pesquisar"/></span>
                <span id="icone" class="ampliar"><img src="<%= base%>flip/jornal/skins/static/img/ampliador.png"  alt="Ampliar conteúdo"/></span>
                <span id="icone" class="indicar"><img src="<%= base%>flip/jornal/skins/static/img/indicar.png"  alt="Indicar para amigo"/></span>
                <span id="icone" class="comentar"><img src="<%= base%>flip/jornal/skins/static/img/comentar.png"  alt="Comentar"/></span>
            </div>
            <div id="navegador">            
                <div id="multimidia_box">
                    <input name="" type="button" class="multimidia_fr" title="Primeira"  alt="Primeira página"/>
                    <input name="" type="button" class="multimidia_prev" title="Anterior"  alt="Página anterior"/>
                </div>
                <div id="multimidia_box">
                    <input name="textfield" type="text" class="multimidia_textfield" id="multimidia_textfield_2" value="" />
                </div>	
                <div id="multimidia_box">
                    <input name="" type="button" class="multimidia_next" title="Próxima"  alt="Próxima página"/>
                    <input name="" type="button" class="multimidia_ff" title="Última"  alt="Última página"/>
                </div>            
            </div>
        </div>                        
    </div>
</div>