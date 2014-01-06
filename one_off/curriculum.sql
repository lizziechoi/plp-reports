-- #focus_areas
select
  courses.name as course_name,
  subjects.name as subject_name,
  kds.name as focus_area_name,
  kds.url as focus_area_url,
  ckds.power as is_required
from courses
inner join subjects on subjects.id = courses.subject_id
inner join course_know_dos as ckds on ckds.course_id = courses.id
inner join know_dos as kds on kds.id = ckds.know_do_id
order by subjects.name, courses.sequence, kds.sequence
;

-- #projects
select
  courses.name as course_name,
  subjects.name as subject_name,
  projects.name as project_name,
  by_domain.domains as cog_skill_domains
from courses
inner join subjects on subjects.id = courses.subject_id
inner join project_courses as pcs on pcs.course_id = courses.id
inner join projects on pcs.project_id = projects.id
inner join (
  select projects.id as pid, array_to_string(array_agg(csds.name), ';') as domains
  from projects
  inner join project_cog_skill_domains as pcsds on pcsds.project_id = projects.id
  inner join cog_skill_domains as csds on pcsds.cog_skill_domain_id = csds.id
  group by projects.id) as by_domain on by_domain.pid = projects.id
order by subjects.name, courses.sequence, projects.sequence
;
