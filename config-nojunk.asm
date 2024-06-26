; Constants
DEF NO_SGB_SOUND  EQU 1 ; Forces DMG-only sound playback. For emulators which don't implement SGB sound.
DEF CPU_USAGE     EQU 1 ; Uses different code for VBlank waiting to make the CPU Usage bar in BGB work
DEF SKIP_JUNK     EQU 1 ; Removes padding areas
DEF LABEL_JUNK    EQU 0 ; If SKIP_JUNK isn't set, labels the padding areas.
DEF FIX_BUGS      EQU 1 ; Self explainatory
DEF OPTIMIZE      EQU 0 ; Additional optimizations
DEF NO_CPU_AI     EQU 0 ; Disable CPU Opponent AI (but not the CPU-specific actions inside moves)
DEF INF_TIMER     EQU 0 ; Default with infinite timer 
DEF GOOD_INPUTS   EQU 1 ; Use less strict inputs for motions, as in 96 and later
DEF LESS_SLOWDOWN EQU 1 ; Reduces slowdown effects
DEF AIRTHROW_CPU  EQU 1 ; Enables the player to air-throw the CPU, which is arbitrarily disabled.
DEF HITSTOP_FULL_DAMAGE   EQU 1 ; Enables full damage for moves, as in 96 and later. This breaks the balance, as air moves account for the reduced damage.
DEF DEFAULT_DIPS          EQU $E0 ; $E0 ; Default dip switch settings
DEF UNUSED_NAKORURU_INTRO EQU 1 ; Test for restoring the unused Nakoruru frames.

DEF REV_VER      EQU 0 ; Game Version - Japan

INCLUDE "main.asm"