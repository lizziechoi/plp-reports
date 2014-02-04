select users.first_name, users.last_name, users.email, page_uses.* 
from page_uses
join users on page_uses.used_by_id = users.id
order by page_uses.count desc
;