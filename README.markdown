# Irssi Scripts

## Description

The **irssi-scripts** repository provides a collection of scripts for **Irssi**, an IRC client for the command line. In particular, it provides the following scripts:

* **notifications.pl** — A script to notify the user about incoming messages by using desktop notifications.

## Installation

### Installing an Irssi Script

To install any of the scripts that are available in this repository, change into the directory with your local copy of the repository and type the following at a shell prompt:

    cp <script>.pl ~/.irssi/scripts/

For example, to install **notifications.pl**, type:

    cp notifications.pl ~/.irssi/scripts/

This copies the selected file to the **~/.irssi/scripts/** directory, in which all Irssi scripts are placed. In addition, you can configure Irssi to automatically load the script at startup. To do so, change into the **~/.irssi/scripts/autorun/** directory and create a symbolic link to the script by typing the following at a shell prompt:

    ln -s ../<script>.pl

For instance, to tell Irssi to automatically load **notifications.pl**, type:

    ln -s ../notifications.pl

The script is loaded the next time you start the client.

### Uninstalling an Irssi Script

To uninstall an Irssi script, run the following command to remove it from the **~/.irssi/scripts/** directory:

    rm ~/.irssi/scripts/<script>.pl

For example, to uninstall **notifications.pl**, type:

    rm ~/.irssi/scripts/notifications.pl

In addition, if you previously configured Irssi to load the script automatically at startup, remove the respective symbolic link from the **~/.irssi/scripts/autorun/** directory by typing the following at a shell prompt:

    rm ~/.irssi/scripts/autorun/<script>.pl

For instance, to remove a symbolic link to the **notifications.pl** script, type:

    rm ~/.irssi/scripts/autorun/notifications.pl

## Usage

### Loading a Script in Irssi

To load a script in Irssi, use the following command:

    /script load <script>

For example, to load the **notifications.pl** script, type:

    /script load notifications

### Unloading a Script from Irssi

To unload a script from Irssi, use the following command:

    /script unload <script>

For example, to unload the **notifications.pl** script, type:

    /script unload notifications

## Copyright

Copyright © 2012 Jaromir Hradilek

This program is free software; see the source for copying conditions. It is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
