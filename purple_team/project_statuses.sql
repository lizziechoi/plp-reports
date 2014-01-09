select 
  due_on, 
  status, 
  score, 
  raw_score, 
  submitted_on, 
  scored_on, 
  raw_score is null and status in ('rating','performed','scored','inRevision') as turned_in_but_not_scored
from project_assignments as pas
;