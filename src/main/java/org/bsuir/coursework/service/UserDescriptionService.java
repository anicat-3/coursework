package org.bsuir.coursework.service;

import org.apache.commons.text.WordUtils;
import org.bsuir.coursework.domain.User;
import org.bsuir.coursework.domain.UserDescription;
import org.bsuir.coursework.repository.UserDescriptionRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserDescriptionService {
    @Autowired
    private UserDescriptionRepo userDescriptionRepo;

    public UserDescription getUserDescriptionByUser(User user){
        UserDescription userDescription = userDescriptionRepo.getUserDescriptionByUserId(user.getId());
        if (userDescription == null) {
            userDescription = new UserDescription();
            userDescription.setUser(user);
        }
        return userDescription;
    }

    public UserDescription getUserDescriptionById(Long id){
        return userDescriptionRepo.getReferenceById(id);
    }

    public void updateUserDescription(User user, UserDescription userDescription){
        UserDescription description = getUserDescriptionByUser(user);
        description.setSurname(WordUtils.capitalizeFully(userDescription.getSurname()));
        description.setName(WordUtils.capitalizeFully(userDescription.getName()));
        description.setPatronymic(WordUtils.capitalizeFully(userDescription.getPatronymic()));
        description.setDob(userDescription.getDob());
        description.setPassportSeries(userDescription.getPassportSeries().toUpperCase());
        description.setPassportNumber(userDescription.getPassportNumber());
        description.setPassportId(userDescription.getPassportId().toUpperCase());
        description.setPassportIssuedBy(userDescription.getPassportIssuedBy());
        description.setPassportIssuedDate(userDescription.getPassportIssuedDate());
        description.setCitizenship(userDescription.getCitizenship().toUpperCase());
        userDescriptionRepo.save(description);
    }

    public List<UserDescription> findAll(){
        return userDescriptionRepo.findAll();
    }
}
