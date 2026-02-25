-- ============================================================================
-- DATA1500 - Oblig 1: Arbeidskrav I våren 2026
-- Initialiserings-skript for PostgreSQL
-- ============================================================================

-- Opprett grunnleggende tabeller
CREATE TABLE SYKKELSTASJON (
    stasjon_id INTEGER PRIMARY KEY CHECK (stasjon_id > 0),
    navn VARCHAR(50) NOT NULL,
    adresse VARCHAR(100) NOT NULL
);

CREATE TABLE KUNDE (
    kunde_id INTEGER PRIMARY KEY,
    fornavn VARCHAR(50) NOT NULL,
    etternavn VARCHAR(50) NOT NULL,
    mobilnummer VARCHAR(15) NOT NULL CHECK (mobilnummer ~ '^\\+?[0-9]{8,15}$'),
    epost VARCHAR(255) NOT NULL CHECK (epost LIKE '%@%')
);

CREATE TABLE SYKKEL (
    sykkel_id INTEGER PRIMARY KEY,
    tatt_i_bruk_dato DATE NOT NULL CHECK (tatt_i_bruk_dato <= CURRENT_DATE)
);

CREATE TABLE las (
    las_id INTEGER PRIMARY KEY CHECK (las_id > 0),
    stasjon_id INTEGER NOT NULL,
    FOREIGN KEY (stasjon_id) REFERENCES sykkelstasjon(stasjon_id)
);


CREATE TABLE utleie (
    utleie_id INTEGER PRIMARY KEY,
    start_tid TIMESTAMP NOT NULL,
    slutt_tid TIMESTAMP,
    pris NUMERIC(6,2) CHECK (pris >= 0),
    kunde_id INTEGER NOT NULL,
    sykkel_id INTEGER NOT NULL,
    start_las_id INTEGER NOT NULL,
    slutt_las_id INTEGER,
    FOREIGN KEY (kunde_id) REFERENCES kunde(kunde_id),
    FOREIGN KEY (sykkel_id) REFERENCES sykkel(sykkel_id),
    FOREIGN KEY (start_las_id) REFERENCES las(las_id),
    FOREIGN KEY (slutt_las_id) REFERENCES las(las_id)
);

-- Sett inn testdata

-- Sykkelstasjoner (5)
INSERT INTO SYKKELSTASJON (stasjon_id, navn, adresse) VALUES
(1, 'Sentrum', 'Storgata 1'),
(2, 'Skolen', 'Skoleveien 10'),
(3, 'Stasjonen', 'Jernbanegata 5'),
(4, 'Stranden', 'Strandgata 2'),
(5, 'Parken', 'Parkveien 7');

-- Kunder (5)
INSERT INTO KUNDE (kunde_id, fornavn, etternavn, mobilnummer, epost) VALUES
(1, 'Ola', 'Nordmann', '+4712345678', 'ola@nordmann.no'),
(2, 'Kari', 'Nordmann', '+4798765432', 'kari@nordmann.no'),
(3, 'Per', 'Hansen', '+4711122233', 'per@hansen.no'),
(4, 'Anne', 'Larsen', '+4799988877', 'anne@larsen.no'),
(5, 'Nina', 'Olsen', '+4712341234', 'nina@olsen.no');

-- Sykler (100)
INSERT INTO SYKKEL (sykkel_id, tatt_i_bruk_dato)
SELECT generate_series(1,100), CURRENT_DATE - (random()*365)::int;

-- Låser (100, 20 per stasjon)
INSERT INTO las (las_id, stasjon_id)
SELECT i, ((i-1)/20 +1)::int
FROM generate_series(1,100) AS s(i);

-- Utleie (50)
INSERT INTO utleie (utleie_id, start_tid, slutt_tid, pris, kunde_id, sykkel_id, start_las_id, slutt_las_id)
SELECT
    i,
    CURRENT_DATE + time '08:00',
    CURRENT_DATE + time '09:00',
    29.90,
    ((i-1) % 5 + 1),
    ((i-1) % 100 + 1),
    ((i-1) % 100 + 1),
    ((i-1) % 100 + 1)
FROM generate_series(1,50) AS s(i);


-- DBA setninger (rolle: kunde, bruker: kunde_1)

-- Opprett rolle
CREATE ROLE kunde;

-- Opprett eksempelbruker og gi rolle
CREATE USER kunde_1 WITH PASSWORD 'passord123';
GRANT kunde TO kunde_1;

-- oppretter veiw
CREATE VIEW kunde_utleie_view AS
SELECT
    u.utleie_id,
    u.start_tid,
    u.slutt_tid,
    u.pris,
    k.fornavn,
    k.etternavn,
    s.navn AS stasjon_start,
    s2.navn AS stasjon_slutt
FROM utleie u
JOIN kunde k ON u.kunde_id = k.kunde_id
JOIN las l1 ON u.start_las_id = l1.las_id
JOIN sykkelstasjon s ON l1.stasjon_id = s.stasjon_id
JOIN las l2 ON u.slutt_las_id = l2.las_id
JOIN sykkelstasjon s2 ON l2.stasjon_id = s2.stasjon_id;


GRANT SELECT ON kunde_utleie_view TO kunde;



-- Eventuelt: Opprett indekser for ytelse



-- Vis at initialisering er fullført (kan se i loggen fra "docker-compose log"
SELECT 'Database initialisert!' as status;