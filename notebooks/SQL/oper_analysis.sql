--1
-- QUERY: WAREHOUSE PERFORMANCE
SELECT warehouse_id, SUM(shipments) as total_ships,
SUM(backlog) AS total_backlog,
ROUND(SUM(backlog)*100/NULLIF(SUM(shipments),0),2) AS backlog_rate_percet,
ROUND(AVG(utilization_perct),2) AS avg__util,
ROUND(AVG(Productivity),2) AS avg_produc,
ROUND(AVG(on_time_ships_percet),2) AS avg_on_time_deliv,
ROUND(AVG(errors_percet),2) AS avg_error_percet,
FROM operations
GROUP BY warehouse_id
ORDER BY total_ships DESC

--2
-- QUERY: RISKY OPERATIONAL WAREHOUSES
SELECT
    warehouse_id,
    ROUND(AVG(utilization_perct), 2) AS avg_util,
    SUM(backlog) AS total_backlog,
    ROUND(
        SUM(backlog) * 100.0 / NULLIF(SUM(shipments), 0),
        2
    ) AS backlog_rate_percet,
ROUND(AVG(on_time_ships_percet), 2) AS avg_on_time_deliv
FROM operations
GROUP BY warehouse_id
HAVING AVG(utilization_perct) >= 70
AND SUM(backlog) * 100.0 / NULLIF(SUM(shipments), 0) >= 2
ORDER BY backlog_rate_percet DESC;

--3
-- QUERY: WAREHOUSES WRT BACKLOG RATE
SELECT
    warehouse_id,
    ROUND(
        SUM(backlog) * 100.0 / NULLIF(SUM(shipments), 0),
        2
    ) AS backlog_rate_percet,
    RANK() OVER (
        ORDER BY
            SUM(backlog) * 1.0 / NULLIF(SUM(shipments), 0) DESC
    ) AS backlog_risk_rank
FROM operations
GROUP BY warehouse_id
ORDER BY backlog_risk_rank;

--4
-- QUERY: SHIFT PERFORMANCE
SELECT
    shift_id,
    ROUND(AVG(Productivity), 2) AS avg_produc,
    ROUND(AVG(utilization_perct), 2) AS avg_util,
    SUM(backlog) AS total_backlog,
    ROUND(AVG(errors_percet), 2) AS avg_error_rate,
    ROUND(AVG(on_time_ships_percet), 2) AS avg_on_time_deliv
FROM operations
GROUP BY shift_id
ORDER BY avg_produc DESC;

--5
-- QUERY: WAREHOUSE AND SHIFTS STRUGGLING
SELECT
    warehouse_id,
    shift_id,
    ROUND(AVG(Productivity), 2) AS avg_produc,
    ROUND(AVG(utilization_perct), 2) AS avg_util,
    SUM(backlog) AS total_backlog,
    ROUND(AVG(errors_percet), 2) AS avg_error_rate,
    ROUND(AVG(on_time_ships_percet), 2) AS avg_on_time_deliv
FROM operations
GROUP BY
    warehouse_id,
    shift_id
ORDER BY total_backlog DESC;

--6
-- QUERY: WORST OPERATION DAY
SELECT
    date,
    warehouse_id,
    shift_id,
    shipments,
    capacity,
    utilization_perct,
    backlog,
    on_time_ships_percet,
    errors_percet
FROM operations
ORDER BY backlog DESC
LIMIT 20;

--7
-- QUERY: UTILIZATION PERIOD
SELECT
    date,
    warehouse_id,
    shift_id,
    shipments,
    capacity,
    utilization_perct,
    backlog,
    on_time_ships_percet
FROM operations
ORDER BY utilization_perct DESC
LIMIT 20;

--8
-- QUERY: PEAK PERFORMANCE
SELECT
    is_peak,
    COUNT(*) AS periods,
    SUM(shipments) AS total_shipments,
    ROUND(AVG(utilization_perct), 2) AS avg_util,
    SUM(backlog) AS total_backlog,
    ROUND(AVG(errors_percet), 2) AS avg_error_rate,
    ROUND(AVG(on_time_ships_percet), 2) AS avg_on_time_deliv
FROM operations
GROUP BY is_peak
ORDER BY is_peak;

