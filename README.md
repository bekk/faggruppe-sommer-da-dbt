# dbt-workshop med Snowflake 🪁❄️

En introduksjon til **dbt** og **medaljearkitektur** (bronse/sølv/gull) med reisetids-data
fra Statens vegvesen — kjørt mot **Snowflake**.

Dette er den samme workshopen som den originale BigQuery-versjonen
(`jogga_dbt_intro_workshop.ipynb`), men skrevet om til en README du følger steg for steg,
og tilpasset ekte, litt rotete rådata i Snowflake. Du løser oppgavene ved å skrive kode
direkte i `.sql`-filene i `my_project/` — hver fil er markert med `-- 👉 SKRIV KODEN DIN HER`.
Sitter du fast, kan du åpne **Løsningsforslag** under hver oppgave.

---

## Før du starter 🏁

Vi bygger datamodeller på et datasett med **reisetider** fra Vegvesenet, og kobler det etter
hvert mot **timetrafikk** (antall biler per time). Rådataen er ekte og litt rå: kolonnene har
mikset store/små bokstaver, noen tabeller er dypt nøstet, og navnene er på norsk. En viktig del
av jobben — og en god lærdom — er at **bronselaget rydder opp** i dette.

Mer kompliserte transformasjoner reiser noen spørsmål:
- Hvordan tester vi at dataen fortsatt er gyldig?
- Hvordan kontrollerer vi hva som har skjedd med dataen på veien (lineage)?
- Hvordan reduserer vi kostnader ved kun å kjøre nødvendige spørringer?

Alt dette kan adresseres med transformasjonsverktøyet **dbt** ⚡️

### Medaljearkitektur i korte trekk

- 🥉 **Bronse** – tynne, oppryddede kopier av kildedataen: fikser kolonnenavn/typer, pakker ut
  nøstede felt (typisk `view`).
- 🥈 **Sølv** – berikede og sammenkoblede tabeller som er gjenbrukbare (typisk `table`).
- 🥇 **Gull** – spissede analyser bygget på sølvproduktene (typisk `table` eller `view`).

---

## Kom i gang lokalt 💻

Du trenger Python 3.11+ og tilgangsdetaljer til Snowflake (brukernavn, passord og
skjemanavn) fra arrangøren.

**1. Klon repoet og lag et virtuelt miljø** (fra repo-rot):

```bash
python3 -m venv dbt-venv
source dbt-venv/bin/activate        # Windows: dbt-venv\Scripts\activate
pip install -r requirements.txt
```

**2. Fyll inn din egen bruker i `my_project/profiles.yml`:**

```yaml
      user: DITT_BRUKERNAVN          # 👈 fra arrangøren
      password: DITT_PASSORD         # 👈 fra arrangøren
      schema: WORKSHOP_DITT_NAVN     # 👈 ditt eget skjema, f.eks. WORKSHOP_OLA
```

> ⚠️ **Ikke** sett `schema` til `RAW`. Det er **kildeskjemaet** med rådata som alle leser fra.
> Dine egne modeller skal bygges i **ditt eget** skjema. dbt oppretter skjemaet automatisk
> første gang du kjører `dbt run`.

**3. Test tilkoblingen:**

```bash
cd my_project
dbt debug
```

Får du `All checks passed!`, er du klar 🎉

### 🔤 Én ting du bør vite om rådataen: casing

Rådataen ligger i `FAGGRUPPE_DB.RAW`, lastet inn fra Parquet-filer. Snowflake laget da
kolonnene med **nøyaktig samme store/små bokstaver** som i filene, f.eks. `strekningId`. Slike
kolonner blir _case-sensitive_ og må skrives med **anførselstegn** for å leses:

```sql
select "strekningId" from raw.reisetider;   -- ✅ virker
select strekningId   from raw.reisetider;   -- ❌ Snowflake leter etter STREKNINGID
```

