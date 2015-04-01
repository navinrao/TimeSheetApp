<%@page import="com.sun.java.swing.plaf.windows.resources.windows"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="javax.swing.*" %>
<%

	String confirm = "Are you sure?";
// 	//handles dialog box.
// 	//String selection[] ={"OK", "NO"};
// 	//int status =  JOptionPane.showOptionDialog(null, confirm, "End Session", JOptionPane.YES_NO_OPTION, JOptionPane.WARNING_MESSAGE, null, selection, selection[0]);
	
	
// 	if(status==JOptionPane.OK_OPTION)
// 	{
// 	 	session.setAttribute("UserName", null);
// 		session.invalidate();
// 		response.sendRedirect("login.jsp");
// 	}
// 	else
// 	{
// 		response.sendRedirect("welcome.jsp");
// 	}
	
	
	
	JOptionPane option = new JOptionPane(confirm, JOptionPane.PLAIN_MESSAGE ,JOptionPane.YES_NO_OPTION);
	JDialog dia = option.createDialog(null, "Log Out");
	dia.setAlwaysOnTop(true);
	dia.show();
	if(option.equals(JOptionPane.YES_OPTION));
	{
	 	session.setAttribute("UserName", null);
		session.invalidate();
		response.sendRedirect("login.jsp");
	}
	
%>
