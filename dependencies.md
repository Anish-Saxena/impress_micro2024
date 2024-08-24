# Dependencies on new Linux machine

Suppose we have a fresh Linux container (`docker run -it ubuntu bash`).

0. Update apt

`apt-get update`

1. Install git

`apt install git`

2. Install cmake

`apt install cmake`

3. Install build-essential

`apt install build-essential`

4. Install python3

`apt install python3`

5. Optional: Install wget to download traces

`apt install wget`

Download traces:
`wget -o traces.tar.gz https://www.dropbox.com/scl/fi/qeh3rztdh4md76lhsm0u4/traces.tar.gz?rlkey=xq1yu8zithl497dnef1jpp0gv&st=r1iam07b&dl=1`

The ChampSim and DRAMsim3 binaries should successfully build after these dependencies are installed. Note that `slurm` is not a requirement to run the experiments on local machines/ containers.