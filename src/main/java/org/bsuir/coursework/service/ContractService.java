package org.bsuir.coursework.service;

import org.bsuir.coursework.domain.Contract;
import org.bsuir.coursework.domain.Request;
import org.bsuir.coursework.repository.ContractRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

@Service
public class ContractService {
    @Autowired
    private ContractRepo contractRepo;
    @Autowired
    private AccountBalanceService accountBalanceService;

    public void createContract(Request request){
        Contract contract = new Contract();
        contract.setRequest(request);
        contract.setPersonalAccount(getPersonalAccountNumber());
        if (request.getDeposit() != null) {
            contract.setType("Депозит");
        }
        contract.setDateOpened(Date.valueOf(LocalDate.now()));
        contract.setLastBalanced(Date.valueOf(LocalDate.now()));
        contract.setAmountBalanced(BigDecimal.valueOf(0));
        contract.setOpened(true);
        contractRepo.save(contract);
        accountBalanceService.addAccounts(contract);
    }

    private String getPersonalAccountNumber(){
        StringBuilder result = new StringBuilder();
        String timestamp = String.valueOf(System.currentTimeMillis());
        result.append(timestamp.substring(timestamp.length()-13));
        return result.toString();
    }

    public List<Contract> listOfContracts(){
        return contractRepo.findAllByOpened(true);
    }
}
