package org.bsuir.coursework.repository;

import org.bsuir.coursework.domain.UserDescription;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserDescriptionRepo extends JpaRepository<UserDescription, Long> {
    UserDescription getUserDescriptionByUserId(Long id);
}
