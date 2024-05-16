# Integrated healthy lifestyle even in late-life mitigates cognitive decline risk across varied genetic susceptibility

Code used for Wang et al. [NCOMMS-24-00647-T].

## Contents

- [Overview](#overview)
- [System Requirements](#system-requirements)
- [Installation Guide](#installation-guide)
- [Demo](#demo)
- [Instructions for use](#instructions-for-use)

# Overview

This file provides a [sample of the code](code/model.sas, code/plot.R) used in Wang et al. [NCOMMS-24-00647-T]. This code is intended for transparency and reproducibility and is not able to run.

This project uses [data](data/dataset.xlsx) including combined lifestyle score, weighted polygenic risk score, overall cognitive function and six cognitive dimensions (orientation, attention and calculation, visual construction, language, naming, and recall skills) at baseline and each follow-up surveys, and covariates (age, sex, educational level, area of residence, marital status, occupation, etc.) adjusted in the multivariate models.

This project also includes the used [data](data/dataset.xlsx) for each figure. 

Please contact Xiaoming Shi (shixm@chinacdc.cn) or Yuebin Lv (lvyuebin@nieh.chinacdc.cn) with any questions about this code.

# System Requirements

## All software dependencies and operating systems (including version numbers)
The [sample of the code](code/model.sas, code/plot.R) requires only a standard computer. 

## Versions the software has been tested on
SAS for Windows Version 9.4 is used for statistical analyses using a Microsoft Windows x64 operating system.
Users should have R version 4.3.1 from CRAN.

# Installation Guide

## Installing SAS 9.4
The SAS 9.4 installation guide for windows could be accessed via the following link ([Installing SAS 9.4](https://www.sas.com/content/dam/SAS/en_au/doc/academic/Quick-guide-for-SAS-Foundation-94-Installation.pdf)), with install time about 40 minutes.

## Installing R version 4.3.1 or higher and required R packages
The latest version of R can be installed by this link (https://cran.r-project.org), with install time about 5 minutes, and the details for required R packages installing could be seen in [sample of the code](code/plot.R). The typical install time on a “ggplot” desktop computer is less than one minute.

# Demo

The demo can be seen in [sample of the code](code/model.sas, code/plot.R).

# Instructions for Use

Users should open the [sample of the code](code/model.sas, code/plot.R) using SAS and R software.