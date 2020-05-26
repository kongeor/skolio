-- up
create unique index comments_token_unique_idx on comments(token);

-- down
drop index comments_token_unique_idx;
