-- Read-only MariaDB account for Grafana (run on the Znuny DB server).
-- Grafana never needs write access to the helpdesk database.
CREATE USER 'grafana_ro'@'<GRAFANA_HOST_IP>' IDENTIFIED BY '<STRONG_PASSWORD>';
GRANT SELECT ON znuny.* TO 'grafana_ro'@'<GRAFANA_HOST_IP>';
FLUSH PRIVILEGES;