Derfor gjør vi det ryddige én gang i **bronselaget**: vi gir hver rå-kolonne et rent alias, og
etter det slipper vi anførselstegn i sølv og gull.

### Prosjektstruktur

```
my_project/
├── models/
│   ├── sources.yml                 # kildetabeller (leses fra RAW)
│   ├── schema.yml                  # dokumentasjon + tester
│   ├── 1_bronze/                   # 🥉 view-modeller (rydder opp)
│   │   └── timetrafikk.sql         #     ← ferdig laget for deg
│   ├── 2_silver/                   # 🥈 table-modeller
│   └── 3_gold/                     # 🥇 table/view-modeller
├── seeds/
│   └── strekning_trp.csv           # liten CSV lastet inn med `dbt seed`
├── tests/
│   └── reisetider_god_kvalitet.sql # egendefinert datakvalitetstest
├── dbt_project.yml
└── profiles.yml                    # din tilkobling (fyll inn din bruker)
```

---

## Oppgave 2.1a: Bronseproduktet `reisetider` 🥉

Kildetabellene er definert i `models/sources.yml` (`svv`-kilden peker på `FAGGRUPPE_DB.RAW`).
Åpne **`my_project/models/1_bronze/reisetider.sql`**. Modellen materialiseres som `view`. Skriv
en `SELECT` som henter kolonnene vi trenger og gir dem rene alias (jf. casing-boksen over).

Vi trenger: `publiseringstidspunkt`, `strekningId`, `reisetidType`, `reisetidVarighetSekunder`,
`reisetidFriFlytVarighetSekunder`, `reisetidHastighetKmPerTime`.

