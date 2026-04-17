#!/usr/bin/env bash
# nCode ncode-saas-toolkit Base Installer
# https://github.com/dangogit/ncode-saas-toolkit
#
# Installs the base plugin + essential plugins for all nCode students.

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
print_installing() { echo -e "  ${YELLOW}[..] $1...${RESET}"; }
print_error()      { echo -e "  ${RED}[!!] $1${RESET}"; }

# -----------------------------------------
# Pre-flight check
# -----------------------------------------
if ! command -v claude &>/dev/null; then
  print_error "Claude Code is not installed."
  echo -e "  Run: ${BOLD}curl -fsSL https://danielthegoldman.com/claude-code/install.sh | bash${RESET}"
  exit 1
fi

# -----------------------------------------
# Welcome banner
# -----------------------------------------
echo ""
echo -e "${BOLD}${CYAN}+================================================+${RESET}"
echo -e "${BOLD}${CYAN}|     nCode Base Installer                       |${RESET}"
echo -e "${BOLD}${CYAN}|  Skills, agents & plugins for SaaS development |${RESET}"
echo -e "${BOLD}${CYAN}+================================================+${RESET}"
echo ""

# -----------------------------------------
# 1. ncode-saas-toolkit marketplace + plugin
# -----------------------------------------
print_step "Installing ncode-saas-toolkit"
print_installing "Adding marketplace: dangogit/ncode-saas-toolkit"
claude plugin marketplace add https://github.com/dangogit/ncode-saas-toolkit 2>/dev/null
print_installing "Installing plugin"
claude plugin install ncode-saas-toolkit 2>/dev/null && \
  print_done "ncode-saas-toolkit installed" || \
  print_done "ncode-saas-toolkit already installed"

# -----------------------------------------
# 2. Superpowers
# -----------------------------------------
print_step "Installing Superpowers"
print_installing "superpowers (brainstorming, planning, debugging, TDD)"
claude plugin install superpowers 2>/dev/null && \
  print_done "superpowers installed" || \
  print_done "superpowers already installed"

# -----------------------------------------
# 3. Context7
# -----------------------------------------
print_step "Installing Context7"
print_installing "context7 (library & framework docs)"
claude plugin install context7 2>/dev/null && \
  print_done "context7 installed" || \
  print_done "context7 already installed"

# -----------------------------------------
# 4. TypeScript LSP
# -----------------------------------------
print_step "Installing TypeScript LSP"
print_installing "typescript-lsp"
claude plugin install typescript-lsp 2>/dev/null && \
  print_done "typescript-lsp installed" || \
  print_done "typescript-lsp already installed"

# -----------------------------------------
# 5. Frontend Design
# -----------------------------------------
print_step "Installing Frontend Design"
print_installing "frontend-design (production-grade UI)"
claude plugin install frontend-design 2>/dev/null && \
  print_done "frontend-design installed" || \
  print_done "frontend-design already installed"

# -----------------------------------------
# Done!
# -----------------------------------------
echo ""
echo -e "${BOLD}${GREEN}+================================================+${RESET}"
echo -e "${BOLD}${GREEN}|        Base toolkit ready!                      |${RESET}"
echo -e "${BOLD}${GREEN}+================================================+${RESET}"
echo ""
echo -e "  ${BOLD}What was installed:${RESET}"
echo -e "  ncode-saas-toolkit (5 skills + 4 agents)"
echo -e "  superpowers, context7, typescript-lsp, frontend-design"
echo ""
echo -e "  ${BOLD}Next: Install your track${RESET}"
echo -e "  ${CYAN}Web:${RESET}    curl -fsSL https://danielthegoldman.com/ncode-saas-toolkit-web/install.sh | bash"
echo -e "  ${CYAN}Mobile:${RESET} curl -fsSL https://danielthegoldman.com/ncode-saas-toolkit-mobile/install.sh | bash"
echo ""
