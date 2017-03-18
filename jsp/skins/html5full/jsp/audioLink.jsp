<%@ page language="java" pageEncoding="iso-8859-1"%>
<%
    String audiourl = request.getParameter("audiourl");
    try {
        String link = audiourl;
%>
<html>
    <body>

        <audio autoplay controls>
            <source src="<%= link%>" type="audio/mpeg">
            Your browser does not support the audio element.
        </audio>

    </body>
</html>
<%
    } catch (Exception e) {
        br.com.maven.flip.Logger.logStackTrace(e);
    }
%>
