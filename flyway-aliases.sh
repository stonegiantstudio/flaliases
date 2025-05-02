### ───────────── Flyway-in-Docker aliases ─────────────
### Quiet by default; run `fhelp` for a reminder
### ----------------------------------------------------

# Core wrappers (quiet vs. verbose)
f()  { docker run --rm \
        -v "$(pwd)"/db/migrations:/flyway/migrations \
        -v "$(pwd)"/flyway.conf:/flyway/conf/flyway.conf \
        flyway/flyway:latest -q "$@"; }

fv() { docker run --rm \
        -v "$(pwd)"/db/migrations:/flyway/migrations \
        -v "$(pwd)"/flyway.conf:/flyway/conf/flyway.conf \
        flyway/flyway:latest "$@"; }

# High-level aliases — quiet
alias fm='f migrate'          # apply migrations
alias fi='f info'             # schema summary
alias fval='f validate'       # checksum check
alias fr='f repair'           # fix history table
# Verbose equivalents
alias fvm='fv migrate'
alias fvi='fv info'
# Extras
alias fsql='fv -outputType=sql migrate'  # dry-run SQL
alias fhist='fvi | tail -n +5'     # full history table, skip banner
alias flast='fvi | tail -15'       # last 15 lines of verbose info

# Help: list all the above
fhelp() {
  cat <<'EOF'
Flyway Docker alias cheat-sheet
--------------------------------
fm      flyway migrate        (quiet)
fvm     flyway migrate        (verbose)
fi      flyway info           (quiet)
fvi     flyway info           (verbose)
fval    flyway validate       (quiet)
fr      flyway repair         (quiet)
fsql    flyway migrate -outputType=sql   (dry-run)
fhist   fi | tail -n +5       (full history table, skip banner)
flast   fi | tail -15         (last 15 lines of verbose info)
EOF
}
### ----------------------------------------------------
