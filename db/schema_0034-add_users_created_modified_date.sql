alter table users add column created_date timestamp not null default ms_current_timestamp();
alter table users add column modified timestamp not null default ms_current_timestamp();
