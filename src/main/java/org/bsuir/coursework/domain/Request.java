package org.bsuir.coursework.domain;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;
import org.bsuir.coursework.domain.enums.Currency;
import org.hibernate.annotations.ColumnDefault;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import javax.validation.constraints.PastOrPresent;
import javax.validation.constraints.Positive;
import java.math.BigDecimal;
import java.util.Date;

@Getter
@Setter
@Entity
@Table(name = "request")
public class Request {
    @Setter(AccessLevel.NONE)
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Positive(message = "Сумма не может быть отрицательной")
    private BigDecimal amount;

    @Positive(message = "Срок не может быть меньше нуля")
    private int term;

    @Positive
    private float rate;

    @Enumerated(EnumType.STRING)
    private Currency currency;

    @ColumnDefault(value = "null")
    private Boolean approved;

    @PastOrPresent
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date date;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "depositId", nullable = false)
    private Deposit deposit;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userId", nullable = false)
    private User user;

    @OneToOne(mappedBy = "request", fetch = FetchType.LAZY, orphanRemoval = true, optional = false)
    private Contract contract;
}
