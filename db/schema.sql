CREATE TABLE schema_migrations (version text primary key)
CREATE TABLE comments (
  id integer primary key,
  name VARCHAR(255) not null,
  website VARCHAR(255),
  thread VARCHAR(500) not null,
  message text not null,
  created_at integer not null default(strftime('%s', 'now')),
  updated_at integer
)