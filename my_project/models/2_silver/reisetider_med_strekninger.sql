-- 🥈 SØLV: reisetider_med_strekninger (Oppgave 2.2)
--
-- Kobler reisetider mot strekninger slik at vi får med navnet på strekningen
-- (ikke bare en id). Siden bronselaget alt har ryddet opp i casing, kan vi nå
-- bruke rene kolonnenavn uten anførselstegn.

{{
    config(
        materialized='table'
    )
}}

-- 👉 SKRIV KODEN DIN HER
--
-- Mål: join reisetider mot strekninger og ta med strekningsnavnet.
-- Hint:
--   * Bygg på ANDRE MODELLER med ref():  ref('reisetider') og ref('strekninger')  (doble krøllparenteser)
--   * Join-nøkkel: reisetider.strekningId = strekninger.id  (begge er tekst)
--   * Konverter publiseringstidspunkt til norsk tid:
--       convert_timezone('UTC', 'Europe/Oslo', r.publiseringstidspunkt)
--   * Filtrer bort åpenbart feil målinger:
--       reisetidVarighetSekunder is null
--       or reisetidVarighetSekunder / reisetidFriFlytVarighetSekunder < 70
--   * Ta med: strekningId, publiseringstidspunkt (norsk tid), reisetidVarighetSekunder,
--     reisetidFriFlytVarighetSekunder og s.navn

select 1 as todo  -- ← bytt ut denne linja med din egen spørring