--9
-- QUERY: MONLTHY PERFORMANCE
SELECT
    month_nm,
    COUNT(*) AS periods,
    SUM(shipments) AS total_shipments,
    ROUND(AVG(utilization_perct), 2) AS avg_util,
    SUM(backlog) AS total_backlog,
    ROUND(AVG(errors_percet), 2) AS avg_error_rate,
    ROUND(AVG(on_time_ships_percet), 2) AS avg_on_time_deliv
FROM operations
GROUP BY month_nm
ORDER BY
    MIN(EXTRACT(MONTH FROM date));

--10
-- QUERY: DAILY PERFORMACE
SELECT
    DAYNAME(date) AS day_of_week,
    COUNT(*) AS periods,
    SUM(shipments) AS total_shipments,
    ROUND(AVG(utilization_perct), 2) AS avg_util,
    SUM(backlog) AS total_backlog,
    ROUND(AVG(errors_percet), 2) AS avg_error_rate,
    ROUND(AVG(on_time_ships_percet), 2) AS avg_on_time_deliv
FROM operations
GROUP BY DAYNAME(date)
ORDER BY avg_util DESC;

--11
-- QUERY: HIGH PRESSURE PERIODS
SELECT
    date,
    warehouse_id,
    shift_id,
    shipments,
    capacity,
    utilization_perct,
    backlog,
    errors_percet,
    on_time_ships_percet
FROM operations
WHERE utilization_perct >= 100
  AND backlog > 0
ORDER BY utilization_perct DESC, backlog DESC;

--12
-- QUERY: FREQ HIGH PRESSURE WAREHOUSES
SELECT
    warehouse_id,
    COUNT(*) AS total_periods,
    SUM(
        CASE
            WHEN utilization_perct >= 100
             AND backlog > 0
            THEN 1
            ELSE 0
        END
    ) AS high_pressure_periods,
    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN utilization_perct >= 100
                 AND backlog > 0
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS high_pressure_perct
FROM operations
GROUP BY warehouse_id
ORDER BY high_pressure_perct DESC;

--13
-- QUERY: PERIODS WITH POOR PERFORMANCE
SELECT
    date,
    warehouse_id,
    shift_id,
    shipments,
    utilization_perct,
    backlog,
    on_time_ships_percet
FROM operations
WHERE on_time_ships_percet < 90
ORDER BY on_time_ships_percet ASC
LIMIT 20;

--14
-- QUERY: UNUSUAL HIGH ERROR RATES
SELECT
    date,
    warehouse_id,
    shift_id,
    shipments,
    utilization_perct,
    errors_percet,
    backlog,
    on_time_ships_percet
FROM operations
WHERE errors_percet >= 1
ORDER BY errors_percet DESC, shipments DESC
LIMIT 20;

--15
-- QUERY: PRODUCTIVITY WRT WAREHOUSE/SHIFTS
SELECT
    warehouse_id,
    shift_id,
    ROUND(AVG(Productivity), 2) AS avg_produc,
    ROUND(AVG(utilization_perct), 2) AS avg_util,
    ROUND(AVG(on_time_ships_percet), 2) AS avg_on_time_deliv
FROM operations
GROUP BY
    warehouse_id,
    shift_id
ORDER BY avg_produc DESC;

--16
-- QUERY: WAREHOUSE WRT AVG NETWORK PERFORMANCE
WITH warehouse_performance AS (
    SELECT
        warehouse_id,
        AVG(utilization_perct) AS avg_util,
        AVG(on_time_ships_percet) AS avg_on_time_deliv,
        AVG(errors_percet) AS avg_error_rate
    FROM operations
    GROUP BY warehouse_id
)

SELECT
    warehouse_id,
    ROUND(avg_util, 2) AS avg_util,
    ROUND(
        avg_util -
        AVG(avg_util) OVER (),
        2
    ) AS utilization_vs_network,
    ROUND(avg_on_time_deliv, 2) AS avg_on_time_deliv,
    ROUND(
        avg_on_time_deliv -
        AVG(avg_on_time_deliv) OVER (),
        2
    ) AS on_time_vs_network,
    ROUND(avg_error_rate, 2) AS avg_error_rate
FROM warehouse_performance
ORDER BY utilization_vs_network DESC;

