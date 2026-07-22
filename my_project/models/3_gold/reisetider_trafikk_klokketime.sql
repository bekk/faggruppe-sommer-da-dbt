-- 🥇 GULL (view): reisetider_trafikk_klokketime (Oppgave 2.7)
--
-- Vi ønsker å se mønstre som gjentar seg: typisk reisetid og trafikk for hver
-- ukedag og klokketime. Siden dette bare er en liten analyse-nyanse oppå et
-- eksisterende gullprodukt, lager vi det som et VIEW oppå gullproduktet.

{{
    config(
        materialized='view'
    )
}}

-- 👉 SKRIV KODEN DIN HER
--
-- Mål: snitt av reisetid og trafikk per strekning, ukedag og klokketime.
-- Hint:
--   * Bygg på ref('reisetider_med_trafikk')  (doble krøllparenteser)
--   * Klokketime:  HOUR(timesbolk)
--   * Ukedag (mandag=1 ... søndag=7): bruk DAYOFWEEKISO(timesbolk)
--       (Snowflake gjør her jobben BigQuery trengte en modulo-triks for.)
--   * AVG(reisetidGjennomsnitt) og AVG(trafikk)
--   * GROUP BY navn, ukedag, klokketime

select 1 as todo  -- ← bytt ut denne linja med din egen spørring
