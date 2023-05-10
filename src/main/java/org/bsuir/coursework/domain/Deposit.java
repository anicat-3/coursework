package org.bsuir.coursework.domain;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;
import org.bsuir.coursework.domain.enums.Currency;
import org.bsuir.coursework.domain.enums.DepositType;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;
import org.hibernate.validator.constraints.Range;

import javax.persistence.*;
import javax.validation.constraints.*;
import java.math.BigDecimal;
import java.util.List;
import java.util.Set;

@Setter
@Getter
@Entity
@Table(name = "deposit")
public class Deposit {
    @Setter(AccessLevel.NONE)
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @NotBlank(message = "Название не может быть пустым")
    private String name;

    @Enumerated(EnumType.STRING)
    private DepositType type;

    @Positive(message = "Процентная ставка должна быть больше нуля")
    private float interestRate;

    @Positive(message = "Сумма не может быть отрицательной")
    private BigDecimal amountMin;

    @Range(max = 24, message = "Срок кредитования ограничивается 24 мес")
    private int termMin;

    @Range(max = 24, message = "Срок кредитования ограничивается 24 мес")
    private int termMax;

    @ElementCollection(targetClass = Currency.class, fetch = FetchType.LAZY)
    @CollectionTable(name="currency", joinColumns = @JoinColumn(name="deposit_id"))
    @Enumerated(EnumType.STRING)
    private Set<Currency> currency;

    @OneToMany(mappedBy = "deposit", fetch = FetchType.LAZY)
    @OnDelete(action = OnDeleteAction.CASCADE)
    private List<Request> requests;
}
