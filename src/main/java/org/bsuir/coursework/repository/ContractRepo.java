package org.bsuir.coursework.repository;

import org.bsuir.coursework.domain.Contract;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ContractRepo extends JpaRepository<Contract, Long> {
    List<Contract> findAllByOpened(boolean opened);
}
