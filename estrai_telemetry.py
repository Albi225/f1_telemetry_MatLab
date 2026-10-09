
import fastf1
import pandas as pd
import os

# Crea la cartella di cache se non esiste
if not os.path.exists('f1_cache'):
    os.makedirs('f1_cache')

fastf1.Cache.enable_cache('f1_cache') 

print("1. Inizio caricamento sessione Monza 2023...")
session = fastf1.get_session(2023, 'Monza', 'Q')
session.load()

print("2. Estrazione giri veloci di Sainz e Verstappen...")
lap_sai = session.laps.pick_driver('SAI').pick_fastest()
lap_ver = session.laps.pick_driver('VER').pick_fastest()

print("3. Estrazione telemetria...")
tel_sai = lap_sai.get_telemetry()
tel_ver = lap_ver.get_telemetry()

print("4. Salvataggio file CSV...")
cols = ['Distance', 'Speed', 'Throttle', 'Brake', 'RPM', 'nGear', 'X', 'Y', 'Z']
tel_sai[cols].to_csv('telemetria_SAI.csv', index=False)
tel_ver[cols].to_csv('telemetria_VER.csv', index=False)

print("PROCESSO COMPLETATO! I file CSV sono pronti.")