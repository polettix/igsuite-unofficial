## IGSuite 4.0.1
## Procedure: ProgressBar.pm
## Last update: 01/07/2010
#############################################################################
# IGSuite 4.0.1 - Provides an Office Suite by  simple web interface         #
# Copyright (C) 2002 Dante Ortolani  [LucaS]                                #
#                                                                           #
# This program is free software; you can redistribute it and/or             #
# modify it under the terms of the GNU General Public License               #
# as published by the Free Software Foundation; either version 2            #
# of the License, or (at your option) any later version.                    #
#                                                                           #
# This program is distributed in the hope that it will be useful,           #
# but WITHOUT ANY WARRANTY; without even the implied warranty of            #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             #
# GNU General Public License for more details.                              #
#                                                                           #
# You should have received a copy of the GNU General Public License         #
# along with this program; if not, write to the Free Software Foundation,   #
# Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.           #
#############################################################################

package IG::ProgressIndicator;

use strict;
use IG;

use vars qw( $VERSION );
$VERSION = '4.0.1';

#############################################################################
#############################################################################
sub new
 {
  my $type = shift;
  my %opt  = @_;
  my $self = {};

  $self->{pi_id}            = $opt{pi_id} || $on{pi_id} || MkId(15);
  $self->{update_frequency} = $opt{update_frequency}    || 2;
  $self->{title}            = $opt{title} || $on{title} || 'Progress Indicator';
  $self->{start_message}    = $opt{start_message};
  $self->{pi_file_basename} = $IG::temp_dir . $IG::S . "pi_$self->{pi_id}";

  return bless $self, $type;
 }

##############################################################################
##############################################################################

=head3 start()

Start a progress indicator

=cut

sub start
 {
  my $self = shift;
  my %opt  = @_;

  ## trick to avoid fork
  return 1 if $on{pi_id} || $IG::request_method eq 'commandline';

  $IG::clr{bg} = $IG::clr{bg_task};
  HtmlHead( title => $self->{title} );

  ## Start the hidden application
  my $iframe_src = $IG::cgi_name . "?pi_id=$self->{pi_id}" . $IG::query_string;
  PrOut "<iframe frameborder=\"0\" style=\"padding:0px; width:0; height:0;\"".
        " src=\"$iframe_src\" id=\"hidden_frame\" name=\"hf\"></iframe>\n";
  
  ## The Monitor Box
  $self->{start_message} = $opt{start_message} || "<h2>$self->{title}</h2>".
                                                  "<br>Loading...<br><br>";
  PrOut "<div id=\"progress_indicator_box_$self->{pi_id}\">\n".
        TaskMsg( $self->{start_message}, 4 ).
        "\n</div>\n";

  ## Javascript Updater Engine
  my $update_url = "igsuite?action=read_progress_indicator&amp;".
                           "pi_id=$self->{pi_id}&amp;".
                           "title=" . MkUrl( $self->{title} );

  my $stop_url   = "igsuite?action=stop_progress_indicator&amp;".
                           "pi_id=$self->{pi_id}&amp;".
                           "title=" . MkUrl( $self->{title} );

  IG::JsExec( code => <<END );

var ajax_in_progress = 0;
var alert_count = 0;

function connectionLost()
 {
  \$(progress_indicator_box_$self->{pi_id}).innerHTML = 'Server Connection Lost!';
  ajax_in_progress = 0;
 }

function ajaxUpdate()
 {
  if ( ajax_in_progress ) return false;
  ajax_in_progress = 1;

  new Ajax.Request('$update_url',
   {
    method:'get',
    onSuccess: function(transport)
     {
      ajax_in_progress = 0;
      var content = transport.responseText || "";
      
      if ( content.length > 0 )
       {
        alert_count = 0;
        \$(progress_indicator_box_$self->{pi_id}).innerHTML = content;
       }
      else
       {
        alert_count++;
        if ( alert_count == 2 ) pe.stop();
       }
     },
    onFailure: function()
     {
      connectionLost();
     },
    onException: function()
     {
      connectionLost();
     }
   });
  return true;
 }

function ajaxStop()
 {
  new Ajax.Request('$stop_url', { method:'get' } );
  return true;
 }

var pe = new PeriodicalExecuter( ajaxUpdate, $self->{update_frequency} );
END
  HtmlFoot();
  return 0;
 }

