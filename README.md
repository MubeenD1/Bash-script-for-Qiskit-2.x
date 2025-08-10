# Bash-script-for-Qiskit-2.x
A bash script for installing Qiskit 2.x along with minimal add-ons inside a conda virtual environment for better requirement isolation.

# Features:
This shell script allows for users to more easily setup and use Qiskit inside a virtual conda environment. This installation uses Miniforge rather than Anaconda for creating conda virtual environments. Miniforge is a minimal installer for conda that:
* Gives you just conda and Python
* Is completely open source with no commercial restrictions
* Has a much smaller download (~50MB vs 500MB+)

Additionally, conda venv's are preffered over python venv's due to it's easier support for non-python dependencies or system libraries, should the user require it.

The installation comes with the following Qiskit packages:
* Qiskit - core framework
* Qiskit-Aer - runtime simulators
* Qiskit-IBM-Runtime - IBM Quantum platform access

These package choices avoid qiskit-machine-learning, qiskit-algorithms, qiskit-optimization and others for now. Since these packages still require Qiskit 1.x and cause downgrades. So we have chosen to stick with the core trio that properly supports Qiskit 2.x

# Running the script:
```bash
git clone https://github.com/MubeenD1/Bash-script-for-Qiskit-2.x.git
cd Bash-script-for-Qiskit-2.x
./install_qiskit_2.sh
```
(Yea that's it)

# Usage:
The script will tell the user how to activate your virtual environment to start using it but here is a basic rundown anyway.

The environment is named 'qiskit' by default
```bash
conda activate qiskit
```

To start coding, the user can open a jupyter session with
```bash
jupyter notebook
```
or 
``` bash
jupyter lab
```

# Contributing:
How you can contribute:
* Fork repo
* Create a branch
* Commit changes
* Push and open a PR

# License:
MIT license


