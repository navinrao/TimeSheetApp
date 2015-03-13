<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="javax.swing.*" %>
<%
	String confirm = "Are you sure?";
	//int mc= JOptionPane.WARNING_MESSAGE;
	//JOptionPane.showInputDialog(null, confirm, "End Session", mc);
 	//session.setAttribute("UserName", null);
	//session.invalidate();
	//response.sendRedirect("login.jsp");
	
	
	//handles dialog box.
	String selection[] ={"OK", "NO"};
	int status = JOptionPane.showOptionDialog(null, confirm, "End Session", JOptionPane.YES_NO_OPTION, JOptionPane.WARNING_MESSAGE, null, selection, selection[0]);
	if(status==JOptionPane.OK_OPTION)
	{
	 	session.setAttribute("UserName", null);
		session.invalidate();
		response.sendRedirect("login.jsp");
	}
	else
	{
		response.sendRedirect("welcome.jsp");
	}
	
	
	
	
	
	
%>
