<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<c:if test='${!empty param.link}'>
    <c:set var='conteudourl' value='${param.link}'/>
</c:if>
<c:if test='${!empty param.titulo}'>
    <% String titulo = java.net.URLEncoder.encode(request.getParameter("titulo"),"UTF-8").replace("+","%20");    
    pageContext.setAttribute("conteudotitulo",titulo);
    %>        
</c:if>
<c:if test='${!empty param.foto}'>
    <c:set var='conteudofoto' value='${param.foto}'/>
</c:if>
<c:if test='${!empty param.chamada}'>   
     <% String chamada = java.net.URLEncoder.encode(request.getParameter("chamada"),"UTF-8").replace("+","%20");    
    pageContext.setAttribute("conteudochamada",chamada);
    %>    
</c:if>
<c:if test='${!empty param.size}'>
    <c:set var='conteudosize' value='${param.size}'/>
</c:if>
<div class="rssb-container">
    <ul class="rrssb-buttons clearfix header-menu-class">
        <li class="rrssb-facebook  <c:out value='${conteudosize}'/>">                        
            <a href="https://www.facebook.com/sharer/sharer.php<c:if test='${!empty conteudourl}'>?u=<c:out value='${conteudourl}'/></c:if>" class="popup">
                <span class="rrssb-icon"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 29 29"><path d="M26.4 0H2.6C1.714 0 0 1.715 0 2.6v23.8c0 .884 1.715 2.6 2.6 2.6h12.393V17.988h-3.996v-3.98h3.997v-3.062c0-3.746 2.835-5.97 6.177-5.97 1.6 0 2.444.173 2.845.226v3.792H21.18c-1.817 0-2.156.9-2.156 2.168v2.847h5.045l-.66 3.978h-4.386V29H26.4c.884 0 2.6-1.716 2.6-2.6V2.6c0-.885-1.716-2.6-2.6-2.6z"/></svg></span>
                <span class="rrssb-text">facebook</span>
            </a>
        </li>
        <li class="rrssb-twitter <c:out value='${conteudosize}'/>">
            <!-- Replace href with your Meta and URL information  -->
            <a href="https://twitter.com/intent/tweet<c:if test='${!empty conteudotitulo}'>?text=<c:out value='${conteudotitulo}'/>&amp;href=<c:out value='${conteudourl}'/></c:if>"
               class="popup">
                <span class="rrssb-icon"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 28 28"><path d="M24.253 8.756C24.69 17.08 18.297 24.182 9.97 24.62a15.093 15.093 0 0 1-8.86-2.32c2.702.18 5.375-.648 7.507-2.32a5.417 5.417 0 0 1-4.49-3.64c.802.13 1.62.077 2.4-.154a5.416 5.416 0 0 1-4.412-5.11 5.43 5.43 0 0 0 2.168.387A5.416 5.416 0 0 1 2.89 4.498a15.09 15.09 0 0 0 10.913 5.573 5.185 5.185 0 0 1 3.434-6.48 5.18 5.18 0 0 1 5.546 1.682 9.076 9.076 0 0 0 3.33-1.317 5.038 5.038 0 0 1-2.4 2.942 9.068 9.068 0 0 0 3.02-.85 5.05 5.05 0 0 1-2.48 2.71z"/></svg></span>
                <span class="rrssb-text">twitter</span>
            </a>
        </li>
        <li class="rrssb-linkedin <c:out value='${conteudosize}'/>">
            <a href="http://www.linkedin.com/shareArticle?mini=true<c:if test='${!empty conteudotitulo}'>&amp;url=<c:out value='${conteudourl}'/>&amp;title=<c:out value='${conteudotitulo}'/>&amp;summary=<c:out value='${conteudochamada}'/></c:if>" class="popup"><span class="rrssb-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewbox="0 0 28 28">
                        <path d="M25.424 15.887v8.447h-4.896v-7.882c0-1.98-.71-3.33-2.48-3.33-1.354 0-2.158.91-2.514 1.802-.13.315-.162.753-.162 1.194v8.216h-4.9s.067-13.35 0-14.73h4.9v2.087c-.01.017-.023.033-.033.05h.032v-.05c.65-1.002 1.812-2.435 4.414-2.435 3.222 0 5.638 2.106 5.638 6.632zM5.348 2.5c-1.676 0-2.772 1.093-2.772 2.54 0 1.42 1.066 2.538 2.717 2.546h.032c1.71 0 2.77-1.132 2.77-2.546C8.056 3.593 7.02 2.5 5.344 2.5h.005zm-2.48 21.834h4.896V9.604H2.867v14.73z"></path>
                    </svg></span><span class="rrssb-text">linkedin</span>
            </a>
        </li>
        <li class="rrssb-googleplus <c:out value='${conteudosize}'/>">
            <a href="https://plus.google.com/share<c:if test='${!empty conteudourl}'>?url=<c:out value='${conteudourl}'/></c:if>" class="popup"><span class="rrssb-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewbox="0 0 24 24">
                        <path d="M21 8.29h-1.95v2.6h-2.6v1.82h2.6v2.6H21v-2.6h2.6v-1.885H21V8.29zM7.614 10.306v2.925h3.9c-.26 1.69-1.755 2.925-3.9 2.925-2.34 0-4.29-2.016-4.29-4.354s1.885-4.353 4.29-4.353c1.104 0 2.014.326 2.794 1.105l2.08-2.08c-1.3-1.17-2.924-1.883-4.874-1.883C3.65 4.586.4 7.835.4 11.8s3.25 7.212 7.214 7.212c4.224 0 6.953-2.988 6.953-7.082 0-.52-.065-1.104-.13-1.624H7.614z"></path>
                    </svg></span><span class="rrssb-text">google+</span></a>
        </li>
        <c:if test='${!empty conteudofoto}'>
            <li class="rrssb-pinterest <c:out value='${conteudosize}'/>" >
                <a href="http://pinterest.com/pin/create/button/<c:if test='${!empty conteudourl}'>?url=<c:out value='${conteudourl}'/></c:if><c:if test='${!empty conteudofoto}'>&amp;media=<c:out value='${absolute}${conteudofoto}'/></c:if><c:if test='${!empty conteudotitulo}'>&amp;description=<c:out value='${conteudotitulo}'/></c:if>"><span class="rrssb-icon">
                        <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 28 28">
                            <path d="M14.02 1.57c-7.06 0-12.784 5.723-12.784 12.785S6.96 27.14 14.02 27.14c7.062 0 12.786-5.725 12.786-12.785 0-7.06-5.724-12.785-12.785-12.785zm1.24 17.085c-1.16-.09-1.648-.666-2.558-1.22-.5 2.627-1.113 5.146-2.925 6.46-.56-3.972.822-6.952 1.462-10.117-1.094-1.84.13-5.545 2.437-4.632 2.837 1.123-2.458 6.842 1.1 7.557 3.71.744 5.226-6.44 2.924-8.775-3.324-3.374-9.677-.077-8.896 4.754.19 1.178 1.408 1.538.49 3.168-2.13-.472-2.764-2.15-2.683-4.388.132-3.662 3.292-6.227 6.46-6.582 4.008-.448 7.772 1.474 8.29 5.24.58 4.254-1.815 8.864-6.1 8.532v.003z"></path>
                        </svg></span><span class="rrssb-text">pinterest</span></a>
            </li>         
        </c:if>
        <c:if test='${!empty conteudotitulo}'>                
        <li class="rrssb-whatsapp <c:out value='${conteudosize}'/>" ><a href="whatsapp://send?text=<c:out value='${conteudotitulo}'/> <c:out value='${conteudourl}'/>" data-action="share/whatsapp/share" data-href="<c:out value='${conteudourl}'/>"><span class="rrssb-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" width="90" height="90" viewBox="0 0 90 90">
                        <path d="M90 43.84c0 24.214-19.78 43.842-44.182 43.842a44.256 44.256 0 0 1-21.357-5.455L0 90l7.975-23.522a43.38 43.38 0 0 1-6.34-22.637C1.635 19.63 21.415 0 45.818 0 70.223 0 90 19.628 90 43.84zM45.818 6.983c-20.484 0-37.146 16.535-37.146 36.86 0 8.064 2.63 15.533 7.076 21.61l-4.64 13.688 14.274-4.537A37.122 37.122 0 0 0 45.82 80.7c20.48 0 37.145-16.533 37.145-36.857S66.3 6.983 45.818 6.983zm22.31 46.956c-.272-.447-.993-.717-2.075-1.254-1.084-.537-6.41-3.138-7.4-3.495-.993-.36-1.717-.54-2.438.536-.72 1.076-2.797 3.495-3.43 4.212-.632.72-1.263.81-2.347.27-1.082-.536-4.57-1.672-8.708-5.332-3.22-2.848-5.393-6.364-6.025-7.44-.63-1.076-.066-1.657.475-2.192.488-.482 1.084-1.255 1.625-1.882.543-.628.723-1.075 1.082-1.793.363-.718.182-1.345-.09-1.884-.27-.537-2.438-5.825-3.34-7.977-.902-2.15-1.803-1.793-2.436-1.793-.63 0-1.353-.09-2.075-.09-.722 0-1.896.27-2.89 1.344-.99 1.077-3.788 3.677-3.788 8.964 0 5.288 3.88 10.397 4.422 11.113.54.716 7.49 11.92 18.5 16.223 11.01 4.3 11.01 2.866 12.996 2.686 1.984-.18 6.406-2.6 7.312-5.107.9-2.513.9-4.664.63-5.112z"></path>
                    </svg></span><span class="rrssb-text">Whatsapp </span></a>
        </li>
        </c:if>
    </ul>
</div>