package org.bsuir.coursework.service;

import org.bsuir.coursework.domain.Account;
import org.bsuir.coursework.repository.AccountRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AccountService {
    @Autowired
    private AccountRepo accountRepo;

    public Account getBankAccount(){
        return accountRepo.getAccountById(1L);
    }

    public void saveAccount(Account account){
        accountRepo.save(account);
    }

    public List<Account> listOfAccounts(){
        return accountRepo.findAll();
    }
}
