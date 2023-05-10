package org.bsuir.coursework.repository;

import org.bsuir.coursework.domain.Deposit;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DepositRepo extends JpaRepository<Deposit, Long> {
}
