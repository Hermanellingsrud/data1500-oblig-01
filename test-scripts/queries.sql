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

-- 5.3: Alle sykler tatt i bruk etter 1. april 2023
SELECT *
FROM sykkel
WHERE tatt_i_bruk_dato > '2023-04-01'; -- må kanskje endre utleie i 01-init-database.sql

-- 5.4: Antall kunder i bysykkelordningen
SELECT COUNT(*) AS antall_kunder
FROM kunde;

-- 5.5: Alle kunder med antall utleieforhold, inkludert de som ikke har leid

-- 5.6: Kunder som aldri har leid en sykkel

-- 5.7: Sykler som aldri har vært utleid

-- 5.8: Sykler som ikke er levert tilbake etter ett døgn med kundeinfo


-- En test med en SQL-spørring mot metadata i PostgreSQL (kan slettes fra din script)
select nspname as schema_name from pg_catalog.pg_namespace;
