package cl.redvecinal.backend.community.dto;

import cl.redvecinal.backend.model.Announcement;
import cl.redvecinal.backend.model.Event;
import cl.redvecinal.backend.model.Membership;
import cl.redvecinal.backend.user.model.User;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.HashSet;
import java.util.Set;

@Data
@Setter
@Getter
public class CommunityDto {
    private Long id;
    private String name;
    private String description;
    private LocalDate creationDate;
    private String lat;
    private String lon;
    private Set<Membership> memberships = new HashSet<>();
    private Set<Announcement> announcements;
    private Set<Event> events;
    private User user;
}
