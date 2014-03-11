# irssi-notifications

## Description

The **notifications** script for Irssi uses desktop notifications to inform the user about incoming messages.

## Installation

**IMPORTANT:** A working installation of the **Gtk2::Notify** module for Perl is required for this script to function. In Fedora, this module is provided by the *perl-Gtk2-Notify* package; in Debian and Ubuntu, the package is named *libgtk2-notify-perl*.

Irssi looks for additional scrips in the in the **~/.irssi/scripts/** directory. To make sure that this directory exists, type the following at a shell prompt:

    install -d ~/.irssi/scripts/autorun/

To install the **notifications** script, change to the directory with your local copy of the repository and type:

    cp notifications.pl ~/.irssi/scripts/

This copies the **notifications.pl** file to the **~/.irssi/scripts/** directory. You can also configure Irssi to load the script automatically at startup. To do so, change to the **~/.irssi/scripts/autorun/** directory and create a symbolic link to the script by running the following command:

    ln -s ../notifications.pl

The script is loaded the next time you start the client.

## Usage

### Loading the Script

To load the **notifications** in Irssi, run the following Irssi command:

    /script load notifications

### Unloading the Script

To unload the **notifications** script from Irssi, run the following Irssi command:

    /script unload notifications

## Copyright

Copyright © 2012, 2014 Jaromir Hradilek

This program is free software; see the source for copying conditions. It is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
