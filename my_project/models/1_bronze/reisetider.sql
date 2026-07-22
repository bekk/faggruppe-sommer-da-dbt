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
--   * ⏰ publiseringstidspunkt er IKKE et tidspunkt i rådataen! Det er et TALL
--     (mikrosekunder siden 1970). Gjør det om til et ekte tidspunkt med:
--       to_timestamp_ntz("publiseringstidspunkt", 6)   -- 6 = mikrosekunder
--     Uten dette kræsjer sølvlaget når det skal regne på tid.
--   * Vi trenger disse: publiseringstidspunkt, strekningId, reisetidType,
--     reisetidVarighetSekunder, reisetidFriFlytVarighetSekunder,
--     reisetidHastighetKmPerTime
--   * 💸 Rådataen har 121 mill. rader (2017–2022). Vi holder oss til 2022 så
--     workshopen går raskt — legg på en WHERE nederst:
--       where to_timestamp_ntz("publiseringstidspunkt", 6) >= '2022-01-01'
--   * Fasit: modellen skal gi ca. 21,4 mill. rader.

select 1 as todo  -- ← bytt ut denne linja med din egen spørring
