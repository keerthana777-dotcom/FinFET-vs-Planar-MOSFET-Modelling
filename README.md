# Comparative Modeling of Planar MOSFET and FinFET (45nm)

## 📌 Overview
This project presents a MATLAB-based analytical modeling study comparing short-channel effects in Planar MOSFET and FinFET devices at 45 nm channel length.

The focus is on:
- Threshold voltage roll-off
- Drain Induced Barrier Lowering (DIBL)
- Velocity saturation effects
- Electrostatic integrity comparison

## Motivation
As CMOS devices scale into the nanometer range, planar MOSFETs suffer from short-channel effects. Multi-gate devices like FinFET provide improved electrostatic control and reduced leakage.

## Modeling Approach
- Roll-off modeled as: Vt = Vt0 − α/L
- DIBL modeled as: Vt_eff = Vt − ηVds
- FinFET effective width: Weff = 2Hfin + Wfin
- Numerical DIBL extraction implemented

## Key Results
- FinFET exhibits significantly lower DIBL
- Improved threshold stability
- Better electrostatic control at nanoscale

## Tools Used
- MATLAB
- Compact device modeling
- Nano-device physics concepts

## Repository Structure
- planar_model.m
- finfet_model.m
- comparison_planar_vs_finfet.m
- results/

## Author
Keerthana Tummala  
B.Tech – Electronics and Communication Engineering
