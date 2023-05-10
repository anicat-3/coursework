package org.bsuir.coursework.domain;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import javax.validation.constraints.Max;
import javax.validation.constraints.Positive;
import java.math.BigDecimal;
import java.util.Date;
import java.util.Set;

@Getter
@Setter
@Entity
@Table(name = "contract")
public class Contract {
    @Setter(AccessLevel.NONE)
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @OneToOne
    @JoinColumn(name = "requestId")
    private Request request;

    private String personalAccount;

    private String type;

    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date dateOpened;

    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date dateClosed;

    @ColumnDefault(value = "true")
    private boolean opened;

    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date lastBalanced;

    private BigDecimal amountBalanced;

    @OneToMany(mappedBy = "contract", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private Set<Account> accounts;
}
