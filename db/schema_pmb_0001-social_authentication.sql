CREATE TABLE users_pmb (
	id integer NOT NULL,
	twitter_id bigint,
	facebook_id bigint,
	CONSTRAINT "users_pmb_id_fkey" FOREIGN KEY (id) REFERENCES users (id)
);