# ImPress: Securing DRAM Against Data-Disturbance Errors via Implicit Row-Press Mitigation

This repository is part of the evaluation artifact for the [ImPress](https://arxiv.org/pdf/2407.16006) paper, which will appear at [MICRO 2024](https://microarch.org/micro57/). 

**Acknowledgement:** This artifact and simulation infrastructure have been adapted from [START (HPCA'24)](https://github.com/Anish-Saxena/rowhammer_champsim).

## Introduction

Experiments in the ImPress paper are conducted using [ChampSim](https://github.com/ChampSim/ChampSim), a cycle-level multi-core simulator, interfaced with [DRAMSim3](https://github.com/umd-memsys/dramsim3), a detailed memory system simulator. The jobfile management is adapted from the infrastructure used in [pythia](https://github.com/CMU-SAFARI/pythia).  This artifact enables recreation of motivation Figures 3 and 5 as well as key result Figure 13. 


## System Requirements

   - **SW Dependencies** 
     - Tested with cmake v3.23.1, g++ v10.3.0, md5sum v8.22, perl v5.16.3, megatools 1.11.0, and Python 3.9.7.
   - **Benchmark Dependencies** 
     - ChampSim-compatible traces of SPEC2017 and STREAM workloads.
   - **HW Dependencies** 
     - A scale-out system like many-core server or HPC cluster.
     - Our experiments were performed on the [PACE](https://pace.gatech.edu) cluster at Georgia Tech.
     - Most configurations run simulations for 20 workloads for about 6 hours on average (with one workload per core). 
     - Overall, there are 35 configurations, requiring about 4,200 core-hours to replicate all results (about three days on one 64-core server).

## Compilation Steps

The expected directory structure is:

```
impress_micro2024
|-dramsim3
|-champsim
|-pythia
```

* `git clone git@github.com:Anish-Saxena/impress_micro2024.git`
* `cd impress_micro2024`

### Build DRAMSim3

* `cd dramsim3`
* `mkdir build && cd build && cmake ..`
* `make -j8`
* `cd ..`

### Setup ChampSim Build Environment

* `cd champsim`
*  `./set_paths.sh`

### Compile One Configuration for Testing

* `./config.py configs/MOP_GS8/baseline.json`
* `make -j8`
* `cd ..`

Ensure that the compilation completes without error. 

**Common Error**: The compiler may not be able to link the dramsim3 library. If so, check that the path is correctly set in `config.py` (search for LDLIBS). 

### Download Traces

Please download traces from [Dropbox](https://www.dropbox.com/scl/fi/qeh3rztdh4md76lhsm0u4/traces.tar.gz?rlkey=xq1yu8zithl497dnef1jpp0gv&st=r1iam07b&dl=0). After extracting the traces (`tar -cvzf traces.tar.gz`), place them in `pythia/traces/` directory. The structure should be as follows:

```
pythia/traces/
|-602.gcc_s-1850B.champsimtrace.xz
|-603.bwaves_s-2931B.champsimtrace.xz
|- and so-on...
```

### Update LD_LIBARY_PATH

DRAMSim3 is loaded as a dynamically linked library and requires updating `LD_LIBRARY_PATH` variable. We recommend exporting the updated variable to the job-files used to launch experiments.

- Update `LD_LIBRARY_PATH` in current terminal session: `export LD_LIBRARY_PATH=<path-to-dramsim3-directory>:$LD_LIBRARY_PATH`
- Optional (not recommended): Append updated variable to bashrc: `echo "export LD_LIBRARY_PATH=<path-to-dramsim3-directory>:$LD_LIBRARY_PATH" >> ~/.bashrc`

### Test Setup with Dummy Run

* `cd champsim`
* `./test_setup.sh`

Running this trace for 100K warmup and 100K simulation instructions should take about a minute. Ensure that the simulation completes successfully; you will see the message `SETUP TESTED SUCCESSFULLY` at the end of the output.

**Common Error:** If the loader is unable to find the dramsim3 library, please ensure the updated `LD_LIBRARY_PATH` variable is available in the execution environment (for example, if srun-like commands are used). 

## Experimental Workflow

ImPress adopts [pythia's](https://github.com/CMU-SAFARI/pythia) experimental workflow by launching experiments preferably on an HPC compute cluster followed by rolling up statistics.

Each configuration runs 20 workloads. Overall, there are 35 configurations required to recreate key figures in the paper.

### Build ChampSim Configurations

1. `cd champsim`
2. `./build_configs.sh configs/configs.txt`

This script builds all simulator binaries for the experiments and might take between 30 minutes to an hour to complete.

### Launch Experiments

Recreating all figures requires 700 experiment runs (each requiring one core and 4GB memory). Each experiment requires 6 core-hours on average, or about 4.2K core-hours to reproduce the experiments. 

The directory structure (required to parse results for plotting scripts) has been set up at:

`pythia/experiments/figures/mop_gs8/`

Within this directory, you will find several sub-directories storing a jobfile (eg., `baseline/jobfile.sh`) for each configuration. The list of all configurations to be launched, relative to the above-mentioned experiment directory, is available at `pythia/experiments/figures/mop_gs8/experiments.txt`. 

Next, make any changes necessary to run the configurations on your machine. **Refer to options below before proceeding to next steps.**

#### Option-1: Using Slurm

The sample jobfile within each directory assumes usage of `slurm` scheduler (typically when using an HPC cluster). We recommend making changes to these jobfiles (such as specifying the charge account for `slurm`, etc.), as required. Please be sure to change **ALL** jobfiles listed in `experiments.txt`. 

**Tips:** Common modifications, such as substituting charge account name, can be accomplished using two commands from within the `pythia/experiments/figures/mop_gs8/` directory:

1. `/bin/zsh`
2. `sed -i 's/gts-mqureshi4-rg/<your-account-name>/g' **.jobfile.sh`

This would change the charge account name in all jobfiles stored in this directory or any of its sub-directories. Other modifications can be similarly accomplished using `sed`.

**Note:** Please do not change the name of workload directories (or their directory structure) created by the jobfiles, as they are used by the stat collection scripts.  

Before proceeding, try running a jobfile inside a directory to ensure it works. For example, try launching baselin experiments using `cd baseline && sbatch jobfile.sh`. If all experiments launch without failures, you may cancel this trial run (using `scancel` command) and proceed to launching all experiments. 

#### Option-2: Running Locally

Similar to the `slurm` option, we provide jobfiles that can launch experiments locally in parallel in the `pythia/experiments/figures/mop_gs8_local/` directory (eg., check out `baseline/jobfile.sh`). The jobfiles in this directory do not require slurm, but the management of running all required configurations is upon the user. We encourage users to modify `launch_exps.sh` in this directory to launch experiments and manage resource utilization as required. 

**After referring to options above, proceed with launching experiments below.**

3. Launch experiments. 
    * **Option-1**: We provide a helper script `launch_exps.sh` within `mop_gs8` that launches all experiments using the `sbatch` command. 
    * **Option-2**: If running locally, please launch each configuration manually within `mop_gs8_local` and ensure number of running experiments are less than number of cores at any given time (otherwise context switches can degrade performance).


## Collect Statistics

The stat collection scripts are located in `pythia/graphs/stat_scripts/mop_gs8/` directory. The stat scripts parse and store results in `pythia/graphs/stat_scripts/mop_gs8/data` directory within the stat collection directory. Finally, original data used in the paper is available in `pythia/graphs/stat_scripts/mop_gs8/data/original_data/` directory. 

**Note:** Each stat script has a `STAT_DIR` variable, which defaults to `mop_gs8` directory within `pythia/experiments/figures/` (with slurm-enabled jobfiles). If your experiments have been run in `mop_gs8_local` directory (that is, local experiments), please change this variable for each stat file. You may do this change with the following commands:
1. `/bin/zsh`
2. `sed -i 's/experiments\/figures\/mop_gs8\//experiments\/figures\/mop_gs8_local\//g' **.sh`

### Figure 3

1. `./mro_sensitivity.sh`

This script requires that all configurations within `baseline`, `1C_baseline`, and `mro` directories are available.

### Figure 5

1. `./mg_sensitivity.sh T4K`
2. `./para_sensitivity.sh T4K`
3. `./mg_para_mro_sensitivity.sh`

This script requires that all configurations within `baseline`, `1C_baseline`, `T4K/mg_drfm`, and `T4K/para_drfm` directories are available.

### Figure 13

#### Figure 13-(a) Graphene

1. `./mg_ip.sh T4K`

This script requires that all configurations within `baseline`, `1C_baseline`, and `T4K/mg_drfm` directories are available.

#### Figure 13-(b) PARA

1. `./para_ip.sh T4K`

This script requires that all configurations within `baseline`, `1C_baseline`, and `T4K/para_drfm` directories are available.

#### Figure 13-(c) In-DRAM (RFM)

1. `./raa_ip.sh`

This script requires that all configurations within `baseline`, `1C_baseline`, and `raa_rfm/no_ref/` directories are available.

**Common Error:** If the parsing script (or the python script that is internally called) is unable to locate the relevant file, please ensure the paths traversed by the scripts are correct (especially all the `*_DIR` variables in bash scripts).

## Visualize Results and Recreate Figures

The plotting Jupyter notebook is available at `pythia/graphs/stat_scripts/mop_gs8/impress_graphs.ipynb`. The plotting notebook uses data stored in `pythia/graphs/stat_scripts/mop_gs8/data` directory (generated by stat collection scripts). 

The plotting notebook can be launched using `jupyter-notebook impress_graphs.ipynb` command. Please be sure the requisite python package are installed, including matplotlib, numpy, pandas, and seaborn. 

After the parsing script for a figure has been run, you can re-run the cell corresponding to that figure to recreate it.

The graphs are displayed in the Jupyter notebook and stored in `pythia/graphs/stat_scripts/mop_gs8/outputs/` directory. The original plots are available at `pythia/graphs/stat_scripts/mop_gs8/outputs/original_plots/` directory. 

**Note:** Figure 13 consists of 3 figures that are separately rendered by the Jupyter notebook. Please be sure to correlate the correct figures.

**Common Error:** If there is a key error, please go to the relevant csv and ensure the column names are as expected by the plotting file. Sometimes, the delimiter variable can cause incorrect parsing by Pandas' csv reader, which can be mitigated by using `r'\s+'` as the regex-enabled delimiter. 

Please contact the authors if errors are not resolved.