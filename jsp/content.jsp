<%@ taglib uri="/WEB-INF/c" prefix="c" %>
<%
String cd=request.getParameter("cd");
br.com.maven.flip.javasql.FlipConteudoExtraTbl item=br.com.maven.flip.javasql.dao.FlipConteudoExtraDAO.get(cd);
request.setAttribute("item",item);
%>

<!doctype html>
<html amp lang="pt_BR">
    <head>
        <meta charset="iso-8859-1">
        <title><c:out value="${item.nome}" escapeXml="false"/></title>
        <meta name="viewport" content="width=device-width,minimum-scale=1,initial-scale=1">
        <script type="application/ld+json">
                                     {
                                            "@context": "http://schema.org",
                                            "@type": "NewsArticle",
                                            "headline": "<c:out value="${item.nome}" escapeXml="false"/>",
                                            "datePublished": "<c:out value="${item.data}" escapeXml="false"/>"
                                     }
        </script>
        <style amp-custom>
            /* AMP Simple CSS */
            body {
                font-family:Arial, Helvetica, sans-serif;
            }

            #amp-container {
                width:100%;
                background-color:#ffffff;
                text-align:center;
            }

            #amp-header {
                width:100%;
                text-align:center;
            }
            #amp-content {
                margin-left: 10%; 
                margin-right: 10%;
            }
            .amp-title {
                font-size:24px;
                color:#000000;
                font-weight:bolder;
            }
            .amp-date {
                font-size:18px;
                color:#000000;
            }

            .rrssb-buttons {
                box-sizing: border-box;
                font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
                font-size: 12px;
                height: 36px;
                margin: 0;
                padding: 0;
                width: 100%;
            }
            .rrssb-buttons::after {
                clear: both;
            }
            .rrssb-buttons::after, .rrssb-buttons::before {
                content: " ";
                display: table;
            }
            .rrssb-buttons li {
                box-sizing: border-box;
                float: left;
                height: 100%;
                line-height: 13px;
                list-style: outside none none;
                margin: 0;
                padding: 0 2px;
            }
            .rrssb-buttons li.rrssb-facebook a {
                background-color: #306199;
            }
            .rrssb-buttons li.rrssb-facebook a:hover {
                background-color: #244872;
            }
            .rrssb-buttons li.rrssb-linkedin a {
                background-color: #007bb6;
            }
            .rrssb-buttons li.rrssb-linkedin a:hover {
                background-color: #005983;
            }
            .rrssb-buttons li.rrssb-twitter a {
                background-color: #26c4f1;
            }
            .rrssb-buttons li.rrssb-twitter a:hover {
                background-color: #0eaad6;
            }
            .rrssb-buttons li.rrssb-googleplus a {
                background-color: #e93f2e;
            }
            .rrssb-buttons li.rrssb-googleplus a:hover {
                background-color: #ce2616;
            }
            .rrssb-buttons li.rrssb-pinterest a {
                background-color: #b81621;
            }
            .rrssb-buttons li.rrssb-pinterest a:hover {
                background-color: #8a1119;
            }
            .rrssb-buttons li.rrssb-instagram a {
                background-color: #125688;
            }
            .rrssb-buttons li.rrssb-instagram a:hover {
                background-color: #0c3a5b;
            }
            .rrssb-buttons li.rrssb-whatsapp a {
                background-color: #43d854;
            }
            .rrssb-buttons li.rrssb-whatsapp a:hover {
                background-color: #28c039;
            }
            .rrssb-buttons li.rrssb-print a {
                background-color: #8d98a2;
            }
            .rrssb-buttons li.rrssb-print a:hover {
                background-color: #717f8b;
            }
            .rrssb-buttons li a {
                background-color: #ccc;
                border-radius: 2px;
                box-sizing: border-box;
                display: block;
                font-weight: 700;
                height: 100%;
                padding: 11px 7px 12px 27px;
                position: relative;
                text-align: center;
                text-decoration: none;
                text-transform: uppercase;
                transition: background-color 0.2s ease-in-out 0s;
                width: 100%;
            }
            .rrssb-buttons li a .rrssb-icon {
                display: block;
                left: 10px;
                padding-top: 9px;
                position: absolute;
                top: 0;
                width: 10%;
            }
            .rrssb-buttons li a .rrssb-icon svg {
                height: 17px;
                width: 17px;
            }
            .rrssb-buttons li a .rrssb-icon svg path {
                fill: #fff;
            }
            .rrssb-buttons li a .rrssb-text {
                color: #fff;
            }
            .rrssb-buttons li a:active {
                box-shadow: 1px 3px 15px 0 rgba(22, 0, 0, 0.25) inset;
            }
            .rrssb-buttons li.small a {
                padding: 0;
            }
            .rrssb-buttons li.small a .rrssb-icon {
                left: auto;
                margin: 0 auto;
                overflow: hidden;
                position: relative;
                top: auto;
                width: 100%;
            }
            .rrssb-buttons li.small a .rrssb-text {
                visibility: hidden;
            }
            .rrssb-buttons.large-format, .rrssb-buttons.large-format li {
                height: auto;
            }
            .rrssb-buttons.large-format li a {
                backface-visibility: hidden;
                border-radius: 0.2em;
                padding: 8.5% 0 8.5% 12%;
            }
            .rrssb-buttons.large-format li a .rrssb-icon {
                height: 100%;
                left: 7%;
                padding-top: 0;
                width: 12%;
            }
            .rrssb-buttons.large-format li a .rrssb-icon svg {
                height: 100%;
                position: absolute;
                top: 0;
                width: 100%;
            }
            .rrssb-buttons.large-format li a .rrssb-text {
                backface-visibility: hidden;
            }
            .rrssb-buttons.small-format {
                padding-top: 5px;
            }
            .rrssb-buttons.small-format li {
                height: 80%;
                padding: 0 1px;
            }
            .rrssb-buttons.small-format li a .rrssb-icon {
                height: 100%;
                padding-top: 0;
            }
            .rrssb-buttons.small-format li a .rrssb-icon svg {
                height: 48%;
                position: relative;
                top: 6px;
                width: 80%;
            }
            .rrssb-buttons.tiny-format {
                height: 22px;
                position: relative;
            }
            .rrssb-buttons.tiny-format li {
                padding-right: 7px;
            }
            .rrssb-buttons.tiny-format li a {
                background-color: transparent;
                padding: 0;
            }
            .rrssb-buttons.tiny-format li a .rrssb-icon svg {
                height: 70%;
                width: 100%;
            }
            .rrssb-buttons.tiny-format li a:active, .rrssb-buttons.tiny-format li a:hover {
                background-color: transparent;
            }
            .rrssb-buttons.tiny-format li.rrssb-email a .rrssb-icon svg path {
                fill: #0a88ff;
            }
            .rrssb-buttons.tiny-format li.rrssb-email a .rrssb-icon:hover .rrssb-icon svg path {
                fill: #0054a3;
            }
            .rrssb-buttons.tiny-format li.rrssb-facebook a .rrssb-icon svg path {
                fill: #306199;
            }
            .rrssb-buttons.tiny-format li.rrssb-facebook a .rrssb-icon:hover .rrssb-icon svg path {
                fill: #18304b;
            }
            .rrssb-buttons.tiny-format li.rrssb-linkedin a .rrssb-icon svg path {
                fill: #007bb6;
            }
            .rrssb-buttons.tiny-format li.rrssb-linkedin a .rrssb-icon:hover .rrssb-icon svg path {
                fill: #003650;
            }
            .rrssb-buttons.tiny-format li.rrssb-twitter a .rrssb-icon svg path {
                fill: #26c4f1;
            }
            .rrssb-buttons.tiny-format li.rrssb-twitter a .rrssb-icon:hover .rrssb-icon svg path {
                fill: #0b84a6;
            }
            .rrssb-buttons.tiny-format li.rrssb-googleplus a .rrssb-icon svg path {
                fill: #e93f2e;
            }
            .rrssb-buttons.tiny-format li.rrssb-googleplus a .rrssb-icon:hover .rrssb-icon svg path {
                fill: #a01e11;
            }
            .rrssb-buttons.tiny-format li.rrssb-pinterest a .rrssb-icon svg path {
                fill: #b81621;
            }
            .rrssb-buttons.tiny-format li.rrssb-pinterest a .rrssb-icon:hover .rrssb-icon svg path {
                fill: #5d0b11;
            }
            .rrssb-buttons.tiny-format li.rrssb-instagram a .rrssb-icon svg path {
                fill: #125688;
            }
            .rrssb-buttons.tiny-format li.rrssb-instagram a .rrssb-icon:hover .rrssb-icon svg path {
                fill: #061d2e;
            }
            .rrssb-buttons.tiny-format li.rrssb-whatsapp a .rrssb-icon svg path {
                fill: #43d854;
            }
            .rrssb-buttons.tiny-format li.rrssb-whatsapp a .rrssb-icon:hover .rrssb-icon svg path {
                fill: #1f962d;
            }
            .rrssb-buttons li.rrssb-print a .rrssb-icon svg path:nth-child(2) {
                fill: none;
            }
            .columinst-thumb img {
                border-radius: 50%;
                height: 80px;
                width: 80px;
            }
            .right-author {
                background-color: rgba(0, 0, 0, 0.03);
                float: left;
                margin-left: 14px;
                padding: 20px;
                width: 80%;
            }
            .left-author {
                float: left;
                width: 10%;
            }
        </style>
        <style>body {opacity: 0}</style><noscript><style>body {opacity: 1}</style></noscript>
        <script async src="https://cdn.ampproject.org/v0.js"></script>
    </head>
    <body>

        <article id="amp-content">

            <span class="amp-title"><c:out value="${item.nome}" escapeXml="false"/></span>
            <p>
                <span class="amp-date">


                    <time><c:out value="${item.data}" escapeXml="false"/></time>



                </span>
            <p class="center">


            <c:out value="${item.conteudo}" escapeXml="false"/>

        </p>
    </article>
</body>
</html>