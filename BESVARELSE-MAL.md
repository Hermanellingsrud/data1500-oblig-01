# Besvarelse - Refleksjon og Analyse

**Student:** Herman Bayer Ellingsrud

**Studentnummer:** 408418

**Dato:** [Innleveringsdato]

---

## Del 1: Datamodellering

### Oppgave 1.1: Entiteter og attributter

**Identifiserte entiteter:**

Det første jeg gjør for å finne potensielle entiteter er å lete etter substantiver i casen. Dette er substantivene jeg har funnet:

* Sykkelstasjoner
* Kunder
* Sykler
* Låser
* Utleie
* Betalingskort

For å ikke lage irrelevante identiterer basert på oppgaveteksten, filtrerer jeg bort betalingskort. Dette gir meg da fem entiteter:

* Sykkelstasjoner
* Kunder
* Sykler
* Låser
* Utleie

**Attributter for hver entitet:**

Attributtene beskriver egenskapene til en entitet og brukes til å lagre relevant informasjon om objektene i databasen.

Sykkelstasjonene representerer fysiske stasjoner der sykler kan hentes og leveres. Det er derfor viktig å ha unik identifikator for hver stasjon. Systemet må kunne identifisere hver stasjon og vise kunder hvor den ligger.

Attributter for Sykkelstasjoner:
* stasjon_id
* navn
* adresse

Kunder represtenterer personer som bruker sykkelsystemet.Systemet må derfor kunne identifisere kunder og kunne kontakte dem.

Attributter for Kunder:
* kunde_id
* fornavn
* etternavn
* mobilnummer
* epost

Sykkeler representerer hver fysisk sykkel i systemet. tatt_i_bruk_dato er for å kunne spore når sykkelen ble satt i drift.

Attributter for Sykkler:
* sykkel_id
* tatt_i_bruk_dato

Låsene representerer låsemekanismene ved hver stasjon der sykkelene festes.

Attributter for Låser:
* lås_id
* stasjon_id

Utleie representerer selve leieforholdet mellom kunde og sykkel over tid. Det er flere attributter her for å kunne spore hele reisen til sykkelen.

Attributter for Utleie:
* utleie_id
* start_tid
* slutt_tid
* pris
* kunde_id
* sykkel_id
* start_lås_id
* slutt_lås_id

---

### Oppgave 1.2: Datatyper og `CHECK`-constraints

**Valgte datatyper og begrunnelser:**

[Skriv ditt svar her - forklar hvilke datatyper du har valgt for hver attributt og hvorfor]
Sykkelstasjon entiteten består av stasjon_id for å identifisere stasjonen, dette er da en INTEGER. Resten av attributtene er da tekst for informasjon om stasjonen.

| Attributt  | Hva slags data | PostgreSQL type |
|------------|---------------|-----------------|
| stasjon_id | unik id       | INTEGER         |
| navn       | kort tekst    | VARCHAR(50)     |
| adresse    | tekst | VARCHAR(100)    |

Kunde entiteten består av kunde_id for å identifisere kunden, dette blir da INTEGER. Og resten av attributtene bester av tekst for å kunne identifisere og kontakte kunden. Mobilnummer er også tekst for mobilnummeret kan starte med 0 og inneholde +47.

| Attributt   | Hva slags data | PostgreSQL type |
|-------------|----------------|-----------------|
| kunde_id    | unik id        | INTEGER         |
| fornavn     | kort tekst     | VARCHAR(50)     |
| etternavn   | kort tekst | VARCHAR(50)     |
| mobilnummer | kort tkest | VARCHAR(15)     |
| epost       | tekst | VARCHAR(255)    |

Sykkel entiteten består også av en sykkel_id for å identifisere sykkelen (INTEGER). tatt_i_bruk_dato er datoen da sykkelen ble satt i bruk og har derfor datatypen Date.

| Attributt   | Hva slags data | PostgreSQL type |
|-------------|----------------|-----------------|
| sykkel_id    | unik id        | INTEGER         |
| tatt_i_bruk_dato     | dato           | Date            |

Lås entiteten består av to attributter, en lås_id for å identifisere låsen (INTEGER) og stasjon_id for å identifisere hvilken stasjon låsen er på (INTEGER)

| Attributt   | Hva slags data               | PostgreSQL type |
|-------------|------------------------------|-----------------|
| lås_id    | unik id                      | INTEGER         |
| stasjon_id     | ID til stasjonen låsen er på | INTEGER            |

Utleie entiteten...

