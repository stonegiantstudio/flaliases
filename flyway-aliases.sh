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
alias fclean='f clean'        # ⚠ drops schema
# Verbose equivalents
alias fvm='fv migrate'
alias fvi='fv info'
# Extras
alias fsql='fv -outputType=sql migrate'  # dry-run SQL
alias fhist='fi | tail -n +5'            # history only
alias flast='fi | tail -15'              # last lines

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
fclean  flyway clean          (DROPS schema)
fsql    flyway migrate -outputType=sql   (dry-run)
fhist   fi | tail -n +5       (history table only)
flast   fi | tail -15         (last 15 lines)
EOF
}
### ----------------------------------------------------
