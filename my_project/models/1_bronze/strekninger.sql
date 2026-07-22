-- 🥉 BRONSE: strekninger (Oppgave 2.1b)
--
-- Samme øvelse som for reisetider: rydd opp i casing og hent bare det vi trenger.
-- (Geografi-kolonnen 'koordinater' er allerede droppet ved eksport, så den er
-- ikke i RAW.)

{{
    config(
        materialized='view'
    )
}}

-- 👉 SKRIV KODEN DIN HER
--
-- Mål: hent id, navn og versjon fra kilden 'strekninger' med rene alias.
-- Hint:
--   * kilde: source('svv', 'strekninger_raw')  (husk doble krøllparenteser)
--   * "id" as id,  "navn" as navn,  "versjon" as versjon

select 1 as todo  -- ← bytt ut denne linja med din egen spørring
