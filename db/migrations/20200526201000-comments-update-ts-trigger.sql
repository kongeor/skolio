-- up
create trigger [UpdateLastTime]
after update
on comments
for each row
	begin
		update comments set updated_at = CURRENT_TIMESTAMP where id = old.id;
	end

-- down
drop trigger UpdateLastTime;
