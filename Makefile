# DieRoller: Gamer's dice roller for the PalmPilot.
# 
# By Tammy Cravit, <tammymakesthings@gmail.com>
# All rights reserved.
# 
# This version is released as freeware, as-is, with no warranty of any kind.
# This program, and its source, may be freely redistributed, provided this 
# notice is preserved intact.

PILRC = pilrc 
BUILDPRC = build-prc 
ZIP = zip
TAR = tar
RM = rm

default :
	@echo No target specified. Valid targets are:
	@echo.
	@echo resources - Build the .prc file from the .rcp file
	@echo zipfile - Make a ZIP file of the source code and resources
	@echo tarball - Make a TAR file of the source code and resources
	@echo clean - Clean up temporary files

resources :
	$(PILRC) DieRoller.rcp	
	$(BUILDPRC) --output DieRollerRsrc.prc --type "rsrc" --creator "diE#" --name DieRoller --version-number 1.5.7 *.bin

dist : 
	make zipfile tarball zipfile-nosrc tarball-nosrc

zipfile-nosrc : 
	$(ZIP) -add DieRoller.zip DieRoller.prc Readme.txt

zipfile : 
	$(ZIP) -add DieRollerSrc.zip *.bmp *.rcp *.txt *.rcp *.prc Makefile
	
tarball :
	$(TAR) zcvf DieRollerSrc.tar *.bmp *.rcp *.txt *.rcp *.prc Makefile

tarball-nosrc :
	$(TAR) zcvf DieRoller.tar DieRoller.prc Readme.txt

clean : 
	$(RM)  -f *.bin *.res *.asm DieRoller*.tar DieRoller*.zip
