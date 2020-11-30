\ DieRollerUI150.7 2000.09.30 TLC

\ -----------------------------------
\ DieRoller 1.5
\ Copyright (c) 2000, 2020, Tammy Cravit
\ tammymakesthings@gmail.com
\ All rights reserved.
\ -----------------------------------

\ \\\\\\\\\\\\\\\\\\\\\\\\\\\\
\ User Interface Words
\ \\\\\\\\\\\\\\\\\\\\\\\\\\\\

\ Sets the label of a control 
\ from a numeric value
: num>label 
	( num controlid -- )
	controlid !				
	0 <# 0 hold #s #> drop 
	>abs
	controlid @ SetLabel
	;

\ Update the display
: update-roll-display ( -- )
	9 1 do
		rolls i 1- elem@
		ResultTriggerBase i +
		num>label
	loop
	sum @ MainForm.TotalCtl 
	num>label
	;

\ Sum the selected checkboxes
: compute-sum ( -- )
	0 sum !
	9 1 do
		SumCheckboxBase i + 
		GetControlValue if
			rolls i 1 - elem@ 
			sum +!
		then
	loop
	;

\ Figure out which type of 
\ dice we're rolling
: find-nsides ( -- )
	cond
		DieTypeD4
		GetControlValue if
			4 nsides !
	else
		DieTypeD6
		GetControlValue if
			6 nsides !
	else
		DieTypeD8
		GetControlValue if
			8 nsides !
	else
		DieTypeD10
		GetControlValue if
			10 nsides !
	else
		DieTypeD12
		GetControlValue if
			12 nsides !
	else
		DieTypeD20
		GetControlValue if
			20 nsides !
	else
		DieTypeDPct
		GetControlValue if
			100 nsides !
	else
		-1 nsides !
	thens
	;

\ Find the # of dice to roll
: find-ndice ( -- )
	9 1 do 
		DieNumBase i + 
		GetControlValue if
			i ndice !
		then
	loop
	;
		
\ Zero out unneeded die values
: zero-extras ( -- )
	9 ndice @ do
		0 rolls i elem!
	loop
	;

\ Check all dice whose values
\ are non-zero
: mark-selected-dice ( -- )
	9 1 do
		rolls i 1- elem@ 0= if
			false
		else
			true
		then
		SumCheckboxBase
		i + 
		SetControlValue
	loop
	;

\ Roll the dice
: do-roll ( -- )
	find-nsides 
	find-ndice
	cond
		nsides @ 100 = if
			roll-pctile
		else
			nsides @ roll-dice
			zero-extras
	thens
	
	mark-selected-dice
	compute-sum
	update-roll-display
	;

\ Handle a checkbox tap
: handle-checkbox ( -- ) 
	compute-sum 
	update-roll-display
	;
