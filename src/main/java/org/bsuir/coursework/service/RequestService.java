package org.bsuir.coursework.service;

import org.bsuir.coursework.domain.Deposit;
import org.bsuir.coursework.domain.Request;
import org.bsuir.coursework.domain.User;
import org.bsuir.coursework.repository.RequestRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

@Service
public class RequestService {
    @Autowired
    private RequestRepo requestRepo;
    @Autowired
    private ContractService contractService;

    public List<Request> findAll(){
        return requestRepo.findAll();
    }

    public List<Request> findAllByUserId(Long id){
        return requestRepo.findAllByUserId(id);
    }

    public void addRequest(Request request, User user, Deposit deposit) {
        request.setUser(user);
        request.setDeposit(deposit);
        request.setDate(Date.valueOf(LocalDate.now()));
        requestRepo.save(request);
    }

    public void cancelRequest(Request request) {
        requestRepo.delete(request);
    }

    public void approveRequest(Request request) {
        request.setApproved(true);
        requestRepo.save(request);
        contractService.createContract(request);
    }

    public void rejectRequest(Request request) {
        request.setApproved(false);
        requestRepo.save(request);
    }
}
