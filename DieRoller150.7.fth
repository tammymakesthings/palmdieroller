\ DieRoller150.7 2000.09.30 TLC

\ ----------------------------
\ DieRoller: Gamer's dice 
\            roller for the
\            PalmPilot.
\ 
\ By Tammy Cravit,
\ tammymakesthings@gmail.com
\ All rights reserved.
\ 
\ This version is released as 
\ freeware, as-is, with no 
\ warranty of any kind. This 
\ program, and its source, may 
\ be freely redistributed,
\ provided this notice is 
\ preserved intact.
\ ----------------------------
\ To execute in Quartus Forth:
\     needs ids
\     needs DieRoller150.7
\     go
\ 
\ To compile to a .prc file:
\     needs ids
\     needs MakeDieRoller
\ ----------------------------

needs ids
needs toolkit
needs tools-ext
needs resources
needs Forms
needs Fields
needs Events
needs condthens
needs random
needs zstrings

\ \\\\\\\\\\\\\\\\\\\\\\\\\\\\
\ Variable definitions
\ \\\\\\\\\\\\\\\\\\\\\\\\\\\\

1 constant PrefsVersion
-257 constant byeThrow

create rolls 8 cells allot
variable sum
variable controlid
variable curitem

here constant prefs-base
variable nsides
variable ndice
here prefs-base - constant prefs-size

.( - Loading DieRollerRsrcs...) cr
needs DieRollerRsrcs150.7

.( - Loading DieRollerAlgo...) cr
needs DieRollerAlgo150.7

.( - Loading DieRollerUI...) cr
needs DieRollerUI150.7

.( - Loading DieRollerPrefs...) cr
needs DieRollerPrefs150.7

.( - Loading DieRollerMain...) cr
needs DieRollerMain150.7

.( DieRoller Project Loaded.) cr

