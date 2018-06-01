<%@page import="com.team9.vo.CustomerDetail"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@include file="/views/header.jsp"%>
<html>
<head>
<title>CustomerDetail</title>
<link href="<c:url value="/assets/css/main.css" />" rel="stylesheet">
</head>
<body>
	<%
		CustomerDetail SessionCustomerDetail = (CustomerDetail) session.getAttribute("SessionCustomerDetail");
	%>
	<div>
		<fieldset>
			<legend align="center">
				<font size="5px"><b>Customer Detail</b></font>
			</legend>
			<table>
				<tr>
					<td>Customer Id# : </td>
					<td><c:out value="${SessionCustomerDetail.getCustomerId()}" /></td>
				</tr>
				<tr>
					<td>Name : </td>
					<td><c:out value="${SessionCustomerDetail.getName()}" /></td>
				</tr>
				<tr>
					<td>Remaining Limit :</td>
					<td><c:out value="${SessionCustomerDetail.getRemainingLimit()}" /></td>
				</tr>
			</table>
			<a href="/Team9Final/makeNewSale.go">Click here for new sale...</a>
		</fieldset>
	</div>	
</body>
</html>

<%@include file="/views/footer.html"%>