<%@page import="com.sun.java.swing.plaf.windows.resources.windows"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="javax.swing.*" %>
<%

	String confirm = "Are you sure?";
	JOptionPane option = new JOptionPane(confirm, JOptionPane.PLAIN_MESSAGE ,JOptionPane.YES_OPTION);
	JDialog dia = option.createDialog(null, "Log Out");
	dia.setAlwaysOnTop(true);
	dia.show();
	if(option.equals(JOptionPane.YES_OPTION));
	{
	 	
		session.invalidate();
		
		response.sendRedirect("login.jsp");
	}
	
	
%>
