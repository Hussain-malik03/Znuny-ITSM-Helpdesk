-- Panel: Agent Last Activity With Action (table)
-- Latest history entry per agent on tickets in the queue.
SELECT
  CONCAT(u.first_name, ' ', u.last_name) AS agent,
  t.tn                                   AS ticket_number,
  t.title                                AS subject,
  th.name                                AS activity_performed,
  th.create_time                         AS activity_date
FROM ticket_history th
JOIN (
  SELECT th2.create_by, MAX(th2.id) AS last_id
  FROM ticket_history th2
  JOIN queue q2 ON q2.id = th2.queue_id
  WHERE q2.name = 'tech_support'
    AND th2.create_by <> 1            -- exclude root@localhost / system actions
  GROUP BY th2.create_by
) last ON last.last_id = th.id
JOIN ticket t ON t.id = th.ticket_id
JOIN users u  ON u.id = th.create_by
ORDER BY th.create_time DESC;
