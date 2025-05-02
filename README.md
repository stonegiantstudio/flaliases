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
# download
curl -sSL https://raw.githubusercontent.com/<your-user>/flyway-aliases/main/flyway-aliases.sh \
     -o ~/.flyway-aliases.sh

# load on every shell start
echo 'source ~/.flyway-aliases.sh' >> ~/.zshrc   # or ~/.bashrc
source ~/.zshrc
```
Run fhelp to see the alias list at any time.

---

## 2 · Configure each Flyway repo

# flyway.conf (example)
flyway.url=jdbc:sqlserver://host.docker.internal:1433;databaseName=<db>;encrypt=true;trustServerCertificate=true
flyway.user=sa
flyway.password=Str0ng_Pass!
flyway.locations=filesystem:/flyway/migrations

The aliases mount:

$(pwd)/db/migrations → /flyway/migrations

$(pwd)/flyway.conf → /flyway/conf/flyway.conf


## 3  · Usage

cd my-flyway-repo

fm      # apply migrations quietly
fi      # show schema version & pending scripts

fvm     # verbose migrate (debug)
fsql    # dry-run SQL

fhelp   # show cheat-sheet

## 4 · Updating the Script

curl -sSL https://raw.githubusercontent.com/<your-user>/flyway-aliases/main/flyway-aliases.sh \
     -o ~/.flyway-aliases.sh && source ~/.zshrc

## 5 · Uninstall

sed -i '' '/flyway-aliases.sh/d' ~/.zshrc   # macOS; use -i for GNU sed
rm ~/.flyway-aliases.sh

License
MIT — free to use, modify, and distribute.
Please keep the copyright notice.
