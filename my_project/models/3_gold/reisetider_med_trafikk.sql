-- 🥇 GULL: reisetider_med_trafikk (Oppgave 2.6)
--
-- Her slår vi endelig sammen trafikktall og reisetider per time, for å kunne se
-- sammenhengen mellom de to.
--
-- NB om god praksis: vi vil IKKE bygge gullprodukt oppå gullprodukt. I stedet for
-- å referere til gullproduktet reisetider_med_time, gjenbruker vi logikken derfra
-- (aggregering til timesnivå) og kobler mot sølvproduktet timetrafikk_strekning.

{{
    config(
        materialized='table'
    )
}}

-- 👉 SKRIV KODEN DIN HER
--
-- Hint:
--   * Lag en CTE som aggregerer reisetider til timesnivå (samme logikk som i
--     reisetider_med_time), basert på ref('reisetider_med_strekninger')
--   * Join mot ref('timetrafikk_strekning') på:
--       strekningsnavn = strekning  OG  timesbolk = trafikkens tidspunkt
--     Husk tidssone på trafikkens tidspunkt:
--       CONVERT_TIMEZONE('UTC', 'Europe/Oslo', t.tidspunkt)
--   * Ta med bl.a. navn, timesbolk, reisetidGjennomsnitt, antallFemMinutt, trafikk

select 1 as todo  -- ← bytt ut denne linja med din egen spørring
