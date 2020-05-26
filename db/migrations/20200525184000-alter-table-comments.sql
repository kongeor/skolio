-- up
alter table comments 
add column token VARCHAR(32) not null default '';

alter table comments
add column status integer not null default 0;

-- down
alter table comments drop column token;
alter table comments drop column status;
