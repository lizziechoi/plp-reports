select sites.name, max(day) as last_day, max(day_num) - min(day_num) as instr_days_left, round((max(day_num) - min(day_num))/5.0, 1) as instr_weeks_left
from date_to_instr_days
join sites on sites.id = date_to_instr_days.site_id
where day > now()
group by sites.name
;