package org.bsuir.coursework.controller;

import org.bsuir.coursework.domain.Deposit;
import org.bsuir.coursework.domain.enums.Currency;
import org.bsuir.coursework.service.DepositService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Map;

@Controller
@RequestMapping("/deposit")
public class DepositController {
    @Autowired
    private DepositService depositService;

    @GetMapping
    public String depositList(Model model) {
        model.addAttribute("deposits", depositService.findAll());
        return "depositList";
    }

    @GetMapping("{deposit}")
    public String getDeposit(@PathVariable Deposit deposit, Model model) {
        model.addAttribute("deposit", depositService.getDeposit(deposit.getId()));
        return "deposit";
    }

    @GetMapping("edit")
    public String depositEdit(@RequestParam(name = "depositId") Long id, Model model) {
        model.addAttribute("deposit", depositService.getDeposit(id));
        model.addAttribute("depositId", id);
        model.addAttribute("currencies", Currency.values());
        return "depositEdit";
    }

    @PreAuthorize("hasAuthority('EMPLOYEE')")
    @PostMapping("edit")
    public String updateDeposit(
            @RequestParam(name = "depositId") Long id,
            @Valid Deposit deposit,
            BindingResult bindingResult,
            Model model
    ) {
        model.addAttribute("currencies", Currency.values());

        if(!deposit.getName().isEmpty()
                && deposit.getName() != null
                && deposit.getName().matches("^[a-zA-Z]*$")) {
            model.addAttribute("nameError", "Это поле может содержать только буквы");
            return "depositEdit";
        }

        if (bindingResult.hasErrors()) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            return "depositEdit";
        }

        depositService.updateDeposit(id, deposit);
        return "redirect:/deposit";
    }

    @PreAuthorize("hasAuthority('EMPLOYEE')")
    @PostMapping("add")
    public String addDeposit(
            @Valid Deposit deposit,
            BindingResult bindingResult,
            Model model
    ) {

        if (bindingResult.hasErrors()) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            model.addAttribute("currencies", Currency.values());
            return "depositForm";
        }

        depositService.addDeposit(deposit);
        return "redirect:/deposit";
    }

    @PreAuthorize("hasAuthority('EMPLOYEE')")
    @PostMapping("{deposit}")
    public String deleteDeposit(@PathVariable Deposit deposit) {
        depositService.deleteDeposit(deposit);
        return "redirect:/deposit";
    }

    @PreAuthorize("hasAuthority('EMPLOYEE')")
    @GetMapping("/add")
    public String depositForm(Model model) {
        model.addAttribute("currencies", Currency.values());
        return "depositForm";
    }

}
