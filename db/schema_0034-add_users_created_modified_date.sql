alter table users add column created timestamp not null default ms_current_timestamp();
alter table users add column modified timestamp not null default ms_current_timestamp();
