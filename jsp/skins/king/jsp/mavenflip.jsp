<%
String edicao = request.getParameter("idEdicao");
String url = br.com.maven.flip.util.zip.ZipUtil.downloadPdf(request,response,Integer.parseInt(edicao));

response.sendRedirect(url);
%>