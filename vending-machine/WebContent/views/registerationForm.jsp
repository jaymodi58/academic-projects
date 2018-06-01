<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@include file="/views/header.jsp"%>
<html>
<head>
<title>VerificationForm</title>
<link href="<c:url value="/assets/css/main.css" />" rel="stylesheet">
</head>
<body>
	<div>
		<form:form modelAttribute="customerDetail" method="post"
			action="registerCustomer.go">

			<fieldset>
				<legend align="center">
					<font size="5px"><b>Customer Registration</b></font>
				</legend>
				<table>
					<tr>
						<td><form:label path="customerId">Customer Id# : </form:label></td>
						<td><form:input path="customerId" /></td>
						<td><form:errors path="customerId" cssClass="error"/></td>
					</tr>
					<br/>
					<tr>
						<td><form:label path="name">Name : </form:label></td>
						<td><form:input path="name" /></td>
						<td><form:errors path="name" cssClass="error" /></td>
					</tr> 
					<tr>
						<td colspan="2" align="center"><input type="submit"
							value="Submit" /></td>
					</tr>
				</table>
			</fieldset>
		</form:form>
	</div>
</body>
</html>

<%@include file="/views/footer.html"%>
