package org.bsuir.coursework.service;

import org.bsuir.coursework.domain.Deposit;
import org.bsuir.coursework.repository.DepositRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepositService {
    @Autowired
    private DepositRepo depositRepo;

    public List<Deposit> findAll(){
        return depositRepo.findAll();
    }

    public Deposit getDeposit(Long id){
        return depositRepo.getReferenceById(id);
    }

    public void addDeposit(Deposit deposit) {

        depositRepo.save(deposit);
    }

    public void updateDeposit(Long id, Deposit deposit) {
        var updated = depositRepo.getReferenceById(id);
        updated.setName(deposit.getName());
        updated.setType(deposit.getType());
        updated.setInterestRate(deposit.getInterestRate());
        updated.setAmountMin(deposit.getAmountMin());
        updated.setTermMin(deposit.getTermMin());
        updated.setTermMax(deposit.getTermMax());
        updated.setCurrency(deposit.getCurrency());
        depositRepo.save(updated);
    }

    public void deleteDeposit(Deposit deposit) {
        depositRepo.delete(deposit);
    }
}
