# ASdOMiP - Aplikacja strumieniowa do odtwarzania muzyki i podcastów

System umożliwiający strumieniowanie utworów i podcastów oraz zarządzanie biblioteką treści (playlisty, albumy, foldery).

Repozytorium zawiera następujące elementy: backend (serwer API), frontend (klient web) oraz skrypt inicjalizujący bazę danych wraz z przykładowymi danymi demonstracyjnymi.

---

## Spis treści
- [Pobranie kodu źródłowego](#pobranie-kodu-źródłowego)
- [Wymagania wstępne](#wymagania-wstępne)
- [Konfiguracja Backend (Serwer)](#konfiguracja-backend-serwer)
- [Konfiguracja Bazy Danych](#konfiguracja-bazy-danych)
- [Konfiguracja Frontend (Klient)](#konfiguracja-frontend-klient)
- [Uruchomienie systemu](#uruchomienie-systemu)
- [Pierwsze logowanie](#pierwsze-logowanie)
- [Testy (opcjonalnie)](#testy-opcjonalnie)

---

## Pobranie kodu źródłowego
```bash
git clone <https://github.com/Bartonbaron/ASdOMiP-POLSL.git>
cd ASdOMiP-POLSL
```

## Wymagania wstępne

- **Node.js** (zalecana wersja LTS)
- **npm**
- **MySQL Server** (np. MySQL 8.x)
- **(Opcjonalnie)** MySQL Workbench
- **Konto AWS S3** – wymagane do obsługi plików multimedialnych (utwory audio, podcasty, okładki, zdjęcia profilowe).
Aplikacja może zostać uruchomiona bez S3, jednak funkcje związane z wgrywaniem i strumieniowaniem
plików multimedialnych będą wówczas niedostępne.

---

## Konfiguracja Backend (Serwer)

### Instalacja zależności
```bash
cd Back
npm install
```

### Utworzenie pliku `.env`

W katalogu `Back/` należy utworzyć plik `.env` i uzupełnić go zgodnie z poniższym szablonem (wartości wrażliwe należy uzupełnić samodzielnie):
```env
PORT=3000

JWT_SECRET=TU_WSTAW_SEKRET
JWT_EXPIRES_IN=7d

DB_NAME=music_app
DB_NAME_TEST=music_app_test
DB_USER=root
DB_PASS=TU_WSTAW_HASLO
DB_HOST=localhost
DB_DIALECT=mysql

NODE_ENV=development

AWS_ACCESS_KEY_ID=TU_WSTAW
AWS_SECRET_ACCESS_KEY=TU_WSTAW
AWS_REGION=TU_WSTAW
AWS_S3_BUCKET=TU_WSTAW

ADMIN_ROLE_ID=3
```
Zmienne środowiskowe związane z AWS S3 są wymagane do poprawnego działania
funkcji uploadu i odtwarzania plików multimedialnych.
W przypadku braku konfiguracji S3 aplikacja uruchomi się poprawnie,
jednak część funkcjonalności multimedialnych będzie niedostępna.

---

## Konfiguracja Bazy Danych

### Utworzenie baz danych

W systemie MySQL należy utworzyć bazy danych:
```sql
CREATE DATABASE music_app CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Opcjonalnie: baza wykorzystywana wyłącznie do uruchamiania testów automatycznych
CREATE DATABASE music_app_test CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### Inicjalizacja struktury bazy

W katalogu `db/` znajduje się plik `schema.sql` zawierający pełną definicję struktury bazy danych (tabele, relacje, klucze).

Import z linii poleceń:
```bash
mysql -u root -p music_app < db/schema.sql
```

Alternatywnie import można wykonać przy użyciu MySQL Workbench.

### Dane demonstracyjne (seed)

W katalogu `db/seed/` znajdują się pliki CSV zawierające minimalny zestaw danych demonstracyjnych, niezbędnych do uruchomienia i przetestowania systemu:

- `roles.csv`
- `users.csv`
- `creatorprofiles.csv`
- `genres.csv`
- `topics.csv`

Pliki te zawierają wyłącznie:
- 4 konta demonstracyjne użytkowników
- konto administratora
- podstawowe dane słownikowe

**Uwaga:** Dane nie obejmują plików multimedialnych ani dużych zbiorów testowych.

**Zalecana kolejność importu CSV:**
1. `roles.csv`
2. `users.csv`
3. `creatorprofiles.csv`
4. `genres.csv`
5. `topics.csv`

Import można wykonać za pomocą MySQL Workbench lub polecenia `LOAD DATA INFILE`.

---

## Konfiguracja Frontend (Klient)

### Instalacja zależności
```bash
cd Front
npm install
```

### Utworzenie pliku `.env`

W katalogu `Front/` należy utworzyć plik `.env`:
```env
VITE_ADMIN_ROLE_ID=3
```

---

## Uruchomienie systemu

### Backend

W pierwszym terminalu:
```bash
cd Back
npm start
```

Serwer API zostanie uruchomiony domyślnie pod adresem:
```
http://localhost:3000/api
```

### Frontend

W drugim terminalu:
```bash
cd Front
npm run dev
```

Adres aplikacji frontendowej zostanie wyświetlony w konsoli (np. `http://localhost:5173`).

---

## Pierwsze logowanie

Po uruchomieniu aplikacji możliwa jest rejestracja nowego konta użytkownika.

System obsługuje **trzy role**:
- **User** - użytkownik końcowy (słuchacz)
- **Creator** - twórca publikujący treści
- **Administrator** - administrator systemu

Konto administratora znajduje się w danych demonstracyjnych (`users.csv`). Identyfikator roli administratora musi być zgodny z wartością `ADMIN_ROLE_ID` w pliku `.env`.

Hasło konta administratora jest zapisane w postaci zahaszowanej i nie jest ujawniane w repozytorium.
W celu zalogowania się jako administrator należy:

- zarejestrować nowe konto użytkownika,

- ręcznie przypisać mu rolę administratora w bazie danych lub zmodyfikować istniejące konto demonstracyjne w bazie (zmiana hasła).

---

## Testy (opcjonalnie)

W projekcie zastosowano automatyczne testy backendu wykonywane przy użyciu **Jest** oraz **Supertest**.

### Backend - uruchomienie testów automatycznych (smoke + integracyjne)
```bash
cd Back
npm test
```

### Backend - testy automatyczne z raportem pokrycia kodu (coverage)
```bash
cd Back
npm run test:cov
```