package org.bsuir.coursework.controller;

import org.bsuir.coursework.domain.User;
import org.bsuir.coursework.domain.UserDescription;
import org.bsuir.coursework.service.UserDescriptionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.validation.Valid;
import java.sql.Date;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Map;

@Controller
@RequestMapping("/profile")
public class UserDescriptionController {
    @Autowired
    private UserDescriptionService userDescriptionService;

    @GetMapping
    public String getUserDescription(@AuthenticationPrincipal User user, Model model) {
        model.addAttribute("username", user.getUsername());
        UserDescription userDescription = userDescriptionService.getUserDescriptionByUser(user);
        model.addAttribute("userDescription", userDescription);
        return "profile";
    }

    @GetMapping("/edit")
    public String profileEditForm(@AuthenticationPrincipal User user, Model model) {
        model.addAttribute("username", user.getUsername());
        UserDescription userDescription = userDescriptionService.getUserDescriptionByUser(user);
        model.addAttribute("userDescription", userDescription);
        return "profileEdit";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("{user}")
    public String getUserProfile(@PathVariable User user, Model model) {
        model.addAttribute("username", user.getUsername());
        UserDescription userDescription = userDescriptionService.getUserDescriptionByUser(user);
        model.addAttribute("userDescription", userDescription);
        return "profile";
    }

    @PostMapping
    public String updateUserDescription(
            @AuthenticationPrincipal User user,
            @Valid UserDescription userDescription,
            BindingResult bindingResult,
            Model model
    ) {
        model.addAttribute("username", user.getUsername());

        if(!userDescription.getSurname().isEmpty()
                && userDescription.getSurname() != null
                && userDescription.getSurname().matches("^[a-zA-Z]*$")) {
            model.addAttribute("surnameError", "Это поле может содержать только буквы");
            return "profileEdit";
        }

        if(!userDescription.getName().isEmpty()
                && userDescription.getName() != null
                && userDescription.getName().matches("^[a-zA-Z]*$")) {
            model.addAttribute("nameError", "Это поле может содержать только буквы");
            return "profileEdit";
        }

        if(!userDescription.getPatronymic().isEmpty()
                && userDescription.getPatronymic() != null
                && userDescription.getPatronymic().length() < 3) {
            model.addAttribute("patronymicError", "Отчество слишком короткое");
            return "profileEdit";
        }

        if(!userDescription.getPatronymic().isEmpty()
                && userDescription.getPatronymic() != null
                && userDescription.getPatronymic().matches("^[a-zA-Z]*$")) {
            model.addAttribute("patronymicError", "Это поле может содержать только буквы");
            return "profileEdit";
        }

        if (userDescription.getDob() != null
                && userDescription.getDob().after(Date.valueOf(LocalDate.now().minusYears(18)))) {
            model.addAttribute("dobError", "Ошибка регистрации: вы младше 18 лет");
            return "profileEdit";
        }

        if(!userDescription.getPassportSeries().isEmpty()
                && userDescription.getPassportSeries() != null
                && userDescription.getPassportSeries().matches("^[a-zA-Z]{3}$")) {
            model.addAttribute("passportSeriesError", "Это поле может содержать только буквы");
            return "profileEdit";
        }

        if(!userDescription.getPassportNumber().isEmpty()
                && userDescription.getPassportNumber() != null
                && userDescription.getPassportNumber().matches("\\d")) {
            model.addAttribute("passportNumberError", "Это поле может содержать только цифры");
            return "profileEdit";
        }

        if(!userDescription.getPassportId().isEmpty()
                && userDescription.getPassportId() != null
                && userDescription.getPassportId().matches("\\w")) {
            model.addAttribute("passportIdError", "Это поле может содержать только цифры и буквы");
            return "profileEdit";
        }

        if(!userDescription.getPassportIssuedBy().isEmpty()
                && userDescription.getPassportIssuedBy() != null
                && userDescription.getPassportIssuedBy().matches("^[a-zA-Z]*$")) {
            model.addAttribute("passportIssuedByError", "Это поле может содержать только буквы");
            return "profileEdit";
        }

        if (userDescription.getDob() != null && userDescription.getPassportIssuedDate() != null
                && userDescription.getPassportIssuedDate().after(userDescription.getDob())
                && userDescription.getPassportIssuedDate().after(
                        Date.valueOf(userDescription.getDob().toInstant().atZone(
                                ZoneId.systemDefault()).toLocalDate().plusYears(14)))) {
            model.addAttribute("passpordIssuedDateError", "Некорректная дата выдачи паспорта");
            return "profileEdit";
        }

        if (!userDescription.getCitizenship().isEmpty()
                && userDescription.getCitizenship() != null
                && userDescription.getCitizenship().matches("^[a-zA-z]*$")) {
            model.addAttribute("citizenshipError", "Это поле может содержать только буквы");
            return "profileEdit";
        }

        if (bindingResult.hasErrors()) {
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            return "profileEdit";
        }
        userDescriptionService.updateUserDescription(user, userDescription);

        model.addAttribute("userDescription", userDescriptionService.getUserDescriptionByUser(user));
        return "profile";
    }

}
