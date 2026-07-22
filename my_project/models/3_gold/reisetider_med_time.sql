-- 🥇 GULL: reisetider_med_time (Oppgave 2.5)
--
-- Reisetider publiseres hvert 5. minutt. For å kunne koble mot timetrafikk
-- (som er per time) aggregerer vi reisetidene opp til timesnivå, og teller
-- hvor mange fem-minutters-målinger som inngår i hvert snitt (maks 12 per time).

{{
    config(
        materialized='table'
    )
}}

-- 👉 SKRIV KODEN DIN HER
--
-- Mål: gjennomsnittlig reisetid per strekning per time.
-- Hint:
--   * Bygg på sølvproduktet: ref('reisetider_med_strekninger')  (doble krøllparenteser)
--   * Finn hvilken time hvert femminutt hører til. I Snowflake:
--       DATE_TRUNC('HOUR', publiseringstidspunkt)   -- gir f.eks. 14:00 for 14:35
--     Kall kolonnen 'timesbolk' ('time' er et reservert ord i Snowflake).
--   * AVG(reisetidVarighetSekunder) som reisetidGjennomsnitt
--   * COUNT(reisetidVarighetSekunder) som antallFemMinutt
--     NB: bruk COUNT(kolonne), ikke COUNT(*)! Mange femminutter mangler måling
--     (verdien er NULL), og de skal ikke telle som dekning. COUNT(kolonne)
--     hopper over NULL — COUNT(*) teller alle radene.
--   * GROUP BY timesbolk, strekningId, navn
--
-- NB! Oppgave 2.5.2: etter at du har skrevet testen (tests/reisetider_god_kvalitet.sql)
-- vil den FEILE. Kom tilbake hit og filtrer vekk timer med for få målinger, f.eks.
-- med en HAVING-linje (HAVING skal stå ETTER GROUP BY):
--       having count(reisetidVarighetSekunder) > 9

select 1 as todo  -- ← bytt ut denne linja med din egen spørring
