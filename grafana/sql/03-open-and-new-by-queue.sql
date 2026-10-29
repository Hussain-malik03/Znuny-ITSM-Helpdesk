-- Panel: Open and New Tickets by Queue (bar chart, current backlog)
SELECT
  q.name   AS queue,
  COUNT(*) AS count
FROM ticket t
JOIN queue q               ON q.id   = t.queue_id
JOIN ticket_state ts       ON ts.id  = t.ticket_state_id
JOIN ticket_state_type tst ON tst.id = ts.type_id
WHERE tst.name IN ('new', 'open')
  AND q.valid_id = 1
GROUP BY q.name
ORDER BY count DESC;
