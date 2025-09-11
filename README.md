# arsenal_hider

A tiny CBA/ACE3 addon that **globally hides blacklisted classnames** from all ACE Arsenal instances.
It removes items both when an ACE Arsenal UI opens and when an arsenal box initializes.

## Build (HEMTT)
1. Install **HEMTT**.
2. Place this folder anywhere (e.g., `E:\git\mods\arsenal_hider`).
3. Build:
   ```powershell
   hemtt build
   ```
4. Launch straight into ACE Arsenal (per the `hemtt.toml` profile):
   ```powershell
   hemtt launch arsenal
   ```

## Configure blacklist
- Edit `addons/main/XEH_postInit.sqf` and change the `ARSENAL_HIDER_BLACKLIST` array.
- Or set a persistent list in your profile before launching (optional):
  ```sqf
  // Paste in debug console once; persists in profileNamespace
  profileNamespace setVariable ["arsenal_hider_blacklist", ["arifle_AK12_F","LMG_03_F"]];
  saveProfileNamespace;
  ```

## Notes
- Requires **CBA_A3** and **ACE3**.
- No custom functions are used; we directly call ACE Arsenal helpers:
  - `ace_arsenal_fnc_removeVirtualItems`
  - Events: `ace_arsenal_displayOpened`, `ace_arsenal_boxInitialized`

## Structure
```
addons/
  main/
    config.cpp
    XEH_postInit.sqf
    $PBOPREFIX$
hemtt.toml
README.md
mod.cpp
```
