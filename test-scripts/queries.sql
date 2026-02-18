-- ============================================================================
-- TEST-SKRIPT FOR OBLIG 1
-- ============================================================================

-- Kjør med: docker-compose exec postgres psql -h -U admin -d data1500_db -f test-scripts/queries.sql

-- 5.1: Alle sykler
SELECT *
FROM sykkel;

-- 5.2: Etternavn, fornavn og mobilnummer for alle kunder, sortert alfabetisk på etternavn
SELECT etternavn, fornavn, mobilnummer
FROM kunde
ORDER BY etternavn;

-- 5.3: Alle sykler tatt i bruk etter dato
SELECT *
FROM sykkel
WHERE tatt_i_bruk_dato > '2025-07-02'; -- må kanskje endre utleie i 01-init-database.sql

-- 5.4: Antall kunder i bysykkelordningen
SELECT COUNT(*) AS antall_kunder
FROM kunde;

-- 5.5: Alle kunder med antall utleieforhold, inkludert de som ikke har leid
SELECT k.kunde_id, k.fornavn, k.etternavn, COUNT(u.utleie_id) AS antall_utleie
From kunde k
LEFT JOIN utleie u ON k.kunde_id = u.kunde_id
GROUP BY k.kunde_id, k.fornavn, k.etternavn
ORDER BY k.etternavn;

-- 5.6: Kunder som aldri har leid en sykkel
SELECT k.kunde_id, k.fornavn, k.etternavn
FROM kunde k
LEFT JOIN utleie u ON k.kunde_id = u.kunde_id
WHERE u.utleie_id IS NULL;

-- 5.7: Sykler som aldri har vært utleid
SELECT s.sykkel_id
FROM sykkel s
LEFT JOIN utleie u ON s.sykkel_id = u.sykkel_id
WHERE u.utleie_id IS NULL;

-- 5.8: Sykler som ikke er levert tilbake etter ett døgn med kundeinfo
SELECT s.sykkel_id, k.kunde_id, k.fornavn, k.etternavn
FROM sykkel s
JOIN utleie u ON s.sykkel_id = u.sykkel_id
JOIN kunde k ON u.kunde_id = k.kunde_id
WHERE u.slutt_tid > u.start_tid + INTERVAL '1 day';


-- En test med en SQL-spørring mot metadata i PostgreSQL (kan slettes fra din script)
select nspname as schema_name from pg_catalog.pg_namespace;
