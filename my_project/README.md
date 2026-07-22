# my_project (dbt-prosjektet for workshopen)

Dette er selve dbt-prosjektet du jobber i under workshopen. Den fullstendige guiden med
oppgaver og løsningsforslag ligger i **[README-en i repo-rot](../README.md)**.

Kort oppsummert:

```bash
cd my_project
dbt debug     # sjekk tilkoblingen (husk å fylle inn din bruker i profiles.yml først)
dbt seed      # last inn seeds/strekning_trp.csv
dbt run       # bygg modellene
dbt test      # kjør testene
dbt docs generate && dbt docs serve   # dokumentasjon + avhengighetsgraf
```

Mappestruktur: `models/1_bronze` (🥉 view), `models/2_silver` (🥈 table),
`models/3_gold` (🥇 table/view), `seeds/`, `tests/`.
