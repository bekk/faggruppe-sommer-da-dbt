-- 🥉 BRONSE: reisetider (Oppgave 2.1a)
--
-- Rådataen i RAW har mikset kolonne-casing: Snowflake laget kolonnene med
-- nøyaktig samme store/små bokstaver som i kildefila (f.eks. "strekningId"),
-- og da MÅ de refereres med anførselstegn. Bronselagets jobb er å rydde opp:
-- vi henter kolonnene vi trenger og gir dem rene alias vi kan bruke videre
-- (uten anførselstegn) i sølv og gull.

{{
    config(
        materialized='view'
    )
}}

-- 👉 SKRIV KODEN DIN HER
--
-- Mål: hent de nyttige kolonnene fra kilden 'reisetider' og gi dem rene navn.
-- Hint:
--   * Referer til kilden med source('svv', 'reisetider_raw') (husk doble krøllparenteser)
--   * Rå-kolonner skrives med anførselstegn og RIKTIG casing, og gis et alias:
--       "strekningId" as strekningId
--   * Vi trenger disse: publiseringstidspunkt, strekningId, reisetidType,
--     reisetidVarighetSekunder, reisetidFriFlytVarighetSekunder,
--     reisetidHastighetKmPerTime

select 1 as todo  -- ← bytt ut denne linja med din egen spørring
