#!/usr/bin/env bash
# nCode ncode-saas-toolkit Base Installer
# https://github.com/dangogit/ncode-saas-toolkit
#
# Installs the base plugin + essential plugins for all nCode students.
# Idempotent: safe to re-run.

# -----------------------------------------
# Colors & helpers
# -----------------------------------------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

print_step()       { echo -e "\n${CYAN}${BOLD}> $1${RESET}"; }
print_done()       { echo -e "  ${GREEN}[ok] $1${RESET}"; }
print_skip()       { echo -e "  ${CYAN}[--] $1${RESET}"; }
print_installing() { echo -e "  ${YELLOW}[..] $1...${RESET}"; }
print_warn()       { echo -e "  ${YELLOW}[!!] $1${RESET}"; }
print_error()      { echo -e "  ${RED}[xx] $1${RESET}"; }

# Trackers for the final summary
SUCCESSES=()
FAILURES=()
record_ok()   { SUCCESSES+=("$1"); }
record_fail() { FAILURES+=("$1"); }

# -----------------------------------------
# Platform detection
# -----------------------------------------
OS="$(uname -s)"
case "$OS" in
  Darwin*)              PLATFORM="macos" ;;
  Linux*)               PLATFORM="linux" ;;
  MINGW*|MSYS*|CYGWIN*) PLATFORM="windows" ;;
  *)                    PLATFORM="unknown" ;;
esac

# -----------------------------------------
# Pre-flight checks
# -----------------------------------------
if ! command -v claude &>/dev/null; then
  print_error "Claude Code is not installed."
  echo -e "  Run: ${BOLD}curl -fsSL https://danielthegoldman.com/claude-code/install.sh | bash${RESET}"
  exit 1
fi

if ! command -v git &>/dev/null; then
  print_error "Git is not installed. Install Git first and re-run this installer."
  exit 1
fi

# -----------------------------------------
# Helper: install a Claude plugin idempotently
# Verifies state before/after instead of guessing.
# Args: $1 = plugin name
# -----------------------------------------
install_claude_plugin() {
  local plugin="$1"
  # Plugin list entries look like:  "❯ name@source"
  if claude plugin list 2>/dev/null | grep -qE "(^|[[:space:]])${plugin}@"; then
    print_skip "$plugin already installed"
    record_ok "$plugin"
    return 0
  fi
  print_installing "$plugin"
  local out
  if out=$(claude plugin install "$plugin" 2>&1); then
    print_done "$plugin installed"
    record_ok "$plugin"
  else
    print_error "$plugin failed: $(echo "$out" | head -1)"
    record_fail "$plugin"
  fi
}

# Helper: install marketplace skill via npx
# Args: $1 = repo (e.g., supabase/agent-skills), $2 = display name
install_marketplace_skill() {
  local repo="$1"
  local name="$2"
  print_installing "$name"
  if npx -y skills add "$repo" -g -y >/dev/null 2>&1; then
    print_done "$name"
    record_ok "$name"
  else
    print_warn "$name (skipped - check internet/npm)"
    record_fail "$name"
  fi
}

# Helper: add a Claude plugin marketplace idempotently.
# Args: $1 = marketplace ref (URL or owner/repo), $2 = marketplace id (as shown in `claude plugin marketplace list`)
add_claude_marketplace() {
  local mp_ref="$1"
  local mp_id="$2"
  if claude plugin marketplace list 2>/dev/null | grep -q "$mp_id"; then
    print_skip "marketplace $mp_id already added"
    return 0
  fi
  print_installing "marketplace $mp_id"
  if claude plugin marketplace add "$mp_ref" >/dev/null 2>&1; then
    print_done "marketplace $mp_id added"
  else
    print_warn "marketplace $mp_id add failed - plugin installs may fail"
  fi
}

