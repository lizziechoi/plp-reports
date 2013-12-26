select 
  kds.name, ats.taken_at, ats.num_possible, ats.num_correct, kds.pcnt_to_pass,
  (ats.num_correct / cast(ats.num_possible as float)) as pcnt_correct,
  (ats.num_correct / cast(ats.num_possible as float)) >= kds.pcnt_to_pass as passed
from assessment_takes as ats
join know_dos as kds on kds.id = ats.know_do_id
;