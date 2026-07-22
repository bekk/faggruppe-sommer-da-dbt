-- ✅ TEST: god datakvalitet på reisetider_med_time (Oppgave 2.5.1)
--
-- I dbt er en test bare en SELECT: testen FEILER dersom spørringen returnerer
-- én eller flere rader. Vi definerer "god kvalitet" som minst 10 femminutters-
-- målinger i hver time (10 * 5 = 50 min dekning). Vi vil altså finne radene som
-- IKKE oppfyller kravet.
--
-- Kjør testen med:  dbt test -s reisetider_god_kvalitet

-- 👉 SKRIV KODEN DIN HER
--
-- Mål: returner rader fra reisetider_med_time som har for få femminuttere (< 10).
-- Hint: ref('reisetider_med_time') (doble krøllparenteser) og WHERE antallFemMinutt < 10

select 1 as todo  -- ← bytt ut denne linja med din egen spørring
where 1 = 0        -- (dummy slik at skjelettet ikke feiler før du har skrevet testen)
