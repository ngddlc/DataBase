SELECT
s.lesson_date AS "Дата",
w.weekday_id || '. ' || w.name AS "День недели",
lt.lesson_number AS "№ пары",
lt.time_start || ' ‐ ' || lt.time_end AS "Время",
subj.name AS "Дисциплина",
t.last_name || ' ' || t.first_name || ' ' ||
COALESCE(t.middle_name,'') AS "Преподаватель",
t.position AS "Должность",
b.name AS "Корпус",
b.address AS "Адрес",
c.room_number AS "Аудитория",
CASE s.group_part
WHEN 'FULL' THEN 'Вся группа'
WHEN 'SUB1' THEN '1 подгруппа'
WHEN 'SUB2' THEN '2 подгруппа'
END AS "Подгруппа"
FROM schedule s
JOIN student_group g ON g.group_id = s.group_id
JOIN weekday w ON w.weekday_id = s.weekday_id
JOIN lesson_time lt ON lt.lesson_time_id = s.lesson_time_id
JOIN subject subj ON subj.subject_id = s.subject_id
JOIN teacher t ON t.teacher_id = s.teacher_id
JOIN classroom c ON c.classroom_id = s.classroom_id
JOIN building b ON b.building_id = c.building_id
WHERE
g.group_name = 'ИС-12'
AND s.lesson_date BETWEEN DATE '2026-01-12' AND DATE '2026-01-17'
ORDER BY
s.lesson_date,
lt.lesson_number,
s.group_part;