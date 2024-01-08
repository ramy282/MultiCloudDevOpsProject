package ch.mikenoethiger.guestbook.repository;

import ch.mikenoethiger.guestbook.entity.GuestbookEntry;
import org.springframework.data.repository.CrudRepository;

public interface GuestbookEntryRepository extends CrudRepository<GuestbookEntry, Long> {

}
