-- 🥉 BRONSE: timetrafikk  (FERDIG LAGET FOR DEG ✅)
--
-- timetrafikk kommer som rå, dypt nøstet data fra Vegvesenets trafikkdata-API.
-- Å pakke ut nøstede strukturer i Snowflake er litt fiklete, så denne modellen
-- er skrevet ferdig for deg. Du trenger ikke endre den – bare referer til den
-- med ref('timetrafikk') i oppgave 2.4.2.
--
-- Legg merke til tre ting:
--   * "from" er et reservert ord i Snowflake -> må ha anførselstegn
--   * "total":volumeNumbers:volume plukker ut ett tall inne i en nøstet struktur
--     (kolon-notasjon for semistrukturerte felt), og ::integer caster det
--   * Vi bruker TOTAL trafikk forbi punktet (begge retninger samlet). Den
--     originale workshopen skilte på retning, men rådataen her har retning dypt
--     nøstet, så vi forenkler til totaltrafikk per punkt per time.

{{
    config(
        materialized='view'
    )
}}

select
    "trpId"                                as trpId,
    "from"                                 as tidspunkt,
    "total":volumeNumbers:volume::integer  as trafikk
from {{ source('svv', 'timetrafikk_raw') }}
