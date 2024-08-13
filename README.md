# ImPress: Securing DRAM Against Data-Disturbance Errors via Implicit Row-Press Mitigation

This repository is part of the evaluation artifact for the [ImPress](https://arxiv.org/pdf/2407.16006) paper, which will appear at [MICRO 2024](https://microarch.org/micro57/). 

**Acknowledgement:** This artifact and simulation infrastructure have been adapted from [START (HPCA'24)](https://github.com/Anish-Saxena/rowhammer_champsim).

**NOTE:** GitHub repository is currently WIP. Please check back after 8/14.

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
     - Overall, there are 37 configurations, requiring about 4,400 core-hours to replicate all results (about three days on one 64-core server).

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

Please download traces from [Dropbox](https://www.dropbox.com/scl/fi/il9weggd1x0wae0s6b30a/traces.tar.gz?rlkey=dx27ime7p14gkjfh16xohk0ix&st=r5fuucmx&dl=0). Then, place them in `pythia/traces/` directory and extract the tarball contents (`tar -cvzf traces.tar.gz`).

### Update LD_LIBARY_PATH

DRAMSim3 is loaded as a dynamically linked library and requires updating `LD_LIBRARY_PATH` variable. We recommend appending the updated variable to `bashrc` as well as all job-files used to launch experiments.

- Update `LD_LIBRARY_PATH` in current terminal session: `export LD_LIBRARY_PATH=<path-to-dramsim3-directory>:$LD_LIBRARY_PATH`
- Append updated variable to bashrc: `echo "export LD_LIBRARY_PATH=<path-to-dramsim3-directory>:$LD_LIBRARY_PATH" >> ~/.bashrc`

### Test Setup with Dummy Run

* `cd champsim`
* `./test_setup.sh`

Running this trace for 100K warmup and 100K simulation instructions should take about a minute. Ensure that the simulation completes successfully; you will see the message `SETUP TESTED SUCCESSFULLY` at the end of the output.

**Common Error:** If the loader is unable to find the dramsim3 library, please ensure the updated `LD_LIBRARY_PATH` variable is available in the execution environment (for example, if srun-like commands are used). 

## Experimental Workflow

ImPress adopts [pythia's](https://github.com/CMU-SAFARI/pythia) experimental workflow by launching experiments preferably on an HPC compute cluster followed by rolling up statistics.

Each configuration runs 26 workloads. Overall, there are 31 configurations required to recreate key figures in the paper.

### Build ChampSim Configurations

1. `cd champsim`
2. `./build_configs.sh configs/configs.txt`

### Launch Experiments

Recreating all figures requires 806 experiment runs (each requiring one core and 4GB memory). Each experiment requires 6 core-hours on average, or about 9K core-hours to recreate all experiments and 4.8K core-hours to recreate representative experiments. 

1. Select whether you will recreate all figures or only representative figures and check out `experiments/experiments/all_figures/` or `experiments/experiments/representative_figures/` directory, respectively. 
2. The `configure.csv` file provides details about each configuration (best viewed in Google Sheets/ Excel).

The directories for each required configuration have already been set up. Next, make any changes necessary to run the configuration on your machine. **Refer to options below before proceeding to next steps.**

#### Option-1: Using Slurm

The sample jobfile within each directory assumes usage of `slurm` scheduler (typically when using an HPC cluster). For each configuration, the only difference in jobfiles is the ChampSim binary used, so all jobfiles are created using the following 3 jobfiles:

- `experiments/experiments/1C_all_workloads.sh`: Baseline single-core experiments used to compute weighted speedup. 44 workloads.
- `experiments/experiments/single_workloads.sh`: Multi-core experiments with same workload on each core. 28 workloads.
- `experiments/experiments/all_workloads.sh`: All multi-core experiments (single, mixed, cloudsuite). 51 workloads.

We recommend making any changes to these three jobfiles (such as specifying the charge account for `slurm`, etc.), as required. Alternatively, try running a jobfile inside a directory within `experiments/experiments/all_figures/` to ensure it works (for example, `cd 8C_16WLLC && sbatch jobfile.sh`).

#### Option-2: Running Locally

Similar to the `slurm` option, we provide three jobfiles from which all configuration jobfiles can be derived:

- `experiments/experiments/1C_all_workloads.local.sh`: Baseline single-core experiments used to compute weighted speedup. 44 workloads.
- `experiments/experiments/single_workloads.local.sh`: Multi-core experiments with same workload on each core. 28 workloads.
- `experiments/experiments/all_workloads.local.sh`: All multi-core experiments (single, mixed, cloudsuite). 51 workloads.

We recommend making any changes to these three jobfiles as required. Alternatively, try running a jobfile inside a directory within `experiments/experiments/all_figures/` to ensure it works (for example, `cd 8C_16WLLC && ./jobfile.sh`).

#### Option-3: Create Your Own Jobfiles

Please customize `create_jobfile.pl` to create jobfiles to the format needed for launching experiments on your machine. Create the new jobfile comprising all experiments using the following command:

`perl ../scripts/create_jobfile.pl --exe $PYTHIA_HOME/../champsim/bin/8C_16WLLC --tlist START_8C_ALL.tlist --exp START.exp --local 1 > single_workloads.local.sh`

Note that you need to create jobfiles for 8-core all-workloads (`START_8C_ALL.tlist`), 8-core single-workloads (`START_8C_SINGLE.tlist`), and 1-core all-workloads (`START_1C_ALL.tlist`). Be sure to following the jobfile naming convention discussed in Option-2. 

**After referring to options above, proceed with launching experiments below.** One required change is updating the paths to champsim binary and traces in all three main jobfiles, and can be done easily with find and replace.

3. After making changes, run `./setup_exps.sh` to recreate jobfiles for all configurations.

4. Finally, launch experiments. 
    * **Option-1**: We provide a helper script `launch_exps.sh` that launches all experiments using the `sbatch` command. 
    * **Option-2 or 3**: If running locally, please launch each configuration manually and ensure number of running experiments are less than number of cores at any given time (otherwise context switches can degrade performance).


## Collect Statistics

**Update 12/1/2023**

We have added parsing scripts for remaining figures 9, 10, and 15. All figures are now reproduceable. 

**Update 11/30/2023**

We added stat collection scripts for Figures 2, 6, 7, 8, 13, 14, and 16 (that is, all representative figures along with motivation figure 2). They are located in `experiments/graphs/stat_scripts/` directory. Please run the script for each figure (`Figure_*.sh`), which will parse and collect relevant statistics (like normalized IPC, relative cache misses, etc.) into csv files stored in `experiments/graphs/stat_scripts/data/` directory.

The scripts assume `reprsentative_figures` are being recreated. If the simulation results are present in `all_figures`, please change the `STAT_DIR` variable in the `Figure_*.sh` scripts. 

We will add parsing scripts for remaining figures shortly.

**Common Error:** If the parsing script (or the python script that is internally called) is unable to locate the relevant file, please ensure the paths traversed by the scripts are correct (especially all the `*_DIR` variables in bash scripts).

## Visualize Results and Recreate Figures

**Update 11/30/2023**

Please find the Jupyter notebook to plot all figures in `experiments/graphs/plotting_nb/` directory. It can be launched using `jupyter-notebook START_plots.ipynb` command. Please be sure the requisite python package are installed, including matplotlib, numpy, pandas, and seaborn. 

After the parsing script for a figure has been run, you can re-run the cell corresponding to that figure to recreate it.

**Common Error:** If there is a key error, please go to the relevant csv and ensure the column names are as expected by the plotting file. Sometimes, the delimiter variable can cause incorrect parsing by Pandas' csv reader, which can be mitigated by using `r'\s+'` as the regex-enabled delimiter. 

Please contact the authors if errors are not resolved.