<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="/views/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Redirection</title>
<link href="<c:url value="/assets/css/main.css" />" rel="stylesheet">
</head>
<body>
	<fieldset>
		<h1>Customer not found, so adding new customer...</h1>
		After 5 seconds, page will be automatically directed to registration
		page. <br /> 
		<a href="/Team9Final/showRegistrationForm.go">Click here to go manually.</a>
		<script>
			var timer = setTimeout(function() {
				window.location = 'showRegistrationForm.go'
			}, 5000);
		</script>
	</fieldset>
</body>
</html>

<%@include file="/views/footer.html"%>