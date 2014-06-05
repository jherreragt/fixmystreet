CREATE TABLE contacts_group (
    group_id SERIAL NOT NULL PRIMARY KEY,
    group_name TEXT NOT NULL
);

ALTER TABLE contacts ADD COLUMN group_id INTEGER REFERENCES contacts_group(group_id);