> 🚨 **NB!** Ikke referer til `RAW.reisetider` direkte — bruk
> [`source()`-funksjonen](https://docs.getdbt.com/reference/dbt-jinja-functions/source) så dbt
> forstår avhengigheten (lineage). Kilden heter `reisetider_raw` i dbt (den peker på
> `RAW.reisetider`) — dette for at bronse-modellen skal kunne hete `reisetider` uten
> navnekollisjon. Se kommentaren i `sources.yml`.

<details>
<summary>💡 Løsningsforslag</summary>

```sql
{{
    config(
        materialized='view'
    )
}}

select
    "publiseringstidspunkt"            as publiseringstidspunkt,
    "strekningId"                      as strekningId,
    "reisetidType"                     as reisetidType,
    "reisetidVarighetSekunder"         as reisetidVarighetSekunder,
    "reisetidFriFlytVarighetSekunder"  as reisetidFriFlytVarighetSekunder,
    "reisetidHastighetKmPerTime"       as reisetidHastighetKmPerTime
from {{ source('svv', 'reisetider_raw') }}
```

> 🔎 Den originale BigQuery-workshopen castet `strekningId` til heltall her. I disse dataene er
> både `reisetider.strekningId` og `strekninger.id` tekst, så vi lar dem være tekst og joiner
> tekst mot tekst. Selve opprydningen (casing) er transformasjonen vår i bronse.

</details>

---

## Oppgave 2.1b: Bronseproduktet `strekninger` 🥉

Gjør det samme for `strekninger`. Tabellen ligger allerede som kilde i `sources.yml`. Vi trenger
`id`, `navn` og `versjon`. Skriv modellen i **`my_project/models/1_bronze/strekninger.sql`**.

<details>
<summary>💡 Løsningsforslag</summary>

```sql
{{
    config(
        materialized='view'
    )
}}

select
    "id"       as id,
    "navn"     as navn,
    "versjon"  as versjon
from {{ source('svv', 'strekninger_raw') }}
```

</details>

> 💡 **timetrafikk** er også et bronseprodukt, men det er **ferdig laget for deg** i
> `models/1_bronze/timetrafikk.sql`, fordi rådataen der er dypt nøstet. Ta gjerne en titt — du
> bruker den i oppgave 2.4.2.

---

## Kjøre dbt selektivt for å spare tid og penger 💸

Nå kan vi lage tabellene i Snowflake med `dbt run` (kjøres inne i `my_project/`).

Kjører du `dbt run` uten argumenter, bygges **alle** modellene hver gang. Bruk `-s` (select)
for å kjøre bare det du trenger:

```bash
# Bare én modell:
dbt run -s strekninger

# Én modell OG alt som avhenger av den (nedstrøms):
dbt run -s reisetider_med_strekninger+
```

👉 Kjør nå `dbt run -s reisetider` og `dbt run -s strekninger`.

---

## Oppgave 2.2: Sølvproduktet `reisetider_med_strekninger` 🥈

Vi vil se reisetider med **navnet** på strekningen. Lag sølvproduktet i
**`my_project/models/2_silver/reisetider_med_strekninger.sql`** (materialiseres som `table`).
Join reisetider mot strekninger på `reisetider.strekningId = strekninger.id`.

> 🚨 **NB!** Nå bygger vi videre på **andre modeller** (ikke kilder). Bruk
> [`ref()`-funksjonen](https://docs.getdbt.com/reference/dbt-jinja-functions/ref).

<details>
<summary>💡 Løsningsforslag</summary>

```sql
{{
    config(
        materialized='table'
    )
}}

select
    r.strekningId,
    convert_timezone('UTC', 'Europe/Oslo', r.publiseringstidspunkt) as publiseringstidspunkt,
    r.reisetidVarighetSekunder,
    r.reisetidFriFlytVarighetSekunder,
    s.navn
from {{ ref('reisetider') }} as r
join {{ ref('strekninger') }} as s
    on r.strekningId = s.id
where r.reisetidVarighetSekunder is null
   or r.reisetidVarighetSekunder / r.reisetidFriFlytVarighetSekunder < 70
```

> 🔎 **Snowflake vs BigQuery:** BigQuery konverterer tidssone med `DATETIME(ts, "Europe/Oslo")`.
> I Snowflake bruker vi `CONVERT_TIMEZONE('UTC', 'Europe/Oslo', ts)` (rådataen er lagret i UTC).
> Merk også: den originale workshopen hadde et `version = "2"`-filter — den kolonnen finnes ikke
> i disse dataene, så vi har droppet det.

</details>

### Vise dbt-docs 📚

```bash
dbt docs generate
dbt docs serve
```

La gjerne `dbt docs serve` kjøre i en egen terminal. Trykk på grafsymbolet nederst til høyre for
å se avhengighetsgrafen mellom kilder og modeller.

---

## Oppgave 2.3: Gullproduktet `reisetider_minmax` 🥇

Lag gullproduktet i **`my_project/models/3_gold/reisetider_minmax.sql`** som regner ut minste og
største reisetid per strekning.

<details>
<summary>💡 Løsningsforslag</summary>

```sql
{{
    config(
        materialized='table'
    )
}}

select
    navn,
    max(reisetidVarighetSekunder) as maxReisetid,
    min(reisetidVarighetSekunder) as minReisetid
from {{ ref('reisetider_med_strekninger') }}
group by navn
```

</details>

---

## Oppgave 2.4: Koble timetrafikk til strekning 🚗

Vi vil finne sammenhengen mellom trafikkmengde og reisetid. Vegvesenet måler antall biler per
time ved ca. 2500 trafikkregistreringspunkter (TRP). Først må vi vite hvilket TRP som hører til
hvilken strekning.

> ℹ️ **Forenkling:** I disse dataene ligger retning dypt nøstet, så vi bruker **totaltrafikk**
> forbi hvert punkt (begge retninger samlet). Derfor kobler vi bare på TRP-id, ikke retning.

### Oppgave 2.4.1: Last inn koblingsfil med `dbt seed`

Koblingen mellom strekning og TRP er laget manuelt i **`my_project/seeds/strekning_trp.csv`**
(kolonner: `strekning`, `trp_id`). `dbt seed` laster små, statiske CSV-filer inn i
datavarehuset:

```bash
dbt seed
```

Etterpå kan du referere til seeden med `ref('strekning_trp')`.

> ℹ️ Verdiene i CSV-en er satt opp av arrangøren for de aktuelle strekningene.

### Oppgave 2.4.2: Koble timetrafikk til strekning

`timetrafikk` er ferdig laget som bronseprodukt for deg (`models/1_bronze/timetrafikk.sql`
pakker ut de nøstede feltene til `trpId`, `tidspunkt` og `trafikk`). Koble den mot
`strekning_trp` på `trpId`. Skriv modellen i
**`my_project/models/2_silver/timetrafikk_strekning.sql`**.

Bør dette være bronse, sølv eller gull? 🤔 (Her passer sølv fint.)

<details>
<summary>💡 Løsningsforslag</summary>

```sql
{{
    config(
        materialized='table'
    )
}}

select
    s.strekning,
    t.trpId,
    t.tidspunkt,
    t.trafikk
from {{ ref('strekning_trp') }} as s
join {{ ref('timetrafikk') }} as t
    on t.trpId = s.trp_id
```

</details>

---

## Oppgave 2.5: Gjennomsnittlig reisetid per time 🥇

Trafikktallene er per time, mens reisetider publiseres hvert 5. minutt. Vi aggregerer derfor
reisetid opp til timesnivå, og teller hvor mange fem-minutters-målinger som inngår i hvert snitt
(best case 12 per time) — det sier noe om dekningsgraden.

Skriv gullproduktet i **`my_project/models/3_gold/reisetider_med_time.sql`**.

> 💡 I Snowflake finner du hvilken time et femminutt hører til med
> `DATE_TRUNC('HOUR', publiseringstidspunkt)`. Vi kaller kolonnen `timesbolk` — `time` er et
> reservert ord i Snowflake.

<details>
<summary>💡 Løsningsforslag</summary>

```sql
{{
    config(
        materialized='table'
    )
}}

with reisetider_med_time as (
    select
        *,
        date_trunc('HOUR', publiseringstidspunkt) as timesbolk
    from {{ ref('reisetider_med_strekninger') }}
)

select
    navn,
    timesbolk,
    strekningId,
    avg(reisetidVarighetSekunder) as reisetidGjennomsnitt,
    count(*) as antallFemMinutt
from reisetider_med_time
group by timesbolk, strekningId, navn
```

</details>

### Oppgave 2.5.1: Test datakvaliteten

Vi vil at hver time skal ha god dekning: minst **10** femminuttere. En dbt-test er bare en
`SELECT` — testen **feiler hvis den returnerer rader**. Vi skriver derfor en spørring som finner
radene som _ikke_ oppfyller kravet. Skriv testen i
**`my_project/tests/reisetider_god_kvalitet.sql`** og kjør:

```bash
dbt test -s reisetider_god_kvalitet
```

<details>
<summary>💡 Løsningsforslag</summary>

```sql
select *
from {{ ref('reisetider_med_time') }}
where antallFemMinutt < 10
```

</details>

### Oppgave 2.5.2: Rett opp feilen

Oooops — testen feiler! Endre `reisetider_med_time` slik at testen består. Kjør deretter
`dbt run -s reisetider_med_time` og `dbt test` på nytt.

> 🚨 **NB!** Vi filtrerer nå vekk verdier — det gir større hull i tidsserien. Hvordan man
> håndterer dette avhenger av analysen, men vi gjør det enkelt her.

<details>
<summary>💡 Løsningsforslag</summary>

Legg til en `HAVING`-linje nederst (etter `GROUP BY`):

```sql
group by timesbolk, strekningId, navn
having count(*) > 9
```

</details>

---

## Oppgave 2.6: Slå sammen reisetider og trafikktall 🥇

Nå kobler vi trafikktall og reisetider per time. Vi vil **ikke** bygge gullprodukt oppå
gullprodukt, så i stedet for å referere til `reisetider_med_time`, gjenbruker vi logikken
(aggregering til timesnivå) og kobler mot sølvproduktet `timetrafikk_strekning`. Skriv modellen
i **`my_project/models/3_gold/reisetider_med_trafikk.sql`**.

<details>
<summary>💡 Løsningsforslag</summary>

```sql
{{
    config(
        materialized='table'
    )
}}

with reisetider_med_time as (
    select
        *,
        date_trunc('HOUR', publiseringstidspunkt) as timesbolk
    from {{ ref('reisetider_med_strekninger') }}
)

select
    r.navn,
    r.timesbolk,
    r.strekningId,
    avg(r.reisetidVarighetSekunder) as reisetidGjennomsnitt,
    count(*) as antallFemMinutt,
    t.trafikk
from reisetider_med_time as r
join {{ ref('timetrafikk_strekning') }} as t
    on t.strekning = r.navn
   and r.timesbolk = convert_timezone('UTC', 'Europe/Oslo', t.tidspunkt)
group by r.timesbolk, r.strekningId, r.navn, t.trafikk
```

> 🔎 `timetrafikk`-tidspunktet ligger i UTC, mens `timesbolk` er i norsk tid (fra sølvproduktet),
> derfor `convert_timezone` i join-betingelsen.

</details>

---

## Oppgave 2.7: Trafikk og reisetid per ukedag og klokketime 🥇

Til slutt vil vi se mønstre som gjentar seg — typisk reisetid og trafikk for en gitt ukedag og
klokketime. Siden dette bare er en liten nyanse oppå et eksisterende gullprodukt, lager vi det
som et **view** oppå `reisetider_med_trafikk`. Skriv modellen i
**`my_project/models/3_gold/reisetider_trafikk_klokketime.sql`**.

<details>
<summary>💡 Løsningsforslag</summary>

```sql
{{
    config(
        materialized='view'
    )
}}

with med_ukedag as (
    select
        *,
        hour(timesbolk) as klokketime,
        dayofweekiso(timesbolk) as ukedag   -- mandag=1 ... søndag=7
    from {{ ref('reisetider_med_trafikk') }}
)

select
    navn,
    ukedag,
    klokketime,
    avg(reisetidGjennomsnitt) as reisetidGjennomsnitt,
    avg(trafikk) as trafikkGjennomsnitt
from med_ukedag
group by navn, ukedag, klokketime
```

> 🔎 **Snowflake vs BigQuery:** BigQuery nummererer ukedager fra søndag (1) og trengte en
> modulo-formel for norsk ukedag. I Snowflake gir **`DAYOFWEEKISO`** mandag = 1 … søndag = 7
> direkte 🎉

</details>

---

## Snowflake vs BigQuery – jukselapp 🧾

| BigQuery | Snowflake |
|---|---|
| `SELECT * EXCEPT(col)` | `SELECT * EXCLUDE (col)` |
| `DATETIME(ts, "Europe/Oslo")` | `CONVERT_TIMEZONE('UTC', 'Europe/Oslo', ts)` |
| `DATETIME_TRUNC(ts, HOUR)` | `DATE_TRUNC('HOUR', ts)` |
| `EXTRACT(HOUR FROM ts)` | `HOUR(ts)` |
| `EXTRACT(DAYOFWEEK FROM ts)` + modulo | `DAYOFWEEKISO(ts)` (man=1 … søn=7) |
| `IF(a, b, c)` | `IFF(a, b, c)` |
| `struct.field` (nøstet) | `"struct":field` (kolon-notasjon, evt. `::type`) |
| kolonner er ikke case-sensitive | mikset-casing-kolonner må ha `"anførselstegn"` |

---

Da er du gjennom hele løypa — fra rå kildedata i bronse, via gjenbrukbare sølvprodukter, til
spissede gullanalyser med tester og lineage. God tur videre med dbt 🪁
