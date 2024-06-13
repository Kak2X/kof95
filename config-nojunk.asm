; Constants
NO_SGB_SOUND  EQU 1 ; Forces DMG-only sound playback. For emulators which don't implement SGB sound.
CPU_USAGE     EQU 1 ; Uses different code for VBlank waiting to make the CPU Usage bar in BGB work
SKIP_JUNK     EQU 1 ; Removes padding areas
LABEL_JUNK    EQU 0 ; If SKIP_JUNK isn't set, labels the padding areas.
FIX_BUGS      EQU 1 ; Self explainatory
OPTIMIZE      EQU 0 ; Additional optimizations
NO_CPU_AI     EQU 0 ; Disable CPU Opponent AI (but not the CPU-specific actions inside moves)
INF_TIMER     EQU 0 ; Default with infinite timer 
GOOD_INPUTS   EQU 1 ; Use less strict inputs for motions, as in 96 and later
LESS_SLOWDOWN EQU 1 ; Reduces slowdown effects
AIRTHROW_CPU  EQU 1 ; Enables the player to air-throw the CPU, which is arbitrarily disabled.
HITSTOP_FULL_DAMAGE   EQU 0 ; Enables full damage for moves, as in 96 and later. This breaks the balance, as air moves account for the reduced damage.
DEFAULT_DIPS          EQU $E0 ; $E0 ; Default dip switch settings
UNUSED_NAKORURU_INTRO EQU 0 ; Test for restoring the unused Nakoruru frames.

REV_VER      EQU 0 ; Game Version - Japan

INCLUDE "main.asm"