package org.bsuir.coursework.repository;

import org.bsuir.coursework.domain.Request;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RequestRepo extends JpaRepository<Request, Long> {
    List<Request> findAllByUserId(Long id);
}
