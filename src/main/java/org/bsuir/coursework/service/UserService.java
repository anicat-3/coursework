package org.bsuir.coursework.service;

import lombok.AllArgsConstructor;
import org.bsuir.coursework.domain.enums.Role;
import org.bsuir.coursework.domain.User;
import org.bsuir.coursework.repository.UserRepo;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;

@Service
@AllArgsConstructor
public class UserService implements UserDetailsService {
    private UserRepo userRepo;
    private PasswordEncoder passwordEncoder;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepo.findByUsername(username);
        if(user == null){
            throw new UsernameNotFoundException("User not found");
        }
        return user;
    }

    public boolean addUser(User user) {
        User userFromDb = userRepo.findByUsername(user.getUsername());

        if (userFromDb != null) {
            return false;
        }

        user.setRole(Role.USER);
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepo.save(user);

        return true;
    }

    public List<User> findAll() {
        return userRepo.findAll();
    }

    public void saveUser(User user, String username, String role) {
        user.setUsername(username);
        user.setRole(Role.valueOf(role));
        userRepo.save(user);
    }

    public boolean updateAccount(User user, String password) {
        if(!StringUtils.isEmpty(password)){
            user.setPassword(passwordEncoder.encode(password));
            userRepo.save(user);
            return true;
        }
        return false;
    }

    public void deleteUser(User user){
        userRepo.delete(user);
    }

    public User getUserById(Long id) {
        return userRepo.getReferenceById(id);
    }
}
