-- Panel: Tickets Created Per Day (bar chart, thresholds colour busy days)
SELECT
  $__timeGroupAlias(th.create_time, 1d),
  COUNT(*) AS created
FROM ticket_history th
JOIN ticket_history_type hty ON hty.id = th.history_type_id AND hty.name = 'NewTicket'
JOIN queue q                 ON q.id   = th.queue_id
WHERE $__timeFilter(th.create_time)
  AND q.name = 'tech_support'
GROUP BY 1
ORDER BY 1;
