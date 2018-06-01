package com.team9.controllers;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.team9.bo.IdVerifier;
import com.team9.bo.Sale;
import com.team9.dao.DatabaseHandler;
import com.team9.interfaces.ConstantVariables;
import com.team9.vo.CustomerDetail;

@Controller
@SessionAttributes({ "SessionCustomerDetail", "SessionItemPrice" })
public class OnlyTheBestVan {

	Sale currentSale;

	@RequestMapping(value = "/showHome.go")
	public String showHome() {
		// Show home page.
		return "home";
	}

	@RequestMapping(value = "/showVerificationForm.go")
	public ModelAndView showVerificationForm(@ModelAttribute("customerDetail") CustomerDetail customerDetail) {
		// Show verification page.
		ModelAndView modelAndView = new ModelAndView("verificationForm");
		modelAndView.addObject("customerDetail", new CustomerDetail());

		return modelAndView;
	}

	@RequestMapping(value = "/verifyId.go")
	public ModelAndView verifyId(@Valid @ModelAttribute("customerDetail") CustomerDetail customerDetail,
			BindingResult bindingResult) {
		// Verify customer id with the database.
		ModelAndView modelAndView = null;

		if (bindingResult.getErrorCount() == 2) {
			// If any error, then redirect the same page with id.
			modelAndView = new ModelAndView("verificationForm");
			return modelAndView;
		}
		IdVerifier idVerifier = new IdVerifier();
		CustomerDetail customerDetail2 = idVerifier.verifyId(customerDetail.getCustomerId());
		if (customerDetail2 == null) {
			// If customer doesn't exist, the let him register.
			modelAndView = new ModelAndView("redirectToRegisterForm");
		} else {
			// If customer exists then go for item selection with displaying the
			// remaining limit.
			modelAndView = new ModelAndView("displayCustomerDetail");
			modelAndView.addObject("SessionCustomerDetail", customerDetail2);
		}
		return modelAndView;
	}

	@RequestMapping(value = "/showRegistrationForm.go")
	public ModelAndView showRegistrationForm() {
		// Display registration page.
		ModelAndView modelAndView = new ModelAndView("registerationForm");
		modelAndView.addObject("customerDetail", new CustomerDetail());
		return modelAndView;
	}

	@RequestMapping(value = "/registerCustomer.go")
	public ModelAndView registerCustomer(@Valid @ModelAttribute("customerDetail") CustomerDetail customerDetail,
			BindingResult bindingResult) {
		// New Customer registration handling
		ModelAndView modelAndView = null;
		if (bindingResult.hasErrors()) {
			// if any field is empty, then redirection with errors.
			modelAndView = new ModelAndView("registerationForm");
			return modelAndView;
		}
		customerDetail.setRemainingLimit(ConstantVariables.MAX_LIMIT);
		modelAndView = new ModelAndView("verificationForm");

		// Record insertion into the database.
		DatabaseHandler databaseHandler = new DatabaseHandler();
		databaseHandler.insertCustomerRecord(customerDetail);
		return modelAndView;
	}

	@RequestMapping(value = "/makeNewSale.go")
	public ModelAndView makeNewSale() {
		// creates the new instance of Sale for each transaction.
		currentSale = Sale.getInstance();
		ModelAndView modelAndView = new ModelAndView("itemList");
		return modelAndView;
	}

	@RequestMapping(value = "/enterItem.go")
	public ModelAndView enterItem(@RequestParam String itemId,
			@ModelAttribute("SessionCustomerDetail") CustomerDetail customerDetail) {
		// Adding the item into the current sale.
		ModelAndView modelAndView = null;
		double itemPrice = currentSale.enterItem(itemId);
		if (itemPrice > customerDetail.getRemainingLimit()) {
			// If selected itemPrice is greater than limit remaining
			// then ask for again selection page with errors.
			modelAndView = new ModelAndView("itemList");
			modelAndView.addObject("errorMessage",
					"Opps. you exceeded your limit.<br/> Please select below under limit.");
			return modelAndView;
		}
		modelAndView = new ModelAndView("endSale");
		modelAndView.addObject("SessionItemPrice", itemPrice);

		return modelAndView;
	}

	@RequestMapping(value = "/endSale.go")
	public ModelAndView endSale(@ModelAttribute("SessionItemPrice") double itemPrice, Model model) {
		// Ending the sale
		double itemAmount = currentSale.endSale(itemPrice);
		return showPaymentOption(itemAmount, model);
	}

	@RequestMapping(value = "/showPaymentOption.go", method = RequestMethod.POST)
	public ModelAndView showPaymentOption(@ModelAttribute("itemAmount") double itemAmount, Model model) {
		// Show payment option page.
		model.addAttribute("itemAmount", itemAmount);
		ModelAndView modelAndView = new ModelAndView("paymentOption");
		return modelAndView;
	}

	@RequestMapping(value = "/makePayment.go")
	public ModelAndView makePayment(HttpServletRequest request,
			@ModelAttribute("SessionCustomerDetail") CustomerDetail customerDetail,
			@ModelAttribute("SessionItemPrice") double itemPrice, HttpSession session) {
		// Payment Handling
		ModelAndView modelAndView = null;
		String method = request.getParameter("method");
		double itemAmount = Double.parseDouble(request.getParameter("itemAmount"));
		if (method == null) {
			// If no payment method selected then redirect to the same page.
			modelAndView = new ModelAndView("paymentOption");
			modelAndView.addObject("errorMessage", "Please select the payment method.");
			modelAndView.addObject("itemAmount", itemAmount);
			return modelAndView;
		}

		double changeAmount = 0;
		String status = null;
		modelAndView = new ModelAndView("success");
		modelAndView.addObject("method", method);
		if (method.equals("cash")) {
			// Cash payment success
			double cash = Double.parseDouble(request.getParameter("cash"));
			changeAmount = currentSale.makePayment(itemAmount, cash);
			modelAndView.addObject("changeAmount", changeAmount);
		} else if (method.equals("card")) {
			// Card payment success
			String ccnumber = request.getParameter("ccnumber");
			status = currentSale.makePayment(itemAmount, ccnumber);
			modelAndView.addObject("status", status);
		}

		if (changeAmount != 0 && changeAmount == -1) {
			// If payment went failed because of insufficient fund.
			modelAndView = new ModelAndView("paymentOption");
			modelAndView.addObject("errorMessage", "Please provide sufficient cash.");
			modelAndView.addObject("itemAmount", itemAmount);
			return modelAndView;
		}
		if (status != null && !status.equals("valid")) {
			// If card payment went fail.
			modelAndView = new ModelAndView("paymentOption");
			modelAndView.addObject("errorMessage", "Please provide correct card information.");
			modelAndView.addObject("itemAmount", itemAmount);
			return modelAndView;
		}
		// At last, decrease the remaining limit by current purchased item
		// price.
		DatabaseHandler databaseHandler = new DatabaseHandler();
		databaseHandler.updateRemainingLimit(customerDetail.getCustomerId(), itemPrice);
		session.invalidate();
		return modelAndView;
	}
}