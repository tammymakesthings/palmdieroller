\ DieRollerPrefs150.7 2000.09.30 TLC

\ -----------------------------------
\ DieRoller 1.5
\ Copyright (c) 2000,2020, Tammy Cravit
\ tammymakesthings@gmail.com
\ All rights reserved.
\ -----------------------------------

\ \\\\\\\\\\\\\\\\\\\\\\\\\\\\
\ Preferences functions
\ \\\\\\\\\\\\\\\\\\\\\\\\\\\\

: >prefs ( -- )
	\ Save the preferences
	prefs-size prefs-base >abs 
	PrefsVersion [ID] diE#
	PrefSetAppPreferencesV10
	;

: prefs> ( -- flag ) 
	\ Get the preferences
	prefs-size prefs-base >abs 
	PrefsVersion [ID] diE#
	PrefGetAppPreferencesV10
	;

: app-init ( -- )
	prefs> 0 = if
		3 ndice !
		6 nsides !
		>prefs
	then
	;