--17
-- QUERY: TOP 3 WORST BACKLOG PERIODS WRT WAREHOUSES
WITH ranked_periods AS (
    SELECT
        date,
        warehouse_id,
        shift_id,
        shipments,
        utilization_perct,
        backlog,
        on_time_ships_percet,
        ROW_NUMBER() OVER (
            PARTITION BY warehouse_id
            ORDER BY backlog DESC
        ) AS period_rank
    FROM operations
)

SELECT
    date,
    warehouse_id,
    shift_id,
    shipments,
    utilization_perct,
    backlog,
    on_time_ships_percet,
    period_rank
FROM ranked_periods
WHERE period_rank <= 3
ORDER BY warehouse_id, period_rank;

--18
-- QUERY: FINAL MGMT EXCEPTION REPORT
SELECT
    date,
    warehouse_id,
    shift_id,
    shipments,
    capacity,
    utilization_perct,
    backlog,
    errors_percet,
    on_time_ships_percet,
    CASE
        WHEN utilization_perct >= 100
             AND backlog > 0
             AND on_time_ships_percet < 90
            THEN 'CRITICAL'
        WHEN utilization_perct >= 100
             AND backlog > 0
            THEN 'HIGH'
        WHEN utilization_perct >= 90
             OR backlog > 0
            THEN 'MEDIUM'
        ELSE 'NORMAL'
    END AS operational_risk
FROM operations
ORDER BY
    CASE
        WHEN utilization_perct >= 100
             AND backlog > 0
             AND on_time_ships_percet < 90
            THEN 1
        WHEN utilization_perct >= 100
             AND backlog > 0
            THEN 2
        WHEN utilization_perct >= 90
             OR backlog > 0
            THEN 3
        ELSE 4
    END,
    backlog DESC;




-- =========================================================
   
-- QUERY: warehouse_kpi


SELECT
    warehouse_id,
    SUM(shipments) AS total_shipments,
    SUM(backlog) AS total_backlog,

    ROUND(
        SUM(backlog) * 100.0 / NULLIF(SUM(shipments), 0),
        2
    ) AS backlog_rate_pct,

    ROUND(AVG(utilization_perct), 2) AS avg_util,
    ROUND(AVG(Productivity), 2) AS avg_produc,
    ROUND(AVG(errors_percet), 2) AS avg_error_rate,
    ROUND(AVG(on_time_ships_percet), 2) AS avg_on_time_deliv

FROM operations

GROUP BY warehouse_id

ORDER BY total_shipments DESC; 

-- =========================================================
-- QUERY: shift_kpi

SELECT
    shift_id,
    ROUND(AVG(Productivity), 2) AS avg_produc,
    ROUND(AVG(utilization_perct), 2) AS avg_util,
    SUM(backlog) AS total_backlog,
    ROUND(AVG(errors_percet), 2) AS avg_error_rate,
    ROUND(AVG(on_time_ships_percet), 2) AS avg_on_time_deliv,
    SUM(shipments) AS total_shipments

FROM operations

GROUP BY shift_id

ORDER BY avg_produc DESC;

-- =========================================================
-- QUERY: monthly_kpi
SELECT
    EXTRACT(MONTH FROM date) AS month_number,
    month_nm,

    SUM(shipments) AS total_shipments,

    ROUND(AVG(utilization_perct), 2) AS avg_util,

    SUM(backlog) AS total_backlog,

    ROUND(AVG(errors_percet), 2) AS avg_error_rate,

    ROUND(AVG(on_time_ships_percet), 2) AS avg_on_time_deliv
FROM operations

GROUP BY
    EXTRACT(MONTH FROM date),
    month_nm

ORDER BY month_number;

-- =========================================================
-- QUERY: high_pressure_by_warehouse

SELECT
    warehouse_id,

    COUNT(*) AS total_periods,

    SUM(
        CASE
            WHEN utilization_perct >= 100
             AND backlog > 0
            THEN 1
            ELSE 0
        END
    ) AS high_pressure_periods,

    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN utilization_perct >= 100
                 AND backlog > 0
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS high_pressure_pct,

    ROUND(AVG(utilization_perct), 2) AS avg_util,

    ROUND(AVG(on_time_ships_percet), 2) AS avg_on_time_deliv

FROM operations

GROUP BY warehouse_id

ORDER BY high_pressure_pct DESC;

