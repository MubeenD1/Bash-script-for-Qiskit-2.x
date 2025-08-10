#!/bin/bash

# Simple Qiskit Complete Cleanup Script
set -e  # Exit on error

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${RED}=== Removing Qiskit Setup ===${NC}"

# Safety: Don't run as root
if [[ $EUID -eq 0 ]]; then
    echo -e "${RED}Don't run as root!${NC}"
    exit 1
fi

# Remove qiskit environment
if command -v conda >/dev/null 2>&1 && conda env list | grep -q "qiskit"; then
    echo "Removing qiskit environment..."
    conda deactivate 2>/dev/null || true
    conda env remove -n qiskit -y
    echo -e "${GREEN}Qiskit environment removed!${NC}"
else
    echo -e "${YELLOW}No qiskit environment found${NC}"
fi

# Remove Miniforge completely
if [ -d "$HOME/miniforge3" ]; then
    echo "Removing Miniforge..."
    rm -rf "$HOME/miniforge3"
    echo -e "${GREEN}Miniforge removed!${NC}"
else
    echo -e "${YELLOW}No Miniforge installation found${NC}"
fi

# Clean up conda initialization from bashrc
if [ -f "$HOME/.bashrc" ]; then
    echo "Cleaning bashrc..."
    # Create backup
    cp "$HOME/.bashrc" "$HOME/.bashrc.backup"
    
    # Remove conda initialization block
    sed -i '/# >>> conda initialize >>>/,/# <<< conda initialize <<</d' "$HOME/.bashrc"
    echo -e "${GREEN}Conda initialization removed from bashrc!${NC}"
fi

# Remove conda config files
echo "Removing conda configs..."
rm -rf "$HOME/.conda" 2>/dev/null || true
rm -f "$HOME/.condarc" 2>/dev/null || true
rm -rf "$HOME/.cache/pip" 2>/dev/null || true

# Reload shell environment
source "$HOME/.bashrc" 2>/dev/null || true

echo -e "${GREEN}=== Complete Cleanup Done! ===${NC}"
echo "Restart your terminal to ensure all changes take effect"
