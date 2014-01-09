select 
  due_on, 
  status, 
  score, 
  raw_score, 
  submitted_on, 
  scored_on, 
  (status = 'rating' OR status = 'performed') as turned_in_but_not_scored
from project_assignments as pas
order by status
;