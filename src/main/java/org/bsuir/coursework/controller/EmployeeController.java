package org.bsuir.coursework.controller;

import org.bsuir.coursework.domain.User;
import org.bsuir.coursework.domain.UserDescription;
import org.bsuir.coursework.service.UserDescriptionService;
import org.bsuir.coursework.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class EmployeeController {
    @Autowired
    private UserDescriptionService userDescriptionService;
    @Autowired
    private UserService userService;

    @PreAuthorize("hasAuthority('EMPLOYEE')")
    @GetMapping("/client")
    public String clientsList(Model model) {
        var clients = userDescriptionService.findAll();
        model.addAttribute("clients", clients);
        return "clientList";
    }

    @PreAuthorize("hasAuthority('EMPLOYEE')")
    @GetMapping("/client/{clientId}")
    public String clientProfile(@PathVariable(name = "clientId") Long id, Model model) {
        UserDescription userDescription = userDescriptionService.getUserDescriptionById(id);
        User user = userDescription.getUser();
        model.addAttribute("username", user.getUsername());
        model.addAttribute("userDescription", userDescription);
        return "profile";
    }

    /*todo Add contractList*/
    @PreAuthorize("hasAuthority('EMPLOYEE')")
    @PostMapping("/client/{client}")
    public String getClient(@PathVariable UserDescription client, Model model) {


        return "";
    }
}
