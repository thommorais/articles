<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%@ taglib uri="/WEB-INF/fmt" prefix="fmt" %>
<%
    String base = request.getParameter("base");
    String edicaoId = "" + request.getAttribute("edicaoId");
%>
<script type="text/javascript">
    var datas=new Array();    
    var index=0;
    var pages=new Array();
        <c:forEach var="item" items="${datasEdicoes}">var data=new Array();data[0]=<c:out value="${item.nr}"/>;data[1]="<c:out value="${item.data}"/>";datas[index]=data; index++;</c:forEach>
        index=0;
        <c:forEach var="pag" items="${paginaslist}" varStatus="i">
        pages[index++]="<c:out value='${pag.pathImage}'/>";
        </c:forEach>
</script>    
<div id="tudo">
    <div id="menu">                
        <div id="box">
            <div id="title" title="Clique para acessar a versão em flip em flash">
                Versão animada
            </div>
            <div id="capa" class="miniatura"  title="Clique para acessar a versão em flip em flash">
                <img src="<%= base %>flip/jornal/skins/static/img/banner.png"/>
            </div>
        </div>        
        <div id="box">
            <div id="title"  title="Edições anteriores">
                Edições anteriores
            </div>
            <div id="areapesquisa" style="display:none">
                <div class="labelpesquisa">Pesquisar</div>
                <div class="campospesquisa">
                    <div class="campo1">
                        <input name="textfield" type="text" class="pesquisa_textfield" id="pesquisa_textfield" value="" alt="Digite o termo da pesquisa"/>  
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
                                    <input name="" type="button" class="multimidia_fr_ano" title="Primeiro ano" />
                                    <input name="" type="button" class="multimidia_ano_prev" title="Anterior" />
                                    <input type="text" name="ano" class="multimidia_select jcalendar-select-year" id="multimidia_select" value="2012" read-only/>
                                    <input name="" type="button" class="multimidia_ano_next" title="Próxima" />
                                    <input name="" type="button" class="multimidia_ff_ano" title="Último ano" />
                                    <input name="mes" type="hidden" value="" id="mes" />
                                    <input name="day" type="hidden" value="" id="day" value="1"/>
                                </div>
                                <div id="listaanos">
                                    <div class="itemano" id="1" title="Janeiro">Janeiro</div>
                                    <div class="itemano" id="2" title="Fevereiro">Fevereiro</div>
                                    <div class="itemano" id="3" title="Março">Março</div>
                                    <div class="itemano" id="4" title="Abril">Abril</div>
                                    <div class="itemano" id="5" title="Maio">Maio</div>
                                    <div class="itemano" id="6" title="Junho">Junho</div>
                                    <div class="itemano" id="7" title="Julho">Julho</div>
                                    <div class="itemano" id="8" title="Agosto">Agosto</div>
                                    <div class="itemano" id="9" title="Setembro">Setembro</div>
                                    <div class="itemano" id="10" title="Outubro">Outubro</div>
                                    <div class="itemano" id="11" title="Novembro">Novembro</div>
                                    <div class="itemanolast" id="12" title="Dezembro">Dezembro</div>
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
                    <input name="" type="button" class="multimidia_fr" title="Primeira página"  alt="Primeira página"/>
                    <input name="" type="button" class="multimidia_prev" title="Página Anterior"  alt="Página anterior"/>
                </div>
                <div id="multimidia_box">
                    <input name="textfield" type="text" class="multimidia_textfield" id="multimidia_textfield" value="" alt="Digite a página" title="Digite a página"/>
                </div>	
                <div id="multimidia_box">
                    <input name="" type="button" class="multimidia_next" title="Próxima página"  alt="Próxima página"/>
                    <input name="" type="button" class="multimidia_ff" title="Última página"  alt="Última página"/>
                </div>            
            </div>
        </div>			
        <div id="leitor">			
            <ul>
                <c:forEach var="pag" items="${paginaslist}" varStatus="i">
                    <li id="anch<c:out value='${pag.id}'/>" class="page<c:out value='${i.index}'/>" style="height:1040px">
                        <div class="zoom">							                            
                            <img src="<%=base %>/flip/jornal/images/loading_bar.gif" id="page<c:out value='${i.index}'/>img" width="200px"/>
                            <div style="display:none"><c:out value="${pag.texto}"/></div>
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