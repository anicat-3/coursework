package org.bsuir.coursework.controller;

import org.bsuir.coursework.domain.Request;
import org.bsuir.coursework.domain.User;
import org.bsuir.coursework.service.DepositService;
import org.bsuir.coursework.service.RequestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Map;

@RequestMapping("/request")
@Controller
public class RequestController {
    @Autowired
    private RequestService requestService;
    @Autowired
    private DepositService depositService;

//    @PreAuthorize("hasAuthority('EMPLOYEE')")
    @GetMapping
    public String requestList(Model model){
        model.addAttribute("requests", requestService.findAll());
        return "requestList";
    }

    @GetMapping("{userId}")
    public String requestList(
            @PathVariable(name = "userId") Long userId,
            Model model
    ){
        model.addAttribute("requests", requestService.findAllByUserId(userId));
        return "requestList";
    }

    @PreAuthorize("hasAuthority('USER')")
    @GetMapping("/new")
    public String requestForm(@RequestParam Long depositId, Model model){
        model.addAttribute("deposit", depositService.getDeposit(depositId));
        return "requestForm";
    }

    @PreAuthorize("hasAuthority('USER')")
    @PostMapping("/new")
    public String addRequest(
            @AuthenticationPrincipal User user,
            @RequestParam("depositId") Long depositId,
            @Valid Request request,
            BindingResult bindingResult,
            Model model
    ){
        model.addAttribute("deposit", depositService.getDeposit(depositId));

        if(request.getAmount() != null && request.getAmount().compareTo(depositService.getDeposit(depositId).getAmountMin()) < 0){
            model.addAttribute("amountError", "Сумма не может быть меньше минимальной");
            return "requestForm";
        }

        if (bindingResult.hasErrors()) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            return "requestForm";
        }

        requestService.addRequest(request, user, depositService.getDeposit(depositId));
        model.addAttribute("requests", requestService.findAllByUserId(user.getId()));
        return "redirect:/request/"+user.getId();
    }

    @PostMapping("{user}/{request}")
    public String cancelRequest(
            @AuthenticationPrincipal User user,
            @RequestParam("requestId") Request request,
            Model model
    ){
        requestService.cancelRequest(request);
        model.addAttribute("requests", requestService.findAllByUserId(user.getId()));
        return "redirect:/request/"+user.getId();
    }

    @PreAuthorize("hasAuthority('EMPLOYEE')")
    @PostMapping("approve/{request}")
    public String approveRequest(
            @RequestParam("requestId") Request request,
            Model model
    ){
        requestService.approveRequest(request);
        model.addAttribute("requests", requestService.findAll());
        return "redirect:/request";
    }

    @PreAuthorize("hasAuthority('EMPLOYEE')")
    @PostMapping("reject/{request}")
    public String rejectRequest(
            @RequestParam("requestId") Request request,
            Model model
    ){
        requestService.rejectRequest(request);
        model.addAttribute("requests", requestService.findAll());
        return "redirect:/request";
    }
}
