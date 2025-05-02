# Flyway-in-Docker Aliases 🚀

Tiny shell helpers that turn a 90-character  
`docker run flyway/flyway:latest …`  
into terse, Git-style commands.

| Alias | Expands to | Purpose |
|-------|------------|---------|
| `fm`   | `flyway migrate -q`                   | Apply migrations (quiet) |
| `fi`   | `flyway info -q`                      | Show schema status (quiet) |
| `fvm`  | `flyway migrate`                      | Apply migrations (verbose) |
| `fvi`  | `flyway info`                         | Show schema status (verbose) |
| `fval` | `flyway validate -q`                  | Validate checksums |
| `fr`   | `flyway repair -q`                    | Repair history table |
| `fsql` | `flyway migrate -outputType=sql`      | Dry-run: output SQL only |
| `fhist`| `flyway info \| tail -n +5`          | Full history (verbose)               |
| `flast`| `flyway info \| tail -15`            | Last 15 history lines (verbose)      |
| `fhelp`| —                                     | Show this cheat-sheet |

---

## Why bother?

* **Keyboard-friendly** — type `fm`, not a full docker command.  
* **Noise-free logs** — quiet by default; verbose when you ask.  
* **Repo-agnostic** — works in *any* Flyway project that follows the common layout:

```text
your-project/
├─ db/migrations/       ←  V1__*.sql migration scripts
└─ flyway.conf          ←  connection creds & settings
```

* **No global Flyway install** — only Docker Desktop.

---

## Prerequisites

* macOS / Linux / WSL with **Docker Desktop or Docker Engine**  
  (Apple-silicon works via Docker’s Rosetta emulation.)

---

## 1 · Install

```bash
# 1. Download the alias script
curl -sSL https://raw.githubusercontent.com/stonegiantstudio/flaliases/main/flyway-aliases.sh \
     -o ~/.flyway-aliases.sh

# 2. Ensure it’s sourced in NEW shells (but only add the line if it isn’t there yet)
grep -qxF 'source ~/.flyway-aliases.sh' ~/.zshrc || \
  echo 'source ~/.flyway-aliases.sh' >> ~/.zshrc

# 3. Load it into THIS shell **without** touching the rest of ~/.zshrc
source ~/.flyway-aliases.sh
```
Run fhelp to see the alias list at any time.

---

## 2 · Configure each Flyway repo

Create a `flyway.conf` file in the project root:

```properties
# ---- flyway.conf (template) ----
# Replace YOUR_DB_NAME with the database you created in your Docker container
flyway.url=jdbc:sqlserver://host.docker.internal:1433;databaseName=YOUR_DB_NAME;encrypt=true;trustServerCertificate=true

# Use the SA password you passed to docker run
flyway.user=sa
flyway.password=YOUR_STRONG_PASSWORD

# Folder (inside the container) where migrations are mounted
flyway.locations=filesystem:/flyway/migrations
```

The aliases mount:

```text
$(pwd)/db/migrations → /flyway/migrations
$(pwd)/flyway.conf   → /flyway/conf/flyway.conf
Feel free to change sa or the password to any login you created in your local SQL-Server container—the aliases just forward whatever credentials you put in flyway.conf.
```

## 3  · Usage

```bash
cd my-flyway-repo

fm      # apply migrations quietly
fi      # show schema version & pending scripts

fvm     # verbose migrate (debug)
fsql    # dry-run SQL

fhelp   # show cheat-sheet
```

## 4 · Updating the Script

```bash
curl -sSL https://raw.githubusercontent.com/stonegiantstudio/flaliases/main/flyway-aliases.sh \
     -o ~/.flyway-aliases.sh && source ~/.flyway-aliases.sh
```

## 5 · Uninstall

```bash
sed -i '' '/flyway-aliases.sh/d' ~/.zshrc   # macOS; use -i for GNU sed
rm ~/.flyway-aliases.sh
```

## License
MIT — free to use, modify, and distribute.
Please keep the copyright notice.
