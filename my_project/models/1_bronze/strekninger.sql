-- 🥉 BRONSE: strekninger (Oppgave 2.1b)
--
-- Samme øvelse som for reisetider: rydd opp i casing og hent bare det vi trenger.
-- (Geografi-kolonnen 'koordinater' er allerede droppet ved eksport, så den er
-- ikke i RAW.)
--
-- ⚠️ Her lurer en felle: rådataen har 2347 rader, men bare 237 unike strekninger.
-- Kilden er nemlig 11 snapshots av den samme lista, tatt på ulike tidspunkt.
-- Fjerner du ikke duplikatene, blåser joinen i oppgave 2.2 opp fra 21 mill. til
-- over 200 mill. rader. Bronselaget rydder opp i dette også!

{{
    config(
        materialized='view'
    )
}}

-- 👉 SKRIV KODEN DIN HER
--
-- Mål: hent id, navn og versjon fra kilden 'strekninger' med rene alias,
--      og behold bare ÉN rad per strekning.
-- Hint:
--   * kilde: source('svv', 'strekninger_raw')  (husk doble krøllparenteser)
--   * "id" as id,  "navn" as navn,  "versjon" as versjon
--   * Dedupliser med QUALIFY — en Snowflake-godbit som filtrerer på
--     vindusfunksjoner (slik HAVING gjør for GROUP BY). Behold nyeste rad per id:
--       qualify row_number() over (
--           partition by "id" order by "publiseringstidspunkt" desc
--       ) = 1
--   * NB: 'versjon' er '1' for alle radene, så den kan du ikke bruke til å skille.
--   * Fasit: modellen skal gi 237 rader.

select 1 as todo  -- ← bytt ut denne linja med din egen spørring
