<%
    String link = request.getParameter("ref");
    String suser = request.getParameter("user");
    Object user = session.getAttribute("username");
    request.getSession().removeAttribute("backlink");
    request.getSession().removeAttribute("username");
    request.getSession().removeAttribute("logado");
    request.getSession().removeAttribute("SUBSCRIPTION_DAYS");
    request.getSession().removeAttribute("username_remoto");
    request.getSession().removeAttribute("accesslink");
    request.getSession().removeAttribute("permissions");

    try {
        String logoutLink = (String) session.getAttribute("redirect_logout");
        if (logoutLink != null) {
            link = logoutLink;
        }
        session.invalidate();
    } catch (Exception ex) {
    }

    if (user == null) {
        user = suser;
    }

    if (user != null) {
        br.com.maven.flip.listener.MavenflipSessionListener.removeUser(user.toString(), session.getId());
    }

    if (link != null) {
        response.sendRedirect(link);
    } else {
        response.sendRedirect("index.jsp");
    }
%>