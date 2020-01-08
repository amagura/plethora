# TODO

## Backend

* Use the `$DESKTOP_SESSION` environment variable (or by grepping the output of gsettings) to determine if the user is using a desktop environment and which:
  This can then be used to determine whether we should use `feh`, `gsettings`, or whatever.

* Either dig into `libxmp` (and other X libraries) to find out how to set the desktop background when there is no desktop environment or check `feh`'s source code for leads.

* Change the number of unique papers from 20 to a fraction of the total number of wallpapers, perhaps 1/2.

* If the current image is *bigger* than the screen, it should be resized (to the exact same size as the screen) in `/tmp` before being applied as a background

## Frontend

* Consider porting the CLI frontend to C

* Finish writing option parser and actually plug it into the program so it does something

* Create a GUI with a good selection of menu options for doing just about everything with the current desktop background

* Create a taskbar icon

## Build

* Write a makefile (or setup auto(conf/make)) to enable quick and easy builds/installs