# -----------------------------------------
# Welcome banner
# -----------------------------------------
echo ""
echo -e "${BOLD}${CYAN}+================================================+${RESET}"
echo -e "${BOLD}${CYAN}|     nCode Base Installer                       |${RESET}"
echo -e "${BOLD}${CYAN}|  Skills, agents & plugins for SaaS development |${RESET}"
echo -e "${BOLD}${CYAN}+================================================+${RESET}"
echo -e "  Platform: ${BOLD}$PLATFORM${RESET}"
echo ""

# -----------------------------------------
# 1. Add all required marketplaces UP FRONT.
#    `claude plugin install <name>` fails with "plugin not found" if its
#    marketplace isn't registered yet, so they all have to be added before any
#    plugin install runs. The previous version added marketplaces lazily, which
#    meant `superpowers` (missing marketplace) and `context7` (marketplace added
#    after install) failed on fresh machines.
# -----------------------------------------
print_step "Adding plugin marketplaces"
add_claude_marketplace "https://github.com/dangogit/ncode-saas-toolkit" "ncode-saas-toolkit"
add_claude_marketplace "anthropics/claude-plugins-official"             "claude-plugins-official"
add_claude_marketplace "obra/superpowers-marketplace"                   "superpowers-marketplace"

# -----------------------------------------
# 2. Install plugins (marketplaces are now all present)
# -----------------------------------------
print_step "Installing ncode-saas-toolkit"
install_claude_plugin "ncode-saas-toolkit"

print_step "Installing Superpowers (brainstorming, planning, debugging, TDD)"
install_claude_plugin "superpowers"

print_step "Installing Context7 (library & framework docs)"
install_claude_plugin "context7"

print_step "Installing TypeScript LSP"
install_claude_plugin "typescript-lsp"

print_step "Installing Frontend Design (production-grade UI)"
install_claude_plugin "frontend-design"

# -----------------------------------------
# 3. gstack (Garry Tan's Claude Code skills)
#    Used for: /investigate, /design-shotgun, /canary,
#              /freeze, /guard, /unfreeze, /retro
# -----------------------------------------
print_step "Installing gstack (selected commands for nCode lessons)"

GSTACK_DIR="$HOME/.claude/skills/gstack"

# Make sure Bun is on PATH if it was installed in a previous run
if ! command -v bun &>/dev/null && [ -x "$HOME/.bun/bin/bun" ]; then
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
fi

if [ -d "$GSTACK_DIR/.git" ]; then
  print_skip "gstack already cloned at $GSTACK_DIR"
  # Re-run setup in case it failed last time or gstack updated
  if command -v bun &>/dev/null; then
    print_installing "Re-running gstack setup (idempotent)"
    if (cd "$GSTACK_DIR" && ./setup >/dev/null 2>&1); then
      print_done "gstack setup verified"
      record_ok "gstack"
    else
      print_warn "gstack setup returned non-zero (skills may already be linked)"
      record_ok "gstack"
    fi
  else
    print_warn "gstack present but Bun missing - skills may not work"
    record_fail "gstack"
  fi
else
  # Need to install Bun first
  if ! command -v bun &>/dev/null; then
    if [ "$PLATFORM" = "macos" ] || [ "$PLATFORM" = "linux" ]; then
      print_installing "Installing Bun (required by gstack)"
      if curl -fsSL https://bun.sh/install | bash >/dev/null 2>&1; then
        export BUN_INSTALL="$HOME/.bun"
        export PATH="$BUN_INSTALL/bin:$PATH"
        if command -v bun &>/dev/null; then
          print_done "Bun installed ($(bun --version))"
        else
          print_error "Bun installed but not on PATH. Restart shell and re-run this installer."
          record_fail "gstack (Bun PATH issue)"
        fi
      else
        print_error "Bun installation failed."
        echo -e "    Install manually: ${BOLD}curl -fsSL https://bun.sh/install | bash${RESET}"
        record_fail "gstack (Bun install failed)"
      fi
    else
      print_warn "Bun not found. On Windows, install Bun via PowerShell first:"
      echo -e "    ${BOLD}powershell -c \"irm bun.sh/install.ps1 | iex\"${RESET}"
      echo -e "    Then re-run this installer from Git Bash."
      record_fail "gstack (Bun missing on Windows)"
    fi
  else
    print_skip "Bun already installed ($(bun --version))"
  fi

  # Clone + setup if Bun is now available
  if command -v bun &>/dev/null; then
    print_installing "Cloning gstack to $GSTACK_DIR"
    mkdir -p "$HOME/.claude/skills"
    if git clone --single-branch --depth 1 https://github.com/garrytan/gstack.git "$GSTACK_DIR" >/dev/null 2>&1; then
      print_done "gstack cloned"
      print_installing "Running gstack setup"
      if (cd "$GSTACK_DIR" && ./setup >/dev/null 2>&1); then
        print_done "gstack setup complete"
        record_ok "gstack"
      else
        print_warn "gstack setup failed. Retry later: cd $GSTACK_DIR && ./setup"
        record_fail "gstack (setup failed)"
      fi
    else
      print_error "git clone failed for gstack."
      record_fail "gstack (clone failed)"
    fi
  fi
