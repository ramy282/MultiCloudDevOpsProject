package ch.mikenoethiger.guestbook.entity;

import javax.persistence.*;

@Entity
@Table(name = "guestbook_entries")
public class GuestbookEntry {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column(name = "name")
    private String name;

    public GuestbookEntry() {
    }

    public GuestbookEntry(long id, String name) {
        this.id = id;
        this.name = name;
    }

    public long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setId(long id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }
}
