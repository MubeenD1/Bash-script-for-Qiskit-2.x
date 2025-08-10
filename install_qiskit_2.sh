#!/bin/bash

# Simple Qiskit 2.x Installation Script
set -e  # Exit on error

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${GREEN}=== Installing Qiskit 2.x ===${NC}"

# Safety: Don't run as root
if [[ $EUID -eq 0 ]]; then
    echo -e "${RED}[!] Don't run as root!${NC}"
    exit 1
fi

# Check if conda exists
if command -v conda >/dev/null 2>&1; then
    echo -e "${YELLOW}[?] Conda already installed, skipping...${NC}"
else
    echo -e "${BLUE}[*] Installing Miniforge...${NC}"
    wget -q https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh
    bash Miniforge3-Linux-x86_64.sh -b -p "$HOME/miniforge3"
    
    # Add conda to PATH for this script session
    export PATH="$HOME/miniforge3/bin:$PATH"
    
    # Initialize conda for future sessions
    "$HOME/miniforge3/bin/conda" init bash
    
    rm Miniforge3-Linux-x86_64.sh
    echo -e "${GREEN}[#] Miniforge installed!${NC}"
fi

# Remove existing qiskit env if it exists
if conda env list | grep -q "qiskit"; then
    echo -e "${YELLOW}[?] Removing existing qiskit environment...${NC}"
    conda env remove -n qiskit -y
fi

# Create environment and install packages
echo -e "${BLUE}[*] Creating qiskit environment...${NC}"
conda create -n qiskit python=3.11 -y

echo -e "${BLUE}[*] Installing Qiskit packages...${NC}"
echo -e "${BLUE}  -> Installing qiskit...${NC}"
conda run -n qiskit pip install qiskit

echo -e "${BLUE}  -> Installing qiskit-aer...${NC}"
conda run -n qiskit pip install qiskit-aer

echo -e "${BLUE}  -> Installing qiskit-ibm-runtime...${NC}"
conda run -n qiskit pip install qiskit-ibm-runtime

echo -e "${BLUE}[*] Installing Jupyter...${NC}"
conda install -n qiskit jupyter jupyterlab -y

echo -e "${BLUE}[*] Installing extras...${NC}"
echo -e "${BLUE}  -> Installing matplotlib...${NC}"
conda run -n qiskit pip install matplotlib

echo -e "${BLUE}  -> Installing pylatexenc...${NC}"
conda run -n qiskit pip install pylatexenc

# Test installation
echo -e "${BLUE}[*] Testing installation...${NC}"
conda run -n qiskit python -c "import qiskit; print(f'Qiskit {qiskit.__version__} ready!')"

echo -e "${GREEN}=== Done! ===${NC}"
echo -e "${YELLOW}[?] IMPORTANT: Restart your terminal or run:${NC}"
echo "${YELLOW}source ~/.bashrc"
echo ""
echo "Then use: conda activate qiskit"
