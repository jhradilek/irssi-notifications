# notifications, an Irssi script to notify the user about incoming messages
# Copyright (C) 2012, 2013 Jaromir Hradilek

# This program is free software;  you can redistribute it  and/or modify it
# under the  terms of the  GNU General Public License  as published  by the
# Free Software Foundation; version 3 of the License.
#
# This  program is  distributed  in the  hope that  it will be useful,  but
# WITHOUT ANY WARRANTY;  without even the implied warranty of  MERCHANTABI-
# LITY  or  FITNESS FOR A PARTICULAR PURPOSE.  See  the  GNU General Public
# License for more details.
#
# You should have received a copy of the  GNU General Public License  along
# with this program. If not, see <http://www.gnu.org/licenses/>.

use strict;
use warnings;
use Encode;
use Gtk2::Notify -init, "Irssi";
use Irssi;

# The character encoding of the Irssi client:
use constant ENCODING => "UTF-8";

# General script information:
our $VERSION  = '0.9.2';
our %IRSSI    = (
  name        => 'notifications',
  description => 'Notify the user about incoming messages.',
  authors     => 'Jaromir Hradilek',
  contact     => 'jhradilek@gmail.com',
  url         => 'https://github.com/jhradilek/irssi-scripts',
  license     => 'GNU General Public License, version 3',
  changed     => '2013-02-08',
);

# Display a GTK notification:
sub display_notification {
  my ($summary, $body) = @_;

  # Convert the strings to Perl's internal representation:
  $summary = decode(ENCODING, $summary);
  $body = decode(ENCODING, $body);

  # Display the notification:
  Gtk2::Notify->new($summary, $body, "im-message-new")->show();
}

# Handle incoming public messages:
sub message_public {
  my ($server, $message, $nick, $address, $target) = @_;

  # Check whether to notify the user about public messages:
  return unless (Irssi::settings_get_bool('notifications_public_messages'));

  # Check whether to notify the user about messages in the active window:
  unless (Irssi::settings_get_bool('notifications_active_window')) {
    # Get the name of the active window:
    my $window = Irssi::active_win()->{active}->{name} || '';

    # Ignore messages in the active window:
    return if ($window eq $target);
  }

  # Get the user's nick name:
  my $user = $server->{nick};

  # Check whether to notify the user about indirect messages:
  unless (Irssi::settings_get_bool('notifications_indirect_messages')) {
    # Ignore messages that are not explicitly addressed to the user:
    return if ($message !~ /^$user[\s:,]/);
  }
  else {
    # Ignore messages that do not mention the user:
    return if ($message !~ /\b$user\b/);
  }

  # Get the server's tag:
  my $tag = $server->{tag};

  # Prepare the message body:
  (my $body = $message) =~ s/^$user[\s:,]\s*//;

  # Notify the user about the incoming public message:
  display_notification("$nick/$tag on $target:", $body);
}

# Handle incoming private messages:
sub message_private {
  my ($server, $message, $nick, $address) = @_;

  # Check whether to notify the user about public messages:
  return unless (Irssi::settings_get_bool('notifications_public_messages'));

  # Check whether to notify the user about messages in the active window:
  unless (Irssi::settings_get_bool('notifications_active_window')) {
    # Get the name of the active window:
    my $window = Irssi::active_win()->{active}->{name} || '';

    # Ignore messages in the active window:
    return if ($window eq $nick);
  }

  # Get the server's tag:
  my $tag = $server->{tag};

  # Notify the user about the incoming private message:
  display_notification("$nick/$tag:", $message);
}

# Handle incoming DCC requests:
sub dcc_request {
  my ($dcc, $sendaddr) = @_;

  # Check whether to notify the user about DCC requests:
  return unless (Irssi::settings_get_bool('notifications_dcc_messages'));

  # Check whether to notify the user about messages in the active window:
  unless (Irssi::settings_get_bool('notifications_active_window')) {
    # Get the name of the active window:
    my $window = Irssi::active_win()->{active}->{name} || '';

    # Ignore messages in the active window:
    return unless ($window);
  }

  # Get the request type:
  my $type = $dcc->{type};

  # Get the sender's nick:
  my $nick = $dcc->{nick};

  # Get the server's tag:
  my $tag  = $dcc->{server}->{tag};

  # Check the request type:
  if ($type eq 'GET') {
    # Get the file name and size:
    my $name = $dcc->{arg};
    my $size = $dcc->{size};

    # Notify the user about the incoming SEND request:
    display_notification("$nick/$tag offers a file:", "$name ($size B)");
  }
  elsif ($type eq 'CHAT') {
    # Notify the user about the incoming CHAT request:
    display_notification("$nick/$tag offers a DCC chat.", "");
  }
}

# Register configuration options:
Irssi::settings_add_bool('notifications', 'notifications_private_messages', 1);
Irssi::settings_add_bool('notifications', 'notifications_public_messages',  1);
Irssi::settings_add_bool('notifications', 'notifications_indirect_messages',0);
Irssi::settings_add_bool('notifications', 'notifications_active_window', 0);
Irssi::settings_add_bool('notifications', 'notifications_dcc_messages',  1);

# Register signals:
Irssi::signal_add('message public',  'message_public');
Irssi::signal_add('message private', 'message_private');
Irssi::signal_add('dcc request',     'dcc_request');
