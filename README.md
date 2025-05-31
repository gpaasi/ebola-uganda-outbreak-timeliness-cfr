# Uganda Ebola Outbreak Meta-Analysis (Review Paper)

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.15564078.svg)](https://doi.org/10.5281/zenodo.15564078)
[![GitHub Repository](https://img.shields.io/badge/GitHub-ebola--uganda--outbreak--timeliness--cfr-blue)](https://github.com/gpaasi/ebola-uganda-outbreak-timeliness-cfr)

 
This repository contains all data extraction sheets, R scripts, and analytic outputs for the review paper:
**"The impact of diagnostic delays and timeliness of response on Ebola disease outbreak-level case-fatality ratios in Uganda (2000–2023)."**

---

## Table of Contents
1. [Project Overview](#project-overview)
2. [Repository Structure](#repository-structure)
3. [Prerequisites](#prerequisites)
4. [Data Extraction](#data-extraction)
5. [Analysis & Reproducibility](#analysis--reproducibility)
   - [R Script: meta_analysis.R](#r-script-meta_analysisr)
   - [Generating Figures](#generating-figures)
   - [Session Information](#session-information)
6. [How to Cite](#how-to-cite)
7. [License](#license)
8. [Zenodo Deposition](#zenodo-deposition)
9. [Contact Information](#contact-information)

---

## Project Overview

This project synthesizes data from seven laboratory-confirmed Ebola virus disease (EBOD) outbreaks in Uganda between 2000 and 2023. Using a rapid systematic review and meta-analysis, we quantify outbreak-level case-fatality ratios (CFRs) and investigate how diagnostic and response delays impact CFRs. Analyses were conducted in R (version 4.3.2) using the `metafor` package for meta-analysis and `ggplot2` for visualization. 

---

## Repository Structure

```
/
├── README.md
├── LICENSE
├── CITATION.cff
├── requirements.txt
├── zenodo.json
├── data/
│   ├── data_extraction_with_guide.csv
│   ├── data_extraction_example.csv
├── code/
│   ├── meta_analysis.R
│   └── session_info.R
└── figures/
    ├── forest_plot_cfr.png
    ├── bubble_plot_delay_vs_cfr.png
    └── bubble_plot_onset_to_response.png
```

- **data/**: Contains the data extraction template (`data_extraction_with_guide.csv`) and a filled example file (`data_extraction_example.csv`) illustrating structure.
- **code/**: 
  - `meta_analysis.R`: Main R script performing meta-analysis, meta-regression, and saving figures.
  - `session_info.R`: Script capturing the R session environment for reproducibility.
- **figures/**: Placeholder folder where generated figures (e.g., forest plots, bubble plots) will be saved.
- **requirements.txt**: Lists R package dependencies required to run the analysis.
- **CITATION.cff**: Citation metadata for the repository.
- **zenodo.json**: Metadata file for depositing the repository to Zenodo.
- **LICENSE**: Creative Commons Attribution 4.0 International License.
- **README.md**: This document.

---

## Prerequisites

- **R** (version >= 4.3.2)
- **RStudio** (optional, recommended)
- Required R packages (specified in `requirements.txt`):
  - `metafor` (>= 3.0-2)
  - `ggplot2` (>= 3.3.0)
  - `dplyr` (>= 1.0.0)
  - `readr` (>= 1.3.1)

To install packages, open R and run:
```r
install.packages(c("metafor", "ggplot2", "dplyr", "readr"))
```
---

## Data Extraction

1. **Template**: Use `data/data_extraction_with_guide.csv`. This CSV contains column headers and guide text for each field.
2. **Example**: `data/data_extraction_example.csv` shows a filled example for one outbreak (Gulu 2000). 
3. **Fill-in**: Populate rows for each included study/outbreak. Each column is defined in the guide embedded in the template.

---

## Analysis & Reproducibility

### R Script: meta_analysis.R
The `code/meta_analysis.R` script performs all analyses:

1. **Load Data**: Reads `data/data_extraction_with_guide.csv`.
2. **Data Cleaning**: Filters outbreaks with complete data for CFR calculation and timeliness metrics.
3. **CFR Calculation**: Computes CFR as `Deaths / Confirmed_Cases`.
4. **Transformation**: Applies Freeman-Tukey double-arcsine transformation for meta-analysis.
5. **Meta-Analysis**: 
   - Pooled CFR using a random-effects model.
   - Generates a forest plot (`figures/forest_plot_cfr.png`).
6. **Meta-Regression**:
   - Regression of transformed CFR on diagnostic delay (`Days_FirstCase_to_SpecimenCollection`).
   - Regression of transformed CFR on MoH response delay (`Days_Onset_of_IndexCase_to_MoHResponse`).
   - Saves bubble plots to `figures/`.

To run, set your working directory to the repository root and execute:
```r
source("code/meta_analysis.R")
```

### Generating Figures
The R script will save figures to the `figures/` directory:
- `forest_plot_cfr.png`
- `bubble_plot_delay_vs_cfr.png`
- `bubble_plot_onset_to_response.png`

Ensure the `figures/` folder exists before running the script.

### Session Information
Reproducibility is enhanced by capturing the R session details. The `code/session_info.R` script outputs the session info to `session_info.txt`. Run:
```r
source("code/session_info.R")
```
This file records package versions and R environment details.

---

## How to Cite

Please use the following citation when referencing this repository:

```
Paasi, George; Okwware, Sam; Olupot-Olupot, Peter (2025). Ebola Outbreak Meta-Analysis Data and Code. Zenodo. https://doi.org/10.5281/zenodo.15537213
```

For software citation, refer to `CITATION.cff`.

---

## License

This repository is licensed under the Creative Commons Attribution 4.0 International License (CC BY 4.0). See [LICENSE](LICENSE) for details.

---

## Zenodo Deposition

Metadata for Zenodo is provided in `zenodo.json`. Once the repository is finalized:
1. Zip the repository or link directly to GitHub.
2. Submit to Zenodo using the `zenodo.json` metadata.
3. Ensure DOI: 10.5281/zenodo.15564078 is minted and matches.

---

## Contact Information

For questions, issues, or contributions, please open an issue on the GitHub repository:

https://github.com/gpaasi
 
---

