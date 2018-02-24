# irssi-notifications

## Description

The **notifications** script for Irssi uses desktop notifications to inform the user about incoming messages.

## Installation

`notify-send` binary should be exists in your system.

Irssi looks for additional scrips in the in the **~/.irssi/scripts/** directory. To make sure that this directory exists, type the following at a shell prompt:

    install -d ~/.irssi/scripts/autorun/

To install the **notifications** script, change to the directory with your local copy of the repository and type:

    cp notifications.pl ~/.irssi/scripts/

This copies the **notifications.pl** file to the **~/.irssi/scripts/** directory. You can also configure Irssi to load the script automatically at startup. To do so, change to the **~/.irssi/scripts/autorun/** directory and create a symbolic link to the script by running the following command:

    ln -s ../notifications.pl

The script is loaded the next time you start the client.

## Usage

### Loading the Script

To load the **notifications** script in Irssi, run the following Irssi command:

    /script load notifications

### Unloading the Script

To unload the **notifications** script from Irssi, run the following Irssi command:

    /script unload notifications

### Filtering Notifications

The **notifications** script provides a number of boolean variables that allow you to enable or disable certain behavior. To change the value of any of these variables, run the following Irssi command:

    /set <variable_name> ON|OFF

The available variables are as follows:

<table>
  <tr>
    <th>Variable</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><code>notifications_private_messages</code></td>
    <td>Enables notifications for private messages. The default value is <code>ON</code>.</td>
  </tr>
  <tr>
    <td><code>notifications_public_messages<code></td>
    <td>Enables notifications for messages in an IRC channel. The default value is <code>ON</code>.</td>
  </tr>
  <tr>
    <td><code>notifications_indirect_messages</code></td>
    <td>Enables notifications for messages that mention the user only indirectly. The default value is <code>OFF</code>.</td>
  </tr>
  <tr>
    <td><code>notifications_active_window</code></td>
    <td>Enables notifications for messages in an active window. The default value is <code>OFF</code>.</td>
  </tr>
  <tr>
    <td><code>notifications_dcc_messages</code></td>
    <td>Enables notifications for incoming DCC messages and DCC CHAT messages. The default value is <code>ON</code>.</td>
  </tr>
</table>

## Copyright

Copyright © 2012, 2014 Jaromir Hradilek

This program is free software; see the source for copying conditions. It is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
