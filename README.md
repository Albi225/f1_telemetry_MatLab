
# F1 Telemetry Analysis: Sainz vs Verstappen (Monza 2023)

Automated telemetry retrieval and analysis tool built with **Python (FastF1)** and **MATLAB**. This project extracts telemetry data from the 2023 Italian GP qualifying session and performs speed, throttle, braking, and Delta Time comparison between Carlos Sainz Jr. and Max Verstappen.

---

## 🛠️ Project Architecture

1. **Data Extraction (`estrai_telemetry.py`)**: Uses the `FastF1` library to query official F1 session data and exports channels (`Speed`, `Throttle`, `Brake`, `Distance`, `RPM`, `nGear`) to structured CSV files.
2. **Data Analysis & Visualization (`analisi_telemetry.m`)**:
   - Imports CSV datasets into MATLAB.
   - Cleans and converts boolean brake traces into numerical format.
   - Computes cumulative **Delta Time** ($\Delta t = \int \frac{dx}{v}$) with numerical integration and linear interpolation.

---

## 📊 Results & Telemetry Comparison

### Speed, Throttle & Brake Comparison
The graph below highlights the brake application points, full-throttle zones, and speed profiles across the 5.8 km lap at Monza.

*(Carica qui lo screenshot dei grafici in MATLAB)*

### Delta Time Analysis
- **Main Straight (0–800m)**: Ferrari exhibits higher top speed, gaining ~0.08s.
- **Rettifilo Chicane (800–1100m)**: Red Bull recovers time due to superior low-speed traction.
- **Parabolica / Alboreto Corner (5000–5800m)**: Verstappen gains significant time on exit, taking the overall delta.

---

## 🚀 How to Run

### Prerequisites
- Python 3.10+
- MATLAB R2021b or newer

### Setup
1. Clone the repository:
   ```bash
   git clone [https://github.com/IL_TUO_USERNAME/f1-telemetry-matlab.git](https://github.com/alberto.pellizzer-eng/f1-telemetry-matlab.git)
   ```
2. Install Python dependencies:
   ```bash
   pip install fastf1 pandas
   ```
3. Run the Python script to fetch telemetry:
   ```bash
   python estrai_telemetry.py
   ```
4. Open and run `analisi_telemetry.m` in MATLAB.

---
*Author: Pellizzer Alberto – B.Sc. Electronic Engineering Student at SUPSI*