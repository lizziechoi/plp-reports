SELECT 
  subjects.name as "Subject Name",
  courses.name as "Course Name",
  projects.name as "Project Name",
  csds.name as "Cog Skill Domain",
  projects.weight as "Weight of project in course",
  pcsds.weight as "Weight of cog skill in project",
  projects.seventy_pcnt_score as "Cog skill score to get a 70%"
FROM courses
INNER JOIN subjects on courses.subject_id = subjects.id
INNER JOIN project_courses as pcs on pcs.course_id = courses.id
INNER JOIN projects on pcs.project_id = projects.id
LEFT OUTER JOIN project_cog_skill_domains as pcsds on pcsds.project_id = projects.id
INNER JOIN cog_skill_domains as csds on pcsds.cog_skill_domain_id = csds.id
order by courses.sequence
;