fi

# -----------------------------------------
# 4. Universal marketplace skills (relevant for both Web and Mobile)
# Note: Web/Mobile-specific skills (Supabase, Vercel, Firebase, Expo) are
# installed by the track-specific installers below.
# -----------------------------------------
print_step "Installing universal skills from marketplace"
install_marketplace_skill "agamm/claude-code-owasp"   "OWASP 2025 Security (120+ checks)"

# -----------------------------------------
# Final verification
# -----------------------------------------
print_step "Verifying installation"

# Verify gstack skill files exist on disk (most reliable check)
GSTACK_SKILLS=(investigate design-shotgun canary freeze guard unfreeze retro)
GSTACK_OK=1
if [ -d "$GSTACK_DIR" ]; then
  for skill in "${GSTACK_SKILLS[@]}"; do
    if [ ! -d "$GSTACK_DIR/$skill" ]; then
      print_warn "gstack skill missing on disk: /$skill"
      GSTACK_OK=0
    fi
  done
  if [ "$GSTACK_OK" = "1" ]; then
    print_done "All 7 gstack skills present"
  fi
else
  print_warn "gstack directory not found at $GSTACK_DIR"
fi

# -----------------------------------------
# Summary
# -----------------------------------------
echo ""
echo -e "${BOLD}${GREEN}+================================================+${RESET}"
if [ "${#FAILURES[@]}" = "0" ]; then
  echo -e "${BOLD}${GREEN}|        Base toolkit ready!                     |${RESET}"
else
  echo -e "${BOLD}${YELLOW}|        Base toolkit ready (with warnings)      |${RESET}"
fi
echo -e "${BOLD}${GREEN}+================================================+${RESET}"
echo ""

if [ "${#SUCCESSES[@]}" -gt 0 ]; then
  echo -e "  ${BOLD}Installed (${#SUCCESSES[@]}):${RESET}"
  for item in "${SUCCESSES[@]}"; do
    echo -e "    ${GREEN}[ok]${RESET} $item"
  done
fi

if [ "${#FAILURES[@]}" -gt 0 ]; then
  echo ""
  echo -e "  ${BOLD}${YELLOW}Needs attention (${#FAILURES[@]}):${RESET}"
  for item in "${FAILURES[@]}"; do
    echo -e "    ${YELLOW}[!!]${RESET} $item"
  done
fi

echo ""
echo -e "  ${BOLD}Next: Install your track${RESET}"
echo -e "  ${CYAN}Web:${RESET}    curl -fsSL https://danielthegoldman.com/ncode-saas-toolkit-web/install.sh | bash"
echo -e "  ${CYAN}Mobile:${RESET} curl -fsSL https://danielthegoldman.com/ncode-saas-toolkit-mobile/install.sh | bash"
echo ""

# Non-zero exit if anything critical failed (but not for marketplace skills)
if [ "${#FAILURES[@]}" -gt 0 ]; then
  exit 0  # Don't fail the whole install for soft errors - user gets the warnings
fi
