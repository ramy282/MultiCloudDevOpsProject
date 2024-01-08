package ch.mikenoethiger.guestbook.controller;

import ch.mikenoethiger.guestbook.entity.GuestbookEntry;
import ch.mikenoethiger.guestbook.repository.GuestbookEntryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.view.RedirectView;

@Controller
public class GuestbookController {

    @Autowired
    GuestbookEntryRepository guestbookEntryRepository;

    @GetMapping("/")
    public String guestbook(Model model) {
        Iterable<GuestbookEntry> entries = guestbookEntryRepository.findAll();
        model.addAttribute("guestBookEntries", entries);
        return "guestbook";
    }

    @PostMapping("/register")
    public RedirectView register(@ModelAttribute GuestbookEntry guestbookEntry) {
        guestbookEntryRepository.save(guestbookEntry);
        return new RedirectView("/");
    }
}
