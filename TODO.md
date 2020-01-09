# TODO

## Backend


* [ ]   Use the `$DESKTOP_SESSION` environment variable (or by grepping the output of gsettings) to determine if the user is using a desktop environment and which:
  This can then be used to determine whether we should use `feh`, `gsettings`, or whatever.


* [ ]  Either dig into `libxmp` (and other X libraries) to find out how to set the desktop background when there is no desktop environment or check `feh`'s source code for leads.
       (Feh uses imlib2)


* [ ]  Change the number of unique papers from 20 to a fraction of the total number of wallpapers, perhaps 1/2.


* [ ]  If the current image is *bigger* than the screen, it should be resized (to the exact same size as the screen) in `/tmp` before being applied as a background

* [ ]  Program should sort a user's wallpapers: copying all of them into /tmp and removing ones that are too small.
       Or it should merely check each image's size before setting it as the desktop background and add it to a list of blacklisted images if it isn't big enough.
       This list would be maintained in memory, though it would probably be more efficient to store it between runs.  Images would be stored to the list using a checksum, since file names can change.

  - [ ]  This should be configurable via command-line options:
         For example, users should be able to specify how small (px by px) an image can be before getting removed.  `-s`, `--size`
  - [ ]  Users should be able to specify any subfolders that the program should ignore during the sorting process.  `-i`, `--ignore`

## Frontend

* [ ]  -v should call `sys.exit` after printing the program version

* [ ]  Consider porting the CLI frontend to C


* [ ]  Finish writing option parser and actually plug it into the program so it does something


* [ ]  Create a GUI with a good selection of menu options for doing just about everything with the current desktop background


* [ ]  Create a taskbar icon

  - Some ideas: a scroll/piece of parchment with golden rays extending from it to indicate its perfection

## Build


* [ ]  Write a makefile (or setup auto(conf/make)) to enable quick and easy builds/installs
