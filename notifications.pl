# notifications, an Irssi script to notify the user about incoming messages
# Copyright (C) 2012 Jaromir Hradilek

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
our $VERSION  = '0.9.1';
our %IRSSI    = (
  name        => 'notifications',
  description => 'Notify the user about incoming messages.',
  authors     => 'Jaromir Hradilek',
  contact     => 'jhradilek@gmail.com',
  url         => 'https://github.com/jhradilek/irssi-scripts',
  license     => 'GNU General Public License, version 3',
  changed     => '2012-09-13',
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

  # Get the name of the active window:
  my $window = Irssi::active_win()->{active}->{name} || '';

  # Ignore messages in the active window:
  return if ($window eq $target);

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

  # Get the name of the active window:
  my $window = Irssi::active_win()->{active}->{name} || '';

  # Ignore messages in the active window:
  return if ($window eq $nick);

  # Get the server's tag:
  my $tag = $server->{tag};

  # Display the notification:
  display_notification("$nick/$tag:", $message);
}

# Register signals:
Irssi::signal_add('message public',  'message_public');
Irssi::signal_add('message private', 'message_private');
