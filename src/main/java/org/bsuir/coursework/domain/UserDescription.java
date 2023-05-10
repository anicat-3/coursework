package org.bsuir.coursework.domain;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.PastOrPresent;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.util.Date;

@Getter
@Setter
@Entity
@Table(name = "usr_description")
public class UserDescription implements Serializable {
    @Setter(AccessLevel.NONE)
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @OneToOne
    @JoinColumn(name = "usr_id")
    private User user;

    @Size(min=2, message = "Фамилия слишком короткая")
    private String surname;

    @Size(min=2, message = "Имя слишком короткое")
    private String name;

    private String patronymic;

    @NotNull(message = "Выберите дату рождения")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @PastOrPresent(message = "Некорректная дата рождения")
    private Date dob;

    @Size(min=2, max=2, message = "Паспортные данные некорректны")
    private String passportSeries;

    @Size(min=7, max=7, message = "Паспортные данные некорректны")
    private String passportNumber;

    @Size(min=14, max=14, message = "Паспортные данные некорректны")
    private String passportId;

    @Size(min=10, message = "Паспортные данные некорректны")
    private String passportIssuedBy;

    @NotNull(message = "Паспортные данные некорректны")
    @DateTimeFormat(pattern="yyyy-MM-dd")
    @PastOrPresent(message = "Некорректная дата выдачи паспорта")
    private Date passportIssuedDate;

    @NotBlank(message = "Укажите гражданство")
    private String citizenship;
}
