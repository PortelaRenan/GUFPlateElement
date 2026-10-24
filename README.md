<div align="center">

# Plate Analysis with the Generalized Unified Formulation (GUF)

**FEM and Navier solutions based on PVD and RMVT, in MATLAB**

🎓 *Developed as part of my Master's thesis in Mechanical Engineering at UNICAMP*

![MATLAB](https://img.shields.io/badge/MATLAB-0076A8?logo=mathworks&logoColor=white)
![Topic](https://img.shields.io/badge/topic-composite%20plates-blueviolet)
![Thesis](https://img.shields.io/badge/Master's%20thesis-UNICAMP-red)
![Status](https://img.shields.io/badge/status-archive-lightgrey)

[About](#-about) · [Contents](#-contents) · [Method](#-method) · [How to run](#-how-to-run) · [Citation](#-citation) · [Contact](#-contact)

</div>

---

## 📌 About

This repository contains the MATLAB codes developed as part of my **Master's thesis in Mechanical Engineering at UNICAMP** (University of Campinas, Brazil).

The codes analyze the bending of **isotropic, orthotropic and laminated plates** with the **Generalized Unified Formulation (GUF)**. Two solution strategies are implemented:

- **Finite Element Method (FEM)**, based on the Principle of Virtual Displacements (PVD)
- **Navier analytical solutions**, based on the PVD and on the Reissner Mixed Variational Theorem (RMVT)

They can be used as **reference solutions** and as **study material** on plate theories and composite laminates.

<!-- Add the thesis title, advisor and a link to the thesis in the UNICAMP repository (Repositório da Unicamp) here -->

## 📂 Contents

All main scripts are MATLAB **Live Scripts** (`.mlx`). The supporting functions are in the [`Functions/`](Functions/) folder.

### 📐 Navier analytical solutions

| File | Description |
|---|---|
| [`main_GUF_PVD_Navier.mlx`](main_GUF_PVD_Navier.mlx) | Navier solution with GUF, based on the PVD |
| [`main_GUF_PVD_Navier_iso.mlx`](main_GUF_PVD_Navier_iso.mlx) | Navier solution with GUF, PVD, isotropic plate |
| [`main_GUF_PVD_Navier_iso_LW.mlx`](main_GUF_PVD_Navier_iso_LW.mlx) | Navier solution with GUF, PVD, isotropic plate, layer-wise (LW) model |
| [`main_GUF_RMVT_Navier.mlx`](main_GUF_RMVT_Navier.mlx) | Navier solution with GUF, based on the RMVT |

### 🔩 Finite element solutions

| File | Description |
|---|---|
| [`main_GUF_PVD_FEM_iso.mlx`](main_GUF_PVD_FEM_iso.mlx) | FEM with GUF, PVD, isotropic plate |
| [`main_GUF_PVD_FEM_ort.mlx`](main_GUF_PVD_FEM_ort.mlx) | FEM with GUF, PVD, orthotropic plate |
| [`main_GUF_PVD_FEM_ort_lam.mlx`](main_GUF_PVD_FEM_ort_lam.mlx) | FEM with GUF, PVD, laminated orthotropic plate |
| [`main_GUF_PVD_FEM_ort_lam_demasi1.mlx`](main_GUF_PVD_FEM_ort_lam_demasi1.mlx) | FEM with GUF, PVD, laminated orthotropic plate, "demasi1" case |
| `main_GUF_PVD_FEM_timoshenko_iso_sin*.mlx` | FEM, PVD, Timoshenko-type model, isotropic plate, sinusoidal load |
| `main_GUF_PVD_FEM_timoshenko_iso_un*.mlx` | FEM, PVD, Timoshenko-type model, isotropic plate, uniform load |

<!-- Replace the two file names with a `*` above by the full names of the files, and add links to them -->

## 🏷️ Naming convention

File names follow the pattern `main_Formulation_Variational_Method_Plate_Case.mlx`:

| Part | Meaning |
|---|---|
| `GUF` | Generalized Unified Formulation |
| `PVD` / `RMVT` | Principle of Virtual Displacements / Reissner Mixed Variational Theorem |
| `FEM` / `Navier` | Finite element solution / Navier analytical solution |
| `iso` / `ort` / `lam` | Isotropic / orthotropic / laminated |
| `LW` | Layer-wise model |
| `sin` / `un` | Sinusoidal / uniform load |

## 🧠 Method

- **Generalized Unified Formulation (GUF)**: a framework that generates plate theories of **arbitrary order** from a single compact formulation, by choosing how the displacements vary through the thickness. It covers both **equivalent single layer** and **layer-wise** models for laminated plates.
- **PVD**: the classical displacement-based variational statement.
- **RMVT**: a **mixed** variational statement, in which the transverse stresses are also primary variables. It is well suited to laminates, where transverse stresses must be continuous across the layer interfaces.

<!--
## 🖼️ Results
Add plots of displacements and stresses through the thickness here. Save the images in an images/ folder.
-->

## 🚀 How to run

**Requirements:** MATLAB R2016a or later, since the main scripts are Live Scripts (`.mlx`).

```matlab
% 1. Clone or download this repository and open the folder in MATLAB
% 2. Add the Functions folder to the MATLAB path:
addpath('Functions')
% 3. Open any main_*.mlx file and click Run
```

> ℹ️ GitHub cannot preview `.mlx` files. To read a script without MATLAB, open it in MATLAB and export it to PDF or HTML (**Save → Export to PDF/HTML**).

<!-- Describe the inputs (plate dimensions, material properties, layup, theory order, mesh, load) and the outputs here -->

## 📝 Citation

If you use these codes in your work, please cite the thesis:

```bibtex
@mastersthesis{portela_thesis,
  author = {Miranda Portela, Renan},
  title  = {Comparação de modelos de placa para a simulação de laminados compósitos},
  school = {University of Campinas (UNICAMP)},
  year   = {2020},
  url    = {https://repositorio.unicamp.br/acervo/detalhe/1161765?guid=1790121606930&returnUrl=%2Fresultado%2Flistar%3Fguid%3D1790121606930%26quantidadePaginas%3D1%26codigoRegistro%3D1161765%231161765&i=17}
}
```

## 📚 Further reading

- Demasi, L. (2008). ∞³ hierarchy plate theories for thick and thin composite plates: The generalized unified formulation. *Composite Structures*, 84(3), 256-270.
- Carrera, E. (2003). Historical review of zig-zag theories for multilayered plates and shells. *Applied Mechanics Reviews*, 56(3), 287-308.
- Reddy, J. N. (2004). *Mechanics of Laminated Composite Plates and Shells: Theory and Analysis*, 2nd ed. CRC Press.

## 🔗 Related projects

- [AnalyticalPlateSolution](https://github.com/PortelaRenan/AnalyticalPlateSolution): Navier and Lévy analytical solutions for plates in MATLAB
- [fem-python-lab](https://github.com/RenanMP12/fem-python-lab): FEM and numerical methods scripts in Python

## 📬 Contact

**Renan Portela**, PhD in Mechanical Engineering (University of Waterloo, Canada) · Master's in Mechanical Engineering (UNICAMP)

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?logo=linkedin&logoColor=white)](https://www.linkedin.com/in/YOUR-PROFILE)
[![Email](https://img.shields.io/badge/E--mail-D14836?logo=gmail&logoColor=white)](mailto:YOUR-EMAIL@example.com)

---

<div align="center">

⭐ If this repository helped you, leave a star!

</div>
