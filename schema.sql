create table guestbook_entries (id bigint not null, name varchar(255), primary key (id)) engine=MyISAM;
create table hibernate_sequence (next_val bigint) engine=MyISAM;
insert into hibernate_sequence values ( 1 );