| Attributt   | Hva slags data | PostgreSQL type |
|-------------|----------------|--|
| utleie_id   | unik id        | INTEGER |
| start_tid   | tidspunkt for start      | TIMESTAMP |
| slutt_tid   | tidspunkt for slutt      | TIMESTAMP |
| pris | beløp          | NUMERIC(6,2) |
| kunde_id       | ID til kunden som leier        | INTEGER |
| sykkel_id   | ID til sykkel som leies      | INTEGER |
| start_lås_id | ID til lås sykkelen låses opp fra          | INTEGER |
| slutt_lås_id       | ID til lås sykkelen leveres tilbake til        | INTEGER |

**`CHECK`-constraints:**

[Skriv ditt svar her - list opp alle CHECK-constraints du har lagt til og forklar hvorfor de er nødvendige]

**ER-diagram:**

[Legg inn mermaid-kode eller eventuelt en bildefil fra `mermaid.live` her]

---

### Oppgave 1.3: Primærnøkler

**Valgte primærnøkler og begrunnelser:**

[Skriv ditt svar her - forklar hvilke primærnøkler du har valgt for hver entitet og hvorfor]

**Naturlige vs. surrogatnøkler:**

[Skriv ditt svar her - diskuter om du har brukt naturlige eller surrogatnøkler og hvorfor]

**Oppdatert ER-diagram:**

[Legg inn mermaid-kode eller eventuelt en bildefil fra `mermaid.live` her]

---

### Oppgave 1.4: Forhold og fremmednøkler

**Identifiserte forhold og kardinalitet:**

[Skriv ditt svar her - list opp alle forholdene mellom entitetene og angi kardinalitet]

**Fremmednøkler:**

[Skriv ditt svar her - list opp alle fremmednøklene og forklar hvordan de implementerer forholdene]

**Oppdatert ER-diagram:**

[Legg inn mermaid-kode eller eventuelt en bildefil fra `mermaid.live` her]

---

### Oppgave 1.5: Normalisering

**Vurdering av 1. normalform (1NF):**

[Skriv ditt svar her - forklar om datamodellen din tilfredsstiller 1NF og hvorfor]

**Vurdering av 2. normalform (2NF):**

[Skriv ditt svar her - forklar om datamodellen din tilfredsstiller 2NF og hvorfor]

**Vurdering av 3. normalform (3NF):**

[Skriv ditt svar her - forklar om datamodellen din tilfredsstiller 3NF og hvorfor]

**Eventuelle justeringer:**

[Skriv ditt svar her - hvis modellen ikke var på 3NF, forklar hvilke justeringer du har gjort]

---

## Del 2: Database-implementering

### Oppgave 2.1: SQL-skript for database-initialisering

**Plassering av SQL-skript:**

[Bekreft at du har lagt SQL-skriptet i `init-scripts/01-init-database.sql`]

**Antall testdata:**

- Kunder: [antall]
- Sykler: [antall]
- Sykkelstasjoner: [antall]
- Låser: [antall]
- Utleier: [antall]

---

### Oppgave 2.2: Kjøre initialiseringsskriptet

**Dokumentasjon av vellykket kjøring:**

[Skriv ditt svar her - f.eks. skjermbilder eller output fra terminalen som viser at databasen ble opprettet uten feil]

**Spørring mot systemkatalogen:**

```sql
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
  AND table_type = 'BASE TABLE'
ORDER BY table_name;
```

**Resultat:**

```
[Skriv resultatet av spørringen her - list opp alle tabellene som ble opprettet]
```

---

## Del 3: Tilgangskontroll

### Oppgave 3.1: Roller og brukere

**SQL for å opprette rolle:**

```sql
[Skriv din SQL-kode for å opprette rollen 'kunde' her]
```

**SQL for å opprette bruker:**

```sql
[Skriv din SQL-kode for å opprette brukeren 'kunde_1' her]
```

**SQL for å tildele rettigheter:**

```sql
[Skriv din SQL-kode for å tildele rettigheter til rollen her]
```

---

### Oppgave 3.2: Begrenset visning for kunder

**SQL for VIEW:**

```sql
[Skriv din SQL-kode for VIEW her]
```

**Ulempe med VIEW vs. POLICIES:**

[Skriv ditt svar her - diskuter minst én ulempe med å bruke VIEW for autorisasjon sammenlignet med POLICIES]

---

## Del 4: Analyse og Refleksjon

### Oppgave 4.1: Lagringskapasitet

**Gitte tall for utleierate:**

- Høysesong (mai-september): 20000 utleier/måned
- Mellomsesong (mars, april, oktober, november): 5000 utleier/måned
- Lavsesong (desember-februar): 500 utleier/måned

