# 1969 Ford Mustang Sportsroof 200 Six Performance Performance Analysis

This repository houses a MATLAB script dedicated to analyzing the performance of a 1969 Ford Mustang Sportsroof 200 Six. Key metrics such as torque, power, and gear-shifting performance are assessed for both progressive and geometric gearboxes.

# Table of Contents

1. [**Introduction**](#1969-ford-mustang-sportsroof-200-six-performance-analysis)
    - Description of Repository and Car Model
2. [**Code Structure**](#code-structure)
    - Overview of Code Components
    * [**Initialization**](#initialization)
        1. [Workspace Setup](#workspace-setup)
        2. [Model Parameters](#model-parameters)
    * [**Data Setup**](#data-setup)
        1. [Torque & Power Arrays](#torque--power-arrays)
        2. [Polynomial Interpolation](#polynomial-interpolation)
    * [**Gearbox Analysis - Progressive**](#gearbox-analysis---progressive)
        1. [Top Gear Analysis](#top-gear-analysis)
        2. [Base Gear Analysis](#base-gear-analysis)
        3. [Intermediate Gear Coefficients](#intermediate-gear-coefficients)
        4. [Gear Shift Parameters](#gear-shift-parameters)
        5. [Upshift Velocity](#upshift-velocity)
        6. [Performance Metrics](#performance-metrics)
    * [**Gearbox Analysis - Geometric**](#gearbox-analysis---geometric)
        1. Overview and Calculations
3. [**Conclusion**](#conclusion)
    - Summary and Significance of Analysis

Note: The hyperlinks in the Table of Contents are for illustration purposes. If this is to be used on a platform that supports linking (like GitHub), the links should be made functional to lead to the corresponding sections of the document.

## Code Structure:

### Initialization:
- **Workspace Setup**: The script begins by clearing the workspace and command window with the `clearvars` and `clc` commands.
- **Model Parameters**: Necessary variables and parameters like mass, drag coefficient, gear ratios, and other pertinent car model information are initialized.

### Data Setup:
- **Torque & Power Arrays**: Two main arrays, `Te` (torque) and `Pe` (power), are set up corresponding to different rotational speeds.
- **Polynomial Interpolation**: The `polyfit` function is employed to create polynomial fits from the torque and power data, aiding in subsequent calculations for various rotational speeds.

### Gearbox Analysis - Progressive:
1. **Top Gear Analysis**: Computes the highest gear shift through the equilibrium of brake engine torque and resistive pressure. This gives the gear ratio for the topmost gear.
2. **Base Gear Analysis**: Determines the lowest gear shift based on max torque and other parameters, providing the value for the constant Kg.
3. **Intermediate Gear Coefficients**: Calculation of coefficients `C1`, `C2`, and `C3`, and gear ratios `ig2`, `ig3`, and `ig4`.
4. **Gear Shift Parameters**: Using the above data, the script assesses rotational speeds (`Ne3` & `Ne4`) for the 3rd and 4th gear shifts and their corresponding torque and tractive effort values.
5. **Upshift Velocity**: This determines when to shift up, by equalizing the tractive efforts across gears.
6. **Performance Metrics**: The code computes resistance, brake engine torque, time, and distance for a given speed range.

### Gearbox Analysis - Geometric:
- Replicates similar analyses as for the progressive gearbox, recalculating gear ratios, torque, tractive effort, and other performance indicators specific to a geometric gearbox.

## Conclusion:
This MATLAB script offers a deep dive into the performance attributes of the 1969 Ford Mustang Sportsroof 200 Six using a combination of mathematical modeling, data interpolation, and real-world physics, making it an invaluable tool for automotive enthusiasts and engineers alike.
