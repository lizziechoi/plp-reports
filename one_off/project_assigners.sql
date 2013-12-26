select max(assigners.last_name) as last, max(projects.name) as proj, max(subject_id) as subj_id
from users as assigners
join project_assignments as pas on assigners.id = pas.assigned_by_id
join projects on projects.id = pas.project_id
group by projects.name
order by subj_id, last, proj
;
