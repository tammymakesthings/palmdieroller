# DieRoller 1.5.7

_Copyright (c) 2000, 2020, Tammy Cravit <tammymakesthings@gmail.com>._
_All rights reserved._

Salvaged from Sourceforce and moved over to GitHub 2020-11-30.

## Code at 50,000 Feet

This document is intended to help new Quartus developers to learn from
my code. It gives a birds-eye view of the code and some of the
interesting functions in it, as well as highlighting some of the
mistakes I made in writing my first Quartus application.

### Code Structure

For manageability purposes, the code is divided into function-related
chunks which can be edited in the standard memo pad application. I use
pedit (see below) for source code editing, but I found that breaking
the code down into smaller pieces made debugging easier.

The modules of DieRoller, and their function groupings, are as
follows:

- DieRoller: Code loader (loads DieRoller150.7)
- DieRoller150.7: Constants, variables, loads the rest of the code
- DieRollerAlgo150.7: Functions related to generating die rolls
- DieRollerMain150.7: Event loop, app launching and termination, and related functions
- DieRollerPrefs150.7: Loading/saving of app preferences
- DieRollerRsrcs150.7: Resource ID definitions, loading of the resource DB
- DieRollerUI150.7: UI functions; most of the actual functionality happens here.

### DieRoller150.7

The constants `prefs-base` and `prefs-top`, which bracket some of the variable
declarations, are used when loading and saving the preferences. When saving
preferences, you need to know the size of the preference data. These constants
are used to figure out that size.

As Forth allocates variables, it increments the magic value HERE to indicate
the address of the next variable to be allocated. So, what Forth does during
those lines is as follows (for example):

    (before anything is done)               HERE=1000
    here constant prefs-base		        Puts 1000 in prefs-base, HERE=1000
    variable nsides				            Allocates nsides, HERE=1002
    variable ndice				            Allocates ndice, HERE=1004
    here prefs-base - constant prefs-size	Puts 4 in prefs-size, HERE=1004

### DieRollerAlgo150.7

`rolls?` is a word I wrote while I was debugging the ranom number generator. It
can be used to display the contents of the rolls array from the Forth console.

The `random-nsides` word came from Neal Bridges. I had been using something like
this instead:

```forth
: random-nsides rand nsides @ mod 1+ ;
```

but Neal pointed out that that method doesn't generate truly random
numbers. His method, which I don't really entirely understand (being not a
math geek) generates more random random numbers.

### DieRollerMain150.7

`handle-ctl-select` is the event handler for most of the functionality in the
program. It invokes different words depending on which UI control is
selected. The extra code for `AboutForm.OKButton` and `HelpForm.OKButton` 
restores the `ndice`/`nsides` settings when the main form is redisplayed.

`app-main` is the application's main word. However, when the application is
run, the `go` word is invoked instead, which in turn calls `app-main`. The
reason for this extra level of stuff is that go also has to watch for an
`appStopEvent` from the system, so that it can write the preferences back out.

### DieRollerPrefs150.7

The `>prefs` and `prefs>` words are good illustrations of how you save and load
application preferences. When I realized that, despite lots of discussion on
the Quartus message board, this process was actually pretty simple, there
seemed little reason not to include it.

The `app-init` word tries to load the preferences, and supplies default values
if no preferences record was found.

### DieRollerRsrcs150.7

This chunk of code basically defines the resource IDs for many of the GUI
controls (all the ones we want to manipulate from code), and loads the
resource database.

### DieRollerUI150.7

A lot of functionality is crammed in this module. Most of the actual work of
the program eventually ends up in this module and its words.

`num>label` is a helper word that converts a number to a string, and then calls
`SetLabel` to set the caption of a control to that string. I use it for updating
the selector boxes which hold the program's output, in the `update-roll-display`
word.

The `compute-sum` word simply sums the selected die values, and sets the caption
of the Sum box accordingly.

`find-nsides` determines which of the "# of sides" selectors is currently
selected. There's probably an easier way to do this, but I opted for what I
knew worked here. Similarly, `find-ndice` determines how many dice to roll. It's
a little cleaner, but since `find-nsides` has to work with discontinuous values,
I didn't see a way to use the looping approach there.

`zero-extras` sets all dice that are not needed for this roll (based on the # of
dice selected) to 0. I used the approach of always generating 8 die values,
and then zeroing out the ones I didn't need, because I thought it would be
easier to debug.

`mark-selected-dice` checks off all dice whose values are non-zero. The only
tricky (at least for me) thing here is that I put the `SetControlValue` stuff
outside of the if statement to avoid code duplication. It took a while before
it occurred to me that you could do that.

`do-roll` is what actually gets called when the Roll button is tapped. 

`handle-checkbox` is called when one of the roll checkboxes is selected. It
updates the sum accordingly.

### MakeDieRoller

This file contains the Makefile used to build the PRC. You can build the PRC
(if you have the registered version of Quartus) by giving this command:

```forth
needs MakeDieRoller
```

### Gotchas

A couple of gotchas I learned when coding this application:

1. Forth has one false value, but many true values. 

So,

```forth
myvar @ true = if
    do-something
then
```
and

```forth
myvar @ if
    do-something
then
```

are not quite the same thing. (Namely, the first doesn't always do what you
expect it to.

2. The stack is your friend. 

I can see places now where I could rewrite my code to use the stack better, 
and avoid some of the global variables.

### Tools Used

I'd like to thank the authors/makers of the following tools, which I used 
in developing DieRoller:

- *Palm, Inc.*: Makers of my Palm IIIc, and of the POSE Emulator
- *Handspring*: Makers of the Visor Deluxe I used before I got the IIIc
- *Landware, Inc.*: Makers of the GoType! keyboard I used when coding on my Palm.
- *Paul Nevai*: Author of the wonderful peditPro text editor for PalmOS
- *Neal Bridges*: For writing Quartus Forth, and for giving a lot of 
  support (technical and moral) to a Forth newcomer
- *Roger Lawrence*: Along with the other folks at IndiVideo.net, for the 
  Onboard RsrcEdit Resource Editor.

About half of this software was developed on a Windows 2000 PC with VIm and
Win32Forth. The rest was done on-device with pedit and Onboard
RsrcEdit. Testing was done on both my Palm IIIc and on POSE. The `BuildPRC`
utility, from `prc-tools`, was used to compile the resource file on the PC.
  
### 2020 Update Comments

A random email from someone who'd found this code inspired me to go rescue it
from Sourceforge and migrate it over here. It makes me a little sad how many
of the companies in the Tools Used section no longer exist. Nonetheless, I've
decided to preserve this code for historical value. Suffice it to say, I'm not 
updating it anymore, and pull requests will probably be ignored.

It is, however, fun to look back on this and see a bit of my own personal
evolution as a software developer reflected in how I approached this problem
20 years ago and how I might tackle it today. I'm tempted to rewrite this app
in Swift or something just as a learning exercise.

The PalmPilot really laid the groundwork for what the iOS and Android platforms
have become. Primitive though it was, it really created the Personal Digital
Assistant market (which evolved into today's smartphones) in a way that I don't
think the Apple Newton did. R.I.P., Palm.
