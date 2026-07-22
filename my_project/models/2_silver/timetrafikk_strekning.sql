-- 🥈 SØLV: timetrafikk_strekning (Oppgave 2.4.2)
--
-- Kobler timetrafikken (antall biler per time per punkt) til riktig strekning
-- ved hjelp av koblingstabellen strekning_trp (som du laster inn med `dbt seed`).

{{
    config(
        materialized='table'
    )
}}

-- 👉 SKRIV KODEN DIN HER
--
-- Mål: koble timetrafikk til strekning via strekning_trp.
-- Hint:
--   * strekning_trp er en seed:            ref('strekning_trp')
--   * timetrafikk er det ferdige bronse-produktet:  ref('timetrafikk')
--     (begge skrives i doble krøllparenteser)
--   * Join på trafikkregistreringspunktet:  timetrafikk.trpId = strekning_trp.trp_id
--   * Ta med: strekning (navnet), trpId, tidspunkt og trafikk

select 1 as todo  -- ← bytt ut denne linja med din egen spørring
