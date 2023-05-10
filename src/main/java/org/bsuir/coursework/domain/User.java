package org.bsuir.coursework.domain;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;
import org.bsuir.coursework.domain.enums.Role;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "usr")
public class User implements UserDetails {
    @Setter(AccessLevel.NONE)
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @NotBlank(message = "Логин не может быть пустым")
    private String username;
    @NotBlank(message = "Пароль не может быть пустым")
    private String password;

    @Enumerated(EnumType.STRING)
    private Role role;

    @OneToOne(cascade = CascadeType.ALL, optional = false, fetch = FetchType.LAZY, mappedBy = "user")
    private UserDescription userDescription;

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    @OnDelete(action = OnDeleteAction.CASCADE)
    private List<Request> requests;

    public boolean isAdmin(){
        return role.equals(Role.ADMIN);
    }

    public boolean isEmployee() { return role.equals(Role.EMPLOYEE); }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return Collections.singleton(getRole());
    }

    private PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(12);
    }
}
