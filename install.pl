#!/usr/bin/perl
# Procedure: install.pl
# Last update: 16/03/2011
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
use strict;
use warnings;
use English qw( -no_match_vars );
use Config;
use vars qw(	%privileges	%timezones	%countries	$www_user
		%in		%on		%cookie		%set_cookie
		$S		$OS		@ISA		@EXPORT

		$crypt_key      $login_admin	%users		$auth_user
		$remote_host	$pwd_admin	$webpath	$img_url
		%htdocs_path	%menu_item	$user_dir	$htaccess_contacts

		$client_browser	$client_os	$tema		$link
		$screen_size	$page_results	$list_order	$date_format
		$timeoffset	$lang		$default_lang	%default_lang
		%attr		%languages	@task_list_content
		$cgi_path	$cgi_dir	$cgi_url	$logs_dir
		$conf_dir	$htdocs_dir	$temp_dir	$query_string
		$request_method $app_nspace	$task_list_cols	$task_list_rows
		$page_tabindex	$cgi_name	$cgi_ref	%lang
		$env_path	%docs_type	$demo_version   $debug

		%pop3_conf	%smtp_conf	$folderquota	$attlimit
		$homedirspoolname 		$homedirspools  $server_name
		$hashedmailspools               $mailspooldir	%ldap_conf
		$hosts_allow    $users_allow

		@row		@errmsg		%debug_info	%ext_app

		$def_wiki_show	$def_wiki_edit  %user_conf	%plugin_conf

		$soc_name	$soc_address	$soc_email	$soc_city
		$soc_zip	$soc_prov	$soc_tel	$soc_fax
		$soc_logo	$soc_country	$soc_site       $soc_contactid

		$db_name	$db_driver	$db_login	$db_password
		$db_host	$db_port	@db_fields_name	$db_fields_num

		$hylafax_host	$hylafax_port	$hylafax_login	$hylafax_pwd
		$hylafax_dir

		%executed	%tv		$session_timeout
		$thousands_separator            $decimal_separator
		$currency		        $prout_page

		$choice 	$perl		$install_mode   $db_driver_available
	   );

if (@ARGV) { # non-interactive
   automatic_configuration(shift);
   $install_mode = 'automatic';
}
else {   # interactive
   interactive_configuration();
   $install_mode = 'manual';
}

mk_install();

if (! @ARGV) { # interactive
   prompt("Press Enter to continue...\n");
   system("start http://localhost/$webpath") if $OS eq 'WINDOWS';
}

sub automatic_configuration {
   my $config_file = shift;

   ## load pre-set install configuration file ( we need $cgi_dir )
   do $config_file
      or die("ABORT: Can't load install configuration file '$config_file': $OS_ERROR\n");
   
   ## to proceed we need $cgi_dir
   die("ABORT: Can't find useable \$cgi_dir value! I need it! try to insert its ".
      "value manually inside your '$config_file' configuration file.\n"
     ) unless -d $cgi_dir && -r $cgi_dir;

   ## load previous config file ( from $cgi_dir )
   ## (we need a base configuration with all options)
   load_previous_config_file();

   ## load pre-set install configuration file again 
   ## ( overwrite previuos config )
   do $config_file
      or die("ABORT: Can't load install configuration file '$config_file': $OS_ERROR\n");
}

sub interactive_configuration {
   set_default_lang();
}

sub set_default_lang {
   $default_lang = prompt(sub {
      _clear_screen();

      print {*STDOUT} <<"END_OF_LANGUAGE_SELECTION";

(en)English
(es)Espanol
(fr)French
(it)Italian
(nl)Dutch
(pt)Portuguese

Set your IGSuite default language ? [$default_lang]: 
END_OF_LANGUAGE_SELECTION
   }, $default_lang, qr{^(it|en|es|fr|nl|pt)$});

  require "lang${S}$default_lang${S}default_lang";
  die( "ABORT: Can't open ${S}$default_lang${S}default_lang ".
       "language file. Is this an original IGSuite package?\n" ) if $@;
   return;
}

sub prompt {
   my ($message, $default, $checker) = @_;
   $message = sub { print {*STDOUT} $message } unless ref $message;
   $checker ||= qr{(?mxs:.?)}; # always matches by default
   while ('forever') {
      $message->();
      chomp(my $choice = <STDIN>);
      return $default if ($choice eq '') && defined($default);
      return $choice if $choice =~ m{$checker};
   }
}