**Totalt antall utleier per år:**

[Skriv din utregning her]

**Estimat for lagringskapasitet:**

[Skriv din utregning her - vis hvordan du har beregnet lagringskapasiteten for hver tabell]

**Totalt for første år:**

[Skriv ditt estimat her]

---

### Oppgave 4.2: Flat fil vs. relasjonsdatabase

**Analyse av CSV-filen (`data/utleier.csv`):**

**Problem 1: Redundans**

[Skriv ditt svar her - gi konkrete eksempler fra CSV-filen som viser redundans]

**Problem 2: Inkonsistens**

[Skriv ditt svar her - forklar hvordan redundans kan føre til inkonsistens med eksempler]

**Problem 3: Oppdateringsanomalier**

[Skriv ditt svar her - diskuter slette-, innsettings- og oppdateringsanomalier]

**Fordeler med en indeks:**

[Skriv ditt svar her - forklar hvorfor en indeks ville gjort spørringen mer effektiv]

**Case 1: Indeks passer i RAM**

[Skriv ditt svar her - forklar hvordan indeksen fungerer når den passer i minnet]

**Case 2: Indeks passer ikke i RAM**

[Skriv ditt svar her - forklar hvordan flettesortering kan brukes]

**Datastrukturer i DBMS:**

[Skriv ditt svar her - diskuter B+-tre og hash-indekser]

---

### Oppgave 4.3: Datastrukturer for logging

**Foreslått datastruktur:**

[Skriv ditt svar her - f.eks. heap-fil, LSM-tree, eller annen egnet datastruktur]

**Begrunnelse:**

**Skrive-operasjoner:**

[Skriv ditt svar her - forklar hvorfor datastrukturen er egnet for mange skrive-operasjoner]

**Lese-operasjoner:**

[Skriv ditt svar her - forklar hvordan datastrukturen håndterer sjeldne lese-operasjoner]

---

### Oppgave 4.4: Validering i flerlags-systemer

**Hvor bør validering gjøres:**

[Skriv ditt svar her - argumenter for validering i ett eller flere lag]

**Validering i nettleseren:**

[Skriv ditt svar her - diskuter fordeler og ulemper]

**Validering i applikasjonslaget:**

[Skriv ditt svar her - diskuter fordeler og ulemper]

**Validering i databasen:**

[Skriv ditt svar her - diskuter fordeler og ulemper]

**Konklusjon:**

[Skriv ditt svar her - oppsummer hvor validering bør gjøres og hvorfor]

---

### Oppgave 4.5: Refleksjon over læringsutbytte

**Hva har du lært så langt i emnet:**

[Skriv din refleksjon her - diskuter sentrale konsepter du har lært]

**Hvordan har denne oppgaven bidratt til å oppnå læringsmålene:**

[Skriv din refleksjon her - koble oppgaven til læringsmålene i emnet]

Se oversikt over læringsmålene i en PDF-fil i Canvas https://oslomet.instructure.com/courses/33293/files/folder/Plan%20v%C3%A5ren%202026?preview=4370886

**Hva var mest utfordrende:**

[Skriv din refleksjon her - diskuter hvilke deler av oppgaven som var mest krevende]

**Hva har du lært om databasedesign:**

[Skriv din refleksjon her - reflekter over prosessen med å designe en database fra bunnen av]

---

## Del 5: SQL-spørringer og Automatisk Testing

**Plassering av SQL-spørringer:**

[Bekreft at du har lagt SQL-spørringene i `test-scripts/queries.sql`]


**Eventuelle feil og rettelser:**

[Skriv ditt svar her - hvis noen tester feilet, forklar hva som var feil og hvordan du rettet det]

---

## Del 6: Bonusoppgaver (Valgfri)

### Oppgave 6.1: Trigger for lagerbeholdning

**SQL for trigger:**

```sql
[Skriv din SQL-kode for trigger her, hvis du har løst denne oppgaven]
```

**Forklaring:**

[Skriv ditt svar her - forklar hvordan triggeren fungerer]

**Testing:**

[Skriv ditt svar her - vis hvordan du har testet at triggeren fungerer som forventet]

---

### Oppgave 6.2: Presentasjon

**Lenke til presentasjon:**

[Legg inn lenke til video eller presentasjonsfiler her, hvis du har løst denne oppgaven]

**Hovedpunkter i presentasjonen:**

[Skriv ditt svar her - oppsummer de viktigste punktene du dekket i presentasjonen]

---

**Slutt på besvarelse**
