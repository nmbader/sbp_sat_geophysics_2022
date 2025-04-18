# Geophysics paper 2023: Modeling and inversion in acoustic-elastic coupled media using energy-stable summation-by-parts operators

- [Description](#Description)
- [Installation with Docker](#Installation-using-Docker)
- [Installation without Docker](#Installation-without-a-Docker)
- [Generating results](#Generating-results)

## Description

This project aims at reproducing the results shown in the journal article: Milad Bader, Martin Almquist, Eric M. Dunham; Modeling and inversion in acoustic-elastic coupled media using energy-stable summation-by-parts operators. *Geophysics* 2023; doi: https://doi.org/10.1190/geo2022-0195.1

## Installation using Docker

Start by cloning the current repository
```
git clone https://github.com/nmbader/sbp_sat_geophysics_2022.git
cd sbp_sat_geophysics_2022
```

Build the docker image (it should take a few minutes)
```
docker build -f Dockerfile -t geo22 .
```

Run a container
```
docker run -it -p 8080:8080 geo22
```

By default a bash shell will be opened at /home inside the container.
Run jupyter notebook from within the container
```
jupyter notebook --ip 0.0.0.0 --port 8080 --no-browser --allow-root &
```

Open the browser at *localhost:8080/​* and use the printed token above to authenticate.

The docker image will build **fwi2d** and **SPECFEM2D** libraries in single precision.

## Installation without a Docker

Start by cloning the current repository
```
git clone https://github.com/nmbader/sbp_sat_geophysics_2022.git
cd sbp_sat_geophysics_2022
```

Then, clone, build, and install the main software **fwi2d** that performs modeling and inversion
```
git clone https://github.com/nmbader/fwi2d.git
cd fwi2d
git checkout 1b20e7ee0bbe06eb43cbee18c91d7ed29809a8e4
```
Follow the instructions in the README of the software.

Install [**SPECFEM2D**](https://github.com/geodynamics/specfem2d) at a location of your choice and copy (or create symbolic links) the two executables *xmeshfem2D* and *xspecfem2d*  into the folder *./sbp_sat_geophysics_2022/specfem2d*.

Finally, install [**Devito**](https://github.com/devitocodes/devito) at a location of your choice and add the appropriate path to the python path.

## Generating results

Follow the instructions and run the [notebooks](https://github.com/nmbader/sbp_sat_geophysics_2022/tree/master/notebooks) in the given numbering order to generate the results and figures of the paper.
