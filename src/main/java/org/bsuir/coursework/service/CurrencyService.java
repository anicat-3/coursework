package org.bsuir.coursework.service;

import org.bsuir.coursework.domain.enums.Currency;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;

@Service
public class CurrencyService {
    private final float exchRateRUB = 0.036627F;
    private final float exchRateUSD = 2.8853F;
    private final float exchRateEUR = 3.1887F;

    public BigDecimal getExchangedAmount(BigDecimal amount, Currency currency){
        switch (currency){
            case BYN -> {
                return amount;
            }
            case RUB -> {
                return amount.multiply(BigDecimal.valueOf(exchRateRUB));
            }
            case USD -> {
                return amount.multiply(BigDecimal.valueOf(exchRateUSD));
            }
            case EUR -> {
                return amount.multiply(BigDecimal.valueOf(exchRateEUR));
            }
        }
        return amount;
    }

}
