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

  # Ignore messages that are not explicitly addressed to the user:
  return if ($message !~ /^$user[\s:,]/);

  # Get the server's tag:
  my $tag = $server->{tag};

  # Prepare the message body:
  (my $body = $message) =~ s/^$user[\s:,]\s*//;

  # Display the notification:
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

  # Display the notification:
  display_notification("$nick/$tag:", $message);
}

# Register configuration options:
Irssi::settings_add_bool('notifications', 'notifications_private_messages', 1);
Irssi::settings_add_bool('notifications', 'notifications_public_messages',  1);
Irssi::settings_add_bool('notifications', 'notifications_active_window', 0);

# Register signals:
Irssi::signal_add('message public',  'message_public');
Irssi::signal_add('message private', 'message_private');
