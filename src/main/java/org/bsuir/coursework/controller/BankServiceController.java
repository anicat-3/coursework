package org.bsuir.coursework.controller;

import org.bsuir.coursework.service.AccountBalanceService;
import org.bsuir.coursework.service.AccountService;
import org.bsuir.coursework.service.ContractService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BankServiceController {
    @Autowired
    private AccountBalanceService accountBalanceService;
    @Autowired
    private ContractService contractService;
    @Autowired
    private AccountService accountService;


    @PreAuthorize("hasAuthority('EMPLOYEE')")
    @GetMapping("/closeBankDay")
    public String closeBankDay(Model model){
        contractService.listOfContracts().forEach(contract -> accountBalanceService.closeBankDay(contract));
        model.addAttribute("accounts", accountService.listOfAccounts());
        return "accounts";
    }
}
