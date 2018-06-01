<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@include file="/views/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Success</title>
<link href="<c:url value="/assets/css/main.css" />" rel="stylesheet">
</head>
<body>
	<fieldset>
		<div align="center">
			<h1>Payment made successfully.</h1>
			<c:choose>
				<c:when test="${method == 'cash'}">
					<p>
						Change is:
						<c:out value="${changeAmount}" />
					<p>
				</c:when>
				<c:when test="${method == 'card'}">
					<p>Your card has been charged.
					<p>
				</c:when>
			</c:choose>
		</div>
	</fieldset>
</body>
</html>

<%@include file="/views/footer.html"%>