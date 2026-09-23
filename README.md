<div align="center">

# Titan Panel [Reagents]

### Spell reagent tracking and auto-buying for Titan Panel on WoW Classic

<img src="https://img.shields.io/github/v/release/NeeRgY/TitanReagents?style=for-the-badge" />
<img src="https://img.shields.io/github/last-commit/NeeRgY/TitanReagents?style=for-the-badge" />
<img src="https://img.shields.io/github/issues/NeeRgY/TitanReagents?style=for-the-badge" />
<br><br>

[![Curseforge](https://img.shields.io/curseforge/dt/1708397?label=CurseForge&color=F16436&style=for-the-badge)](https://www.curseforge.com/wow/addons/titan-panel-reagents)
[![Wago](https://img.shields.io/badge/Wago-TitanReagents-C1272D?style=for-the-badge&logo=wago&logoColor=white)](https://addons.wago.io/addons/PLACEHOLDER)
[![Discord](https://img.shields.io/discord/1538823169446645762?style=for-the-badge&label=Discord&color=5865F2)](https://discord.gg/YjfyDKckCS)
<br>

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/neergy)

---
<br>

A **Titan Panel** plugin that tracks your spell reagents (Rebirth seeds, Soul Shards, Symbol of Kings, poisons, and more) and can automatically top them up at any vendor.

**Current version:** `v1.0.0`

</div>

---

# About

TitanReagents is developed and maintained by **NeRgY**.

Goals of this addon:

- One addon covering **Classic Era, TBC Classic and WoW: Forever**
- One reagent gets one Titan Panel segment
- Localized UI (English, German, French, Spanish, Russian)

---

# Supported Clients

| Client | Interface |
|--------|-----------|
| Classic Era (`1.15.8` / `1.15.9`) | `11508` / `11509` |
| TBC Classic (`2.5.5` / `2.5.6`) | `20505` / `20506` |
| WoW: Forever (`1.60.1`) | `16001` |

All three are declared in a single `TitanReagents.toc` - one code tree, no per-version forks. Requires the base **Titan Panel** addon to be installed.

---

## Highlights

- One Titan Panel segment per trackable reagent, shown/hidden via Titan's own plugin menu
- Auto-buy at any vendor: pick 1-5 stacks, or set your own exact minimum stock to keep on hand
- Toggle between the spell icon and the reagent's own item icon, per reagent
- Covers Druid, Mage, Paladin, Priest, Rogue, Shaman and Warlock reagents
- Fully localized UI text (enUS, deDE, frFR, esES/esMX, ruRU) - reagent and spell names stay in the game client's own language automatically
- Built on the same Elib-4.0 plugin architecture as my other Titan Panel addons

---

# Installation

Download the latest release, then copy the `TitanReagents` folder into:

- Classic Era: `World of Warcraft\_classic_era_\Interface\AddOns\TitanReagents`
- TBC Classic: `World of Warcraft\_classic_\Interface\AddOns\TitanReagents`
- WoW: Forever: `World of Warcraft\_classic_beta_\Interface\AddOns\TitanReagents`

Then `/reload` in-game. Right-click any reagent's Titan Panel segment for options.

## Important

Do **NOT** download `Source code (zip)` / `Source code (tar.gz)` from GitHub tags.

---

# Contributing

Bug reports and fixes welcome. When reporting an issue, include:

- WoW version / client (Classic Era, TBC, Forever)
- Addon version (`v1.0.0`)
- Lua errors (BugSack / `/console scriptErrors 1`)
- Reproduction steps

---

# Support

- GitHub Issues: https://github.com/NeeRgY/TitanReagents/issues
- Repository: https://github.com/NeeRgY/TitanReagents

---

# Disclaimer

This project is unofficial and is not affiliated with Blizzard Entertainment.

World of Warcraft is a trademark of Blizzard Entertainment.

Use this addon at your own discretion.
