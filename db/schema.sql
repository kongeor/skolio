CREATE TRIGGER [UpdateLastTime]
after update
on comments
for each row
	begin
		update comments set updated_at = CURRENT_TIMESTAMP where id = old.id;
	end
CREATE TABLE schema_migrations (version text primary key)
CREATE TABLE comments (
  id integer primary key,
  name VARCHAR(255) not null,
  website VARCHAR(255),
  thread VARCHAR(500) not null,
  message text not null,
  created_at integer not null default(strftime('%s', 'now')),
  updated_at integer
, token VARCHAR(32) not null default '', status integer not null default 0)
CREATE UNIQUE INDEX comments_token_unique_idx on comments(token)