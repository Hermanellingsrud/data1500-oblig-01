-- ============================================================================
-- DATA1500 - Oblig 1: Arbeidskrav I våren 2026
-- Initialiserings-skript for PostgreSQL
-- ============================================================================

-- Opprett grunnleggende tabeller
CREATE TABLE SYKKELSTASJON (
    stasjon_id INTEGER PRIMARY KEY,
    navn VARCHAR(50) NOT NULL,
    adresse VARCHAR(100) NOT NULL
);

CREATE TABLE KUNDE (
    kunde_id INTEGER PRIMARY KEY,
    fornavn VARCHAR(50) NOT NULL,
    etternavn VARCHAR(50) NOT NULL,
    mobilnummer VARCHAR(15) NOT NULL,
    epost VARCHAR(255) NOT NULL
);

CREATE TABLE SYKKEL (
    sykkel_id INTEGER PRIMARY KEY,
    tatt_i_bruk_dato DATE NOT NULL
);

CREATE TABLE LÅS (
    lås_id INTEGER PRIMARY KEY,
    stasjon_id INTEGER NOT NULL,
    FOREIGN KEY (stasjon_id) REFERENCES SYKKELSTASJON(stasjon_id)
);

CREATE TABLE UTLEIE (
    utleie_id INTEGER PRIMARY KEY,
    start_tid TIMESTAMP NOT NULL,
    slutt_tid TIMESTAMP,
    pris NUMERIC(6,2),
    kunde_id INTEGER NOT NULL,
    sykkel_id INTEGER NOT NULL,
    start_lås_id INTEGER NOT NULL,
    slutt_lås_id INTEGER,
    FOREIGN KEY (kunde_id) REFERENCES KUNDE(kunde_id),
    FOREIGN KEY (sykkel_id) REFERENCES SYKKEL(sykkel_id),
    FOREIGN KEY (start_lås_id) REFERENCES LÅS(lås_id),
    FOREIGN KEY (slutt_lås_id) REFERENCES LÅS(lås_id)
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
INSERT INTO LÅS (lås_id, stasjon_id)
SELECT i, ((i-1)/20 +1)::int
FROM generate_series(1,100) AS s(i);

-- Utleier (50)
INSERT INTO UTLEIE (utleie_id, start_tid, slutt_tid, pris, kunde_id, sykkel_id, start_lås_id, slutt_lås_id)
SELECT
    i,
    CURRENT_DATE - (random()*30)::int + (random()*interval '2 hours') AS start_tid,
    start_tid + (random()*interval '2 hours') AS slutt_tid,
    (random()*50)::numeric(6,2),
    ((i-1) % 5 + 1),
    ((i-1) % 100 + 1),
    ((i-1) % 100 + 1),
    ((i-1) % 100 + 1)
FROM generate_series(1,50) AS s(i);


-- DBA setninger (rolle: kunde, bruker: kunde_1)



-- Eventuelt: Opprett indekser for ytelse



-- Vis at initialisering er fullført (kan se i loggen fra "docker-compose log"
SELECT 'Database initialisert!' as status;