<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="/views/header.jsp"%>
<html>
<head>
<title>PaymentOption</title>
<link href="<c:url value="/assets/css/main.css" />" rel="stylesheet">
<script type="text/javascript">
	function selectPaymentOption(method) {
		if (method.value == "card") {
			document.getElementById("ccformContainer").style.visibility = 'visible';
			document.getElementById("cashformContainer").style.visibility = 'hidden';
		} else if (method.value == "cash") {
			document.getElementById("ccformContainer").style.visibility = 'hidden';
			document.getElementById("cashformContainer").style.visibility = 'visible';
		}
	}
</script>
</head>
<body>
	<form action="/Team9Final/makePayment.go" method="post">
		<div>
			<fieldset>
				<legend align="center">
					<font size="5px"><b>Payment Options</b></font>
				</legend>
				Amount Due :
				<c:out value="${itemAmount}" />

				<table>
					<tr>
						<td><input type="radio" name="method" value="cash"
							onclick="selectPaymentOption(this)" />Cash</td>
						<td><input type="radio" name="method" value="card"
							onclick="selectPaymentOption(this)" />Credit/Debit card</td>
						<td>
							<font color="red" size="2"> 
							<i> 
								<%
								 	String errorMessage = (String) request.getAttribute("errorMessage");
									if (errorMessage != null) {
	 							%> 
	 							<%=errorMessage%> 
	 							<%	} %>
							</i>
						</font></td>
					</tr>
				</table>

				<!-- ---------------Card Form---------------------- -->
				<div style="visibility: hidden;" id="ccformContainer">
					<b>Enter your credit card details :</b><br> <br>
					<table>
						<tr>
							<td>Name on card :</td>
							<td><input type="text" id="ccname" name="ccname"></td>
						</tr>
						<tr>
							<td>Credit Card Type :</td>
							<td><select name="cctype" required>
									<option value="Visa" selected="selected">Visa</option>
									<option value="Mastercard">Mastercard</option>
									<option value="American Express">American Express</option>
									<option value="Discover">Discover</option>
									<option value="Diners Club">Diners Club</option>
									<option value="Maestro">Maestro</option>
									<option value="Verified By Visa">Verified By Visa</option>
									<option value="Visa Electron">Visa Electron</option>
							</select></td>
						</tr>
						<tr>
							<td>Card Number :</td>
							<td><input type="number" id="ccnumber" name="ccnumber"></td>
						</tr>
						<tr>
							<td>Credit Expiry Date :</td>
							<td>Month : <select name="ccexpdatemonth" required>
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6</option>
									<option value="7">7</option>
									<option value="8">8</option>
									<option value="9">9</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
							</select> <span>Year : <select name="ccexpdateyear" required>
										<option value="2016">2016</option>
										<option value="2017">2017</option>
										<option value="2018">2018</option>
										<option value="2019">2019</option>
										<option value="2020">2020</option>
										<option value="2021">2021</option>
										<option value="2015">2022</option>
								</select>
							</span></td>
						</tr>
						<tr>
							<td>Credit Card CVC :</td>
							<td><input type="number" id="cccvc" name="cccvc"></td>
						</tr>
					</table>
				</div>

				<!-- ---------------Cash Form---------------------- -->
				<div style="visibility: hidden;" id="cashformContainer">
					<table>
						<tr>
							<td>Enter cash :</td>
							<td><input type="number" id="cash" name="cash" min="1" step="0.01"></td>
					</table>
				</div>
				<br /> <input type="hidden" name="itemAmount" value="${itemAmount}">
				<input type="submit" value="Go..." />
			</fieldset>

		</div>
	</form>
</body>
</html>

<%@include file="/views/footer.html"%>