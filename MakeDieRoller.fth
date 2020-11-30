\ MakeDieRoller 2000.09.30 TLC

\ -----------------------------------
\ DieRoller 1.5
\ Copyright (c) 2000, 2020, Tammy Cravit
\ tammymakesthings@gmail.com
\ All rights reserved.
\ -----------------------------------

needs ids

.( ***** Compiling DieRoller *****)
cr

.( Loading source files...) cr
needs DieRoller

.( Building PRC file...) cr
' go (ID) diE# MakePRC DieRoller

.( Copying Resources...) cr
DRMainForm  (ID) tFRM CopyRsrc
DRAboutForm (ID) tFRM CopyRsrc
DRHelpForm  (ID) tFRM CopyRsrc
9000        (ID) MBAR CopyRsrc
1000        (ID) tAIB CopyRsrc
1           (ID) tAIN CopyRsrc
1           (ID) tver CopyRsrc
8000        (ID) tSTR CopyRsrc

BlankFormID  (ID) tFRM DelRsrc drop
MainFormID   (ID) tFRM DelRsrc drop
TitledFormID (ID) tFRM DelRsrc drop

.( ***** Compile Done *****) cr
