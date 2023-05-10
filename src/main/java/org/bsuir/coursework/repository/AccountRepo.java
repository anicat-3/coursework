package org.bsuir.coursework.repository;

import org.bsuir.coursework.domain.Account;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AccountRepo extends JpaRepository<Account, Long> {
    public Account getAccountById(Long id);
}
