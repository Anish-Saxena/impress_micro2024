# START: Scalable Tracking for Any Rowhammer Threshold

This repository is part of the evaluation artifact for the [START](https://arxiv.org/abs/2308.14889) paper, which will appear at [HPCA 2024](https://www.hpca-conf.org/2024/). 

## Introduction

Experiments in the START paper are conducted using [ChampSim](https://github.com/ChampSim/ChampSim), a cycle-level multi-core simulator, interfaced with [DRAMSim3](https://github.com/umd-memsys/dramsim3), a detailed memory system simulator. The trace download and jobfile management is borrowed from the infrastructure used in [Pythia](https://github.com/CMU-SAFARI/Pythia). Accordingly, the code and experimentation framework of START has been partitioned into 3 repositories for modularity. 

This repository hosts the experimental workflow (experiment directories, jobfiles, stat collection, etc.) adopted from Pythia.

**NOTE:** The documentation is common across all 3 repositories, so feel free to start here.

## System Requirements

   - **SW Dependencies** 
     - Tested with cmake v3.23.1, g++ v10.3.0, md5sum v8.22, perl v5.16.3, megatools 1.11.0, and Python XYZ.
   - **Benchmark Dependencies** 
     - Publicly available ChampSim-compatible traces of SPEC2017, LIGRA, PARSEC, and CloudSuite workloads.
   - **HW Dependencies** 
     - A scale-out system like many-core server or HPC cluster.
     - Our experiments were performed on the [PACE](https://pace.gatech.edu) cluster at Georgia Tech.
     - Most configurations run simulations for 28 workloads for about 6 hours on average (with one workload per core). Some configurations run 51 workloads per configurations.
     - Overall, there are 48 configurations, requiring about 9,000 core-hours to replicate all results (about 1-2 days on four 64-core servers).

**NOTE:** If compute resources are limited, we consider the key results of the paper to be those displayed in Figure 6, 7, 8, 13, 14, and 16, which corresponds to 16 configurations, requiring about 3,600 core-hours (about 1-2 days on a 64-core server).

## Compilation Steps

The expected directory structure is:

```
start_hpca24_ae
|-dramsim3
|-champsim
|-experiments
```

* `mkdir start_hpca24_ae`

### Build DRAMSim3

* `git clone https://github.com/Anish-Saxena/rowhammer_dramsim3 dramsim3`
* `cd dramsim3`
* `mkdir build && cd build && cmake ..`
* `make -j8`
* `cd ..`

### Setup ChampSim Build Environment

* `git clone https://github.com/Anish-Saxena/rowhammer_champsim champsim`
* `cd champsim`
*  `./set_paths.sh`

### Compile One Configuration for Testing

* `./config.py configs/8C_16W.json`
* `make -j8`
* `cd ..`

Ensure that the compilation completes without error. 

**Common Error**: The compiler may not be able to link the dramsim3 library. If so, check that the path is correctly set in `config.py` (search for LDLIBS). 

### Download Traces

* `git clone https://github.com/Anish-Saxena/rowhammer_pythia experiments`
* `cd experiments`
* `source setvars.sh`
* `mkdir traces`
* `cd scripts/`
* `perl download_traces.pl --csv START_traces.csv --dir ../traces/`
* `cd ../traces/`
* `md5sum -c ../scripts/START_traces.md5`
* `cd ../../`

The 44 traces might take an hour or more to download, depending both on the host network bandwidth and bandwidth allocation provided by Megatools (for LIGRA and PARSEC traces). Ensure that the checksum passes for all traces.

**Common Error**: If Megatools does not work, download the latest megatools utility for the relevant platform from [Megatools Builds](https://megatools.megous.com/builds/builds/), untar it (`tar -xvf <filename`), and update the `megatool_exe` parameter in `download_traces.pl`.

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

START adopts [Pythia's](https://github.com/CMU-SAFARI/Pythia) experimental workflow by launching experiments preferably on an HPC compute cluster followed by rolling up statistics.

Each configuration runs either 28 workloads (used in the main apper) or all 51 workloads (used in appendix). Overall, there are 48 configurations required to recreate all figures in the paper, and 16 configurations to recreate the representative figures.

### Build ChampSim Configurations

1. `cd champsim`
2. If recreating all figures, `./build_configs.sh configs/all_figures.configs`. Otherwise, `./build_configs.sh configs/representative_figures.configs`.

### Launch Experiments

Recreating all figures requires 1528 experiment runs (each requiring one core and 4GB memory). Recreating representative figures requires 609 experiments runs. Each experiment requires 6 core-hours on average, or about 9K core-hours to recreate all experiments and 3.6K core-hours to recreate representative experiments. 

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