# AGENTS.md — Waybar Configuration

## 📍 Scope
**Only modify files in `~/.dotfiles/.config/waybar/`**

### ✅ Allowed
- R/W in `~/.dotfiles/.config/waybar/`
- R/W in `~/.config/waybar/` (symlink to dotfiles)
- R/W in `/etc/xdg/waybar/` (for system-wide styles)

### ❌ Forbidden
- Git operations — use `write` or `edit` only
- Modify files outside `~/.dotfiles/.config/waybar/`
- Touch `.env`, `secrets/`, `vendor/`, `node_modules/`, `.venv/`

### 🔄 Workflow
After any CSS change, Waybar reloads automatically (`reload_style_on_change: true`).
Manual restart only needed for config changes:
```bash
pkill waybar; sleep 1; systemctl --user start waybar.service
```

---

## 🎨 Theme: Monokai Classic

### Colors
```css
/* Base palette */
--bg: #272822        /* Panel background */
--text: #f8f8f2      /* Default text */
--accent: #75715e    /* Secondary text/hover underline */

/* Module colors */
--green: #a6e22e     /* console, success */
--blue: #66d9ef      /* console (default), info */
--pink: #f92672      /* monitor-off, errors */
--purple: #ae81ff    /* accents */
```

### Effects
- **Glass effect:** `rgba(248, 248, 242, 0.05)` background
- **Hover:** `rgba(248, 248, 242, 0.15)`
- **Border:** `1px solid rgba(117, 113, 94, 0.2-0.3)`
- **Border hover:** `1px solid rgba(117, 113, 94, 0.5)`
- **Border-radius:** `20px` for all groups
- **Font:** `JetBrainsMono NF ExtraLight`, `16px`

---

## 📦 Modules Layout

### Left Panel
```json
modules-left:
  - workspaces (niri/workspaces)
  - media (custom/media)
  - quick-actions group
```

### Center Panel
```json
modules-center:
  - privacy
  - window (niri/window)
```

### Right Panel
```json
modules-right:
  - pulseaudio
  - hardware group
  - power-control group
  - language (niri/language)
  - clock
  - tray
  - power (custom/power menu)
```

---

## 🔘 quick-actions Group

**Horizontal** group with 3 buttons (Monokai colors):

| Button | Icon | Color | Action |
|--------|------|-------|--------|
| `custom/console` | `󰞷` | `#66d9ef` (blue) | `alacritty --command bash -c "tmux attach || systemd-run --user --scope tmux new-session"` |
| `custom/monitor-off` | `󰶐` | `#f92672` (pink) | `sleep 0.5 && niri msg action power-off-monitors` |
| `custom/mako-clear-notifications` | `󱙍` | `#a6e22e` (green) | `makoctl dismiss --all` |

**Styling:**
- Group: `rgba(248, 248, 242, 0.05)` bg, `20px` radius, `1px` border
- Buttons: transparent bg, `rgba(248, 248, 242, 0.15)` hover
- Spacing: `margin: 0 25px` between buttons

---

## 🔋 power-control Group

**Horizontal** group with 3 modules:
- `battery`
- `power-profiles-daemon`
- `backlight`

**Styling:** Glass effect + border, always expanded (no drawer)

---

## ⚙️ hardware Group

**Horizontal** group with 3 modules:
- `cpu`
- `memory`
- `temperature`

**Styling:** Glass effect + border, always expanded (no drawer)

---

## ⚡ custom/power (Power Menu)

Single button with dropdown menu:
- Icon: `⏻`
- Menu file: `~/.config/waybar/custom_modules/power_menu.xml`
- Actions: shutdown, reboot, suspend, hibernate

**Styling:** Glass effect + border, margin `0 10px`

---

## 📝 File Structure

```
~/.dotfiles/.config/waybar/
├── AGENTS.md          ← This file
├── config.jsonc       ← Main config
├── style.css          ← Styles (symlink target)
└── custom_modules/
    ├── power_menu.xml
    └── mediaplayer.py

~/.config/waybar/      ← Runtime (symlinks to dotfiles)
├── config.jsonc       ← symlink to dotfiles
├── style.css          ← symlink to dotfiles
└── custom_modules/    ← same as dotfiles

/etc/xdg/waybar/
└── style.css          ← System fallback (optional)
```

**Symlink chain:**
```
~/.config/waybar/style.css → ~/.dotfiles/.config/waybar/style.css
~/.dotfiles/.config/waybar/style.css → ~/.config/waybar/style.css
```

---

## 🔧 Quick Reference

### Change font size
Edit `style.css`, `* { font-size: 16px; }`

### Change panel height
Edit `config.jsonc`, `"height": 29`

### Add new custom module
1. Create `~/.config/waybar/custom_modules/<name>.py` or `.xml`
2. Add `"custom/<name>"` to `modules-left/center/right`
3. Configure in `"custom/<name>": { ... }` section
4. Add styling in `style.css`

### Disable a group
Remove from `modules-right/left` list in `config.jsonc`

### Change colors
Edit `~/.dotfiles/.config/waybar/style.css` `@define-color` section

---

## 🐛 Troubleshooting

### Waybar not loading
```bash
journalctl --user --unit waybar.service -n 20 --no-pager
pkill waybar; systemctl --user restart waybar.service
```

### CSS not applying
Check symlink: `ls -la ~/.config/waybar/style.css`
Should point to `~/.dotfiles/.config/waybar/style.css`

### Module not showing
Check config: `grep -A 5 "modules-right" ~/.config/waybar/config.jsonc`
Verify custom modules exist in `custom_modules/`

### Style errors in log
```bash
grep "waybar\[.*\]" <(journalctl --user -f waybar.service)
```

---

## 📚 External Resources
- [Waybar Wiki](https://github.com/Alexays/Waybar/wiki)
- [Niri Workspaces Module](https://github.com/niri-dev/niri/wiki/Workspaces-Module)
- [Custom Modules](https://github.com/Alexays/Waybar/wiki/Custom-Modules)
