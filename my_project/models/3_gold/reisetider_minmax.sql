-- 🥇 GULL: reisetider_minmax (Oppgave 2.3)
--
-- Gullproduktene er spissede analyser bygget på de gjenbrukbare sølvproduktene.
-- Her regner vi ut korteste og lengste reisetid per strekning.

{{
    config(
        materialized='table'
    )
}}

-- 👉 SKRIV KODEN DIN HER
--
-- Mål: min og maks reisetid per strekningsnavn.
-- Hint:
--   * Bygg på sølvproduktet: ref('reisetider_med_strekninger')  (doble krøllparenteser)
--   * Bruk MAX(reisetidVarighetSekunder), MIN(reisetidVarighetSekunder)
--   * GROUP BY navn

select 1 as todo  -- ← bytt ut denne linja med din egen spørring
