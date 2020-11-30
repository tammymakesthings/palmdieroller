\ DieRollerAlgo150.7 2000.09.30 TLC

\ -----------------------------------
\ DieRoller 1.5
\ Copyright (c) 2000, 2020, Tammy Cravit
\ tammymakesthings@gmail.com
\ All rights reserved.
\ -----------------------------------

true constant debug
true constant win32for-compat

variable kk
variable mm

\ \\\\\\\\\\\\\\\\\\\\\\\\\\\\
\ Helper words
\ \\\\\\\\\\\\\\\\\\\\\\\\\\\\

: dropn ( n -- )
    0 do drop loop ;
: elem@ ( var n -- elem )
    cells + @ ;
: elem! ( value var n -- )
    cells + ! ;

\ \\\\\\\\\\\\\\\\\\\\\\\\\\\\
\ Debugging words
\ \\\\\\\\\\\\\\\\\\\\\\\\\\\\

\ Display the roll values

debug [if]

: rolls? ( -- )
    8 0 do
        rolls i elem@
    loop
    .s
    8 dropn ;

[then]

\ \\\\\\\\\\\\\\\\\\\\\\\\\\\\
\ Roll algorithm words
\ \\\\\\\\\\\\\\\\\\\\\\\\\\\\

\ A method suggested by Neal
\ Bridges to generate unbiased
\ random numbers between 1 and x.

: random-nsides ( sides -- 1..sides )
    1 mm !  0 kk !
     begin
        begin
             mm @ over < while
                  mm @ 2* mm !
                kk @ 2*
                rand 1 and or
                kk !
                 repeat
             dup kk @ - 1- 0< if
                   dup negate dup
                   mm +!  kk +!
             else
                 drop kk @ exit
             then
       again
       1+
    ;

: fix-rolls
    8 0 do
        rolls i elem@ 1+
        rolls i elem!
    loop
    ;

\ Roll normal dice

: roll-dice ( nsides -- )
    nsides !
    8 0 do
        nsides @ random-nsides
        rolls i elem!
    loop
    fix-rolls
    ;

\ Roll percentile dice
\ (((1d10*10) + 1d10)
\     mod 100) + 1

: roll-pctile ( -- )
    10 roll-dice
    rolls 0 elem@ 10 *
    rolls 1 elem@ +
    100 mod 1 +
    rolls 0 elem!
    8 1 do
        0 rolls i elem!
    loop
    ;

