package org.bsuir.coursework.controller;

import org.bsuir.coursework.domain.enums.Role;
import org.bsuir.coursework.domain.User;
import org.bsuir.coursework.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping
    public String userList(Model model) {
        model.addAttribute("users", userService.findAll());
        return "userList";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("{user}")
    public String userEditForm(@PathVariable User user, Model model) {
        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());
        return "userEdit";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping
    public String updateUser(
            @RequestParam String username,
            @RequestParam String role,
            @RequestParam("user") User user
    ) {
        userService.saveUser(user, username, role);
        return "redirect:/user";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("{user}")
    public String deleteUser(@PathVariable User user, Model model) {
        userService.deleteUser(user);
        return "redirect:/user";
    }

    @GetMapping("account")
    public String getAccount(Model model, @AuthenticationPrincipal User user) {
        model.addAttribute("username", user.getUsername());
        return "account";
    }

    @PostMapping("account")
    public String updateAccount(
            @AuthenticationPrincipal User user,
            @RequestParam String password,
            Model model
    ) {
        model.addAttribute("username", user.getUsername());

        if (StringUtils.isEmpty(password)) {
            model.addAttribute("passwordError", "Пароль не может быть пустым");
            return "account";
        }

        if (user.getPassword() == null && user.getPassword().equals(password)) {
            model.addAttribute("passwordError", "Новый пароль не может совпадать со старым");
            return "account";
        }

        boolean isUpdated = userService.updateAccount(user, password);

        if (!isUpdated) {
            model.addAttribute("messageType", "danger");
            model.addAttribute("message", "Ошибка при изменении пароля");
        } else {
            model.addAttribute("messageType", "success");
            model.addAttribute("message", "Пароль изменен");
        }
        return "account";
    }
}
