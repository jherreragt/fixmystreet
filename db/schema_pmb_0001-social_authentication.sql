CREATE TABLE users_pmb (
	id integer PRIMARY KEY NOT NULL,
	twitter_id bigint,
	facebook_id bigint,
	ci int,
	CONSTRAINT "users_pmb_id_fkey" FOREIGN KEY (id) REFERENCES users (id)
);