##############################################################################
##############################################################################

=head3 read()

Read progress indicator status

=cut

sub read
 {
  my $self = shift;
  my $html = '';

  if ( -e "$self->{pi_file_basename}.out" )
   {
    open( FH, '<', "$self->{pi_file_basename}.out" )
      or die("Can't open temporary file '$self->{pi_file_basename}.out'\n");
    $html .= $_ while <FH>;
    close(FH);
   }

  return $html;
 }

##############################################################################
##############################################################################

=head3 update()

Update progress indicator

=cut

sub update
 {
  my $self = shift;
  my %opt  = @_;

  return if !$opt{content};

  open( FH, '>', "$self->{pi_file_basename}.out" )
    or die("Can't write temporary file '$self->{pi_file_basename}.out'.\n");

  ## Renders Message
  print FH $opt{content}.Br(2);

  ## Renders Status Bar
  if ( $opt{status_bar} )
   {
    require IG::Utils;

    print FH HLayer( "<div style=\"width:40px\">$opt{status_bar}{perc} %</div>",
                     IG::StatusBar( width  => $opt{status_bar}{width}  || 150,
                                    height => $opt{status_bar}{height} || 20,
                                    color  => $opt{status_bar}{color}  || '#ff3300',
                                    perc   => $opt{status_bar}{perc}   || 1 ),
                     ( $opt{status_bar}{perc} == 100
                       ? ''
                       : Img( src   => "$IG::img_url/progress.gif",
                              width => 16 ) )
                  );
   }

  ## Render Buttons
  print FH ( $opt{button_close}
             ? Input( type      => 'button',
                      name      => 'close',
                      style     => 'margin-top:15px',
                      show      => $lang{close},
                      onclick   => 'self.close();' )
             : '' ).

           ( $opt{button_abort}
             ? Input( type      => 'button',
                      name      => 'abort',
                      style     => 'margin-top:15px',
                      show      => $lang{abort},
                      onclick   => 'ajaxStop();' )
             : '' ).

           ( $opt{button_continue}
             ? Input(    type      => 'button',
                         float     => 'right',
                         style     => 'margin-top:15px',
                         value     => $lang{continue},
                         onclick   => "setTimeout('self.close()',500);".
                                      "if (window.opener && !window.opener.closed) ".
                                      "{ window.opener.location='$opt{continue_url}'; }".
                                      "else ".
                                      "{ window.document.location='$opt{continue_url}'; }" )
             : '' );

  close(FH);
  return -e "$self->{pi_file_basename}.stop" ? 0 : 1;
 }

##############################################################################
##############################################################################

=head3 stop()

Stop progress indicator

=cut

sub stop
 {
  my $self = shift;
  my %opt  = @_;
     $opt{content} ||= 'Process Interrupted'; #XXX2TRANSLATE

  open( FH, '>', "$self->{pi_file_basename}.stop" )
    or die("Can't write temporary file '$self->{pi_file_basename}.stop'.\n");

  print FH $opt{content};
  close(FH);
 }

##############################################################################
##############################################################################

=head3 end()

End progress indicator

=cut

sub end
 {
  my $self = shift;
  my %opt  = @_;

  if ( -e "$self->{pi_file_basename}.stop" )
   {
    $opt{content} = '';
    open( FH, '<', "$self->{pi_file_basename}.stop" )
      or die("Can't read temporary file '$self->{pi_file_basename}.stop'.\n");
    $opt{content} .= $_ while <FH>;
    close(FH);
    $opt{content} ||= $opt{on_fails};
   }
  else
   {
    $opt{content} = $opt{on_success};
   }

  $self->update( %opt );

  ## To be sure that last update has finished
  sleep( $self->{update_frequency} + 3 );

  IG::FileUnlink( "$self->{pi_file_basename}.out" );
  IG::FileUnlink( "$self->{pi_file_basename}.in"  );
  IG::FileUnlink( "$self->{pi_file_basename}.stop" );

  ## We have to display something inside hidden iframe
  if ($IG::request_method eq 'commandline')
   {
    print STDOUT "$opt{content}\n"; #XXX2TEST
   }
  else
   {
    HtmlHead();
    HtmlFoot();
   }
 }

##############################################################################
############################################################################## 
1;