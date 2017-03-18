<%
String edicao = request.getParameter("idEdicao");
System.out.println(br.com.maven.flip.util.zip.ZipUtil.downloadPdf(request,response,Integer.parseInt(edicao)));
%>