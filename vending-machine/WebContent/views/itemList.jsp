<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@include file="/views/header.jsp"%>

<html>
<head>
<title>ItemList</title>
<link href="<c:url value="/assets/css/main.css" />" rel="stylesheet">
<script type="text/javascript">
	function selectItem(itemId) {
		window.location = '/Team9Final/enterItem.go?itemId=' + itemId;
	}
</script>
</head>
<body>
	<fieldset>
		<legend align="center">
			<font size="5px"><b>Item Information</b></font>
		</legend>
		<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
			url="jdbc:mysql://localhost/team9final?useSSL=false" user="root"
			password="root" />

		<sql:query dataSource="${snapshot}" var="result">
		SELECT * from item_description;
	</sql:query>
		<font color="red" size="2"> 
		<i> <%
			 	String errorMessage = (String) request.getAttribute("errorMessage");
			 	if (errorMessage != null) {
			 %> 
			 <%=errorMessage%> 
			 <%	} %>
		</i>
		</font> <br /> <br />
		<table border="1">
			<tr>
				<th>Item Id</th>
				<th>Name</th>
				<th>Price</th>
			</tr>
			<c:forEach var="row" items="${result.rows}">
				<tr>
					<td><c:out value="${row.item_id}" /></td>
					<td><c:out value="${row.item_name}" /></td>
					<td><c:out value="${row.item_price}" /></td>
					<td><input type="button" value="Buy"
						onclick="selectItem('<c:out value="${row.item_id}" />');" /></td>
				</tr>
			</c:forEach>
		</table>

	</fieldset>
</body>
</html>
</body>

<%@include file="/views/footer.html"%>