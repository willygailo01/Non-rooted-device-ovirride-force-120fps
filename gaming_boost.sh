#!/system/bin/sh
# =============================================================
# Non-root Gaming Boost Script - Force High Refresh + Perf Tweaks
# For PUBGM, CODM, MLBB, online games (2025-2026 tested commands)
# Run via Termux or ADB shell
# =============================================================

echo "Starting non-root gaming boost..."

# ────────────────────────────────────────────────
# 1. FORCE HIGH REFRESH RATE (120Hz or 144Hz)
# Works on many devices with 120/144 Hz panels
# ────────────────────────────────────────────────

# Try 144 Hz first (if your display supports it)
settings put system peak_refresh_rate 144.0
settings put system min_refresh_rate 144.0

# Fallback to 120 Hz (most common high-refresh phones)
settings put system peak_refresh_rate 120.0
settings put system min_refresh_rate 120.0

# Some devices use these instead (Xiaomi/POCO, Realme, etc.)
settings put global user_refresh_rate 144
settings put global preferred_refresh_rate 144
settings put global user_refresh_rate 120   # fallback

echo "Refresh rate forced → check in game if 120/144 Hz is active"

# ────────────────────────────────────────────────
# 2. Performance & GPU/CPU related tweaks
# ────────────────────────────────────────────────

# Force GPU rendering in some cases
setprop debug.force-opengl 1

# Some devices accept these (may do nothing on others)
setprop debug.gr.maxfps 144
setprop debug.gr.maxframe_rate 144.0
setprop debug.sf.latch_unsignaled 1       # reduce input lag

# Disable some power saving / thermal throttling (battery drains faster!)
cmd power set-fixed-performance-mode-enabled true

# Reduce animation scale → feels snappier
settings put global window_animation_scale 0.5
settings put global transition_animation_scale 0.5
settings put global animator_duration_scale 0.5

# ────────────────────────────────────────────────
# 3. Game-specific FPS override attempts (very low success rate non-root)
# Mostly placebo — real unlock needs root or Brevent/Shizuku
# ────────────────────────────────────────────────

# Example packages:
# PUBGM Global     com.tencent.ig
# PUBGM KR         com.pubg.krmobile
# CODM             com.activision.callofduty.shooter
# MLBB             com.mobile.legends

# Android 13+ Game Mode override (forces FPS in some cases - usually lower)
# Uncomment & change package + fps if you want to experiment (30/60/90/120)

# device_config put game_overlay com.tencent.ig mode=2,fps=120:mode=3,fps=60
# device_config put game_overlay com.activision.callofduty.shooter mode=2,fps=120
# device_config put game_overlay com.mobile.legends mode=2,fps=120

echo "Game mode overrides are commented out → success rate low without root"

# ────────────────────────────────────────────────
# 4. Final tips & revert
# ────────────────────────────────────────────────

echo ""
echo "Done! Now:"
echo "• Open game → check if refresh rate is 120/144 Hz (use show refresh rate in dev options)"
echo "• Battery will drain faster — performance mode is ON"
echo ""
echo "To revert refresh rate → go to Settings → Display → Refresh rate"
echo "or run: settings put system peak_refresh_rate 60.0 && settings put system min_refresh_rate 60.0"
echo ""
echo "For real 120/144 FPS unlock in PUBGM/CODM/MLBB → you usually need root + FPS unlocker module / GLTools / config editing"
echo "Non-root max is usually 90-120 Hz refresh + smoother feel, not true FPS unlock"

echo "Script finished."