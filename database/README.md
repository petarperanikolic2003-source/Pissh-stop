
# Pissh-stop — Baza podataka

## O projektu

Pissh-stop je projekat koji koristi bazu podataka za čuvanje i organizovanje informacija o lokacijama, njihovim vlasnicima, korisnicima, recenzijama, korišćenju lokacija i plaćanjima.

Cilj baze podataka je da omogući pouzdano čuvanje podataka, povezivanje različitih informacija i jednostavno pretraživanje pomoću SQL upita.

Baza je napravljena korišćenjem PostgreSQL sistema za upravljanje relacionim bazama podataka.

## Šta baza podataka radi?

Baza omogućava:

- Čuvanje podataka o korisnicima i njihovim ulogama.
- Čuvanje informacija o vlasnicima lokacija.
- Evidenciju lokacija, njihovih adresa, gradova, cena i dostupnosti.
- Čuvanje ocena i komentara korisnika.
- Evidenciju korišćenja pojedinačnih lokacija.
- Čuvanje podataka o plaćanjima i njihovom statusu.
- Pretraživanje i analiziranje podataka pomoću SQL upita.
- Izračunavanje prosečnih ocena i broja korišćenja lokacija.

## Struktura baze podataka

Baza se sastoji od šest glavnih tabela.

### 1. users

Čuva informacije o korisnicima sistema.

Sadrži:
- ID korisnika
- Ime
- Email adresu
- Hash lozinke
- Ulogu korisnika
- Datum kreiranja naloga

### 2. owners

Čuva informacije o vlasnicima lokacija, uključujući ime, email adresu i broj telefona.

### 3. locations

Čuva informacije o lokacijama.

Sadrži naziv, adresu, grad, geografske koordinate, cenu i informaciju o tome da li je lokacija otvorena. Svaka lokacija može biti povezana sa svojim vlasnikom.

### 4. reviews

Čuva ocene i komentare koje korisnici ostavljaju za lokacije. Ocena može biti od 1 do 5.

### 5. usage_records

Evidentira korišćenje lokacija i povezuje korisnika sa lokacijom koju je koristio.

### 6. payments

Čuva informacije o plaćanjima, uključujući iznos, status i datum kreiranja.

## SQL fajlovi

- `schema.sql` — kreira tabele, primarne i strane ključeve, ograničenja i indekse.
- `seed.sql` — ubacuje probne podatke za testiranje baze.
- `queries.sql` — sadrži SQL upite za prikazivanje, pretraživanje i analiziranje podataka.
- `tests.sql` — proverava da li postoje potrebne tabele i da li su probni podaci i njihove veze ispravni.

## Korišćene tehnologije

- PostgreSQL — sistem za upravljanje bazom podataka.
- SQL — jezik za kreiranje tabela, unos, izmenu, brisanje i pretraživanje podataka.
- GitHub — platforma za čuvanje i praćenje izmena na projektu.

## Kako pokrenuti bazu podataka?

### Preduslovi

Potrebno je imati instaliran PostgreSQL i alat za izvršavanje SQL komandi, kao što su `psql` ili pgAdmin.

### 1. Kreiranje baze

U terminalu izvršiti:

```bash
createdb pissh_stop
```

### 2. Kreiranje tabela

Pokrenuti fajl `schema.sql`:

```bash
psql -d pissh_stop -f schema.sql
```

### 3. Unos probnih podataka

Pokrenuti fajl `seed.sql`:

```bash
psql -d pissh_stop -f seed.sql
```

### 4. Provera baze

Pokrenuti testove:

```bash
psql -d pissh_stop -f tests.sql
```

### 5. Izvršavanje SQL upita

Za prikaz i analizu podataka pokrenuti:

```bash
psql -d pissh_stop -f queries.sql
```

Komande treba izvršavati iz direktorijuma u kojem se nalaze SQL fajlovi, ili navesti njihove pune putanje.

## Bezbednost

Lozinke korisnika ne treba čuvati kao običan tekst. U stvarnoj aplikaciji potrebno je koristiti odgovarajući, bezbedan algoritam za hashiranje lozinki.

Probni podaci iz `seed.sql` služe samo za razvoj i testiranje. Vrednost `TEST_HASH` nije stvarni hash lozinke i ne sme se koristiti za stvarne korisničke naloge.

## Zaključak

Baza podataka projekta Pissh-stop omogućava organizovano čuvanje podataka o korisnicima, vlasnicima i lokacijama, kao i evidenciju recenzija, korišćenja i plaćanja.

Korišćenjem relacionih tabela, ključeva, ograničenja i SQL upita obezbeđuje se povezanost podataka i osnova za dalji razvoj projekta.
