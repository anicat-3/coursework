package org.bsuir.coursework.service;

import org.bsuir.coursework.domain.Account;
import org.bsuir.coursework.domain.Contract;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Set;

@Service
public class AccountBalanceService {
    @Autowired
    private AccountService accountService;
    @Autowired
    private CurrencyService currencyService;

    public void addAccounts(Contract contract) {
        Account bankAccount = accountService.getBankAccount();
        BigDecimal accountBalance = bankAccount.getAmount();

        switch (contract.getType()) {
            case "Депозит" -> {
                bankAccount.setAmount(accountBalance.add(currencyService.getExchangedAmount(contract.getRequest().getAmount(), contract.getRequest().getCurrency())));
                Account currentAccount = createAccount(contract, contract.getRequest().getAmount(), contract.getPersonalAccount(), false);
                Account percentAccount = createAccount(contract, BigDecimal.valueOf(0), contract.getPersonalAccount(), true);
                accountService.saveAccount(currentAccount);
                accountService.saveAccount(percentAccount);
            }
        }
    }

    public void closeBankDay(Contract contract) {
        Account bankAccount = accountService.getBankAccount();

        Set<Account> accounts = contract.getAccounts();
        Account currentAccount = null, percentAccount = null;
        for (Account account : accounts) {
            if (String.valueOf(account.getAccountNumber()).charAt(12) == '1') {
                currentAccount = account;
            } else {
                percentAccount = account;
            }
        }

        LocalDate currentDate = LocalDate.now();
        LocalDate dateOpened = contract.getDateOpened().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        LocalDate lastBalanced = contract.getLastBalanced().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        boolean isClosed = dateOpened.plusMonths(contract.getRequest().getTerm()).isBefore(currentDate);
        long daysPassedSinceLastBalance;
        if (!isClosed) {
            daysPassedSinceLastBalance = ChronoUnit.DAYS.between(lastBalanced, currentDate);
        } else {
            daysPassedSinceLastBalance = ChronoUnit.DAYS.between(lastBalanced, dateOpened.plusMonths(contract.getRequest().getTerm()));
        }

        switch (contract.getType()) {
            case "Депозит" -> {
                if (contract.isOpened()) {
                    percentAccount.setAmount(percentAccount.getAmount().add(getPercent(contract, daysPassedSinceLastBalance)));

                    if (dateOpened.plusMonths(contract.getRequest().getTerm()).isBefore(currentDate)) {
                        currentAccount.setAmount(currentAccount.getAmount().add(percentAccount.getAmount()));
                        contract.setAmountBalanced(currentAccount.getAmount());

                        bankAccount.setAmount(bankAccount.getAmount().subtract(currencyService.getExchangedAmount(contract.getAmountBalanced(), contract.getRequest().getCurrency())));
                        percentAccount.setAmount(BigDecimal.valueOf(0));
                        contract.setOpened(false);
                        contract.setDateClosed(Date.valueOf(currentDate));
                    }
                }
            }
        }

        contract.setLastBalanced(Date.valueOf(currentDate));
        accountService.saveAccount(currentAccount);
        accountService.saveAccount(percentAccount);
    }

    private String getAccountNumber(String personalAccount, boolean isPercentAccount) {
        StringBuilder result = new StringBuilder().append("BY");
        long code = getControlCode(Long.parseLong(personalAccount));
        result.append(code);
        result.append("BELB");
        result.append(3014);
        if (isPercentAccount) {
            result.append(2);
        } else {
            result.append(1);
        }
        result.append(personalAccount);
        String timestamp = String.valueOf(System.currentTimeMillis());
        result.append(timestamp.substring(timestamp.length() - 2));
        return result.toString();
    }

    private long getControlCode(long personalAccount) {
        while (personalAccount > 100) {
            personalAccount /= 8;
        }
        return personalAccount;
    }

    private Account createAccount(Contract contract, BigDecimal amount, String personalAccount, boolean isPercentAccount) {
        Account account = new Account();
        account.setContract(contract);
        account.setAccountNumber(getAccountNumber(personalAccount, isPercentAccount));
        account.setAmount(amount);
        return account;
    }

    private BigDecimal getPercent(Contract contract, long daysPassedSinceLastBalance) {
        BigDecimal amount = contract.getRequest().getAmount();
        float dailyRate = contract.getRequest().getRate() / 36500;
        BigDecimal interestIncome = amount.multiply(BigDecimal.valueOf(dailyRate * daysPassedSinceLastBalance));
        return interestIncome;
    }
}
