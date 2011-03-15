## IGSuite 4.0.1
## Procedure: DBStructure.pm
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

package IG::DBStructure;

use strict;

use vars qw( %db_tables_index %db_tables %db_views @ISA @EXPORT);

use vars qw ($VERSION);
$VERSION = '4.0.1';

require Exporter;
@ISA    = qw( Exporter );
@EXPORT = qw( %db_tables_index %db_tables %db_views);

## Database tables property
%db_tables_index = (
	archive			=> { fields           => 11,
                                     unique_id_field  => 'id',
	                             def_report_order => 'id',
	                             report_left_join => 'contacts',
	                             indexes          => 'id;issue' },

	letters			=> { fields           => 9,
                                     unique_id_field  => 'id',
                                     def_report_order => 'id',
	                             report_left_join => 'contacts',
	                             indexes          => 'id;issue'},
	                             
	offers			=> { fields           => 16,
                                     unique_id_field  => 'id',
                                     def_report_order => 'id',
	                             report_left_join => 'contacts',
	                             indexes          => 'id;issue'},

	orders			=> { fields           => 10,
                                     unique_id_field  => 'id',
                                     def_report_order => 'id',
	                             report_left_join => 'contacts',
	                             indexes          => 'id;issue'},

	fax_sent		=> { fields           => 10,
                                     unique_id_field  => 'id',
                                     def_report_order => 'id',
	                             report_left_join => 'contacts',
	                             indexes          => 'id;issue'},

	fax_received		=> { fields           => 10,
                                     unique_id_field  => 'id',
                                     def_report_order => 'id',
	                             report_left_join => 'contacts',
	                             indexes          => 'id;issue'},

	nc_ext			=> { fields           => 9,
                                     unique_id_field  => 'id',
                                     def_report_order => 'id',
	                             report_left_join => 'contacts',
	                             indexes          => 'id'},

	nc_int			=> { fields           => 9,
                                     unique_id_field  => 'id',
                                     def_report_order => 'id',
	                             report_left_join => 'contacts',
	                             indexes          => 'id'},
	                             
	pages			=> { fields           => 17,
	                             indexes          => 'id;name'},

	contracts		=> { fields           => 17,
                                     unique_id_field  => 'id',
                                     def_report_order => 'id',
	                             report_left_join => 'contacts;contracts_phases',
	                             indexes          => 'id;issue;phase'},

	contracts_phases	=> { fields           => 14,
	                             indexes          => 'id'},

	email_msgs		=> { fields           => 18,
	                             indexes          => 'id;owner,folder;originalid',
	                             oldname          => 'email'},

	email_filter		=> { fields           => 8,
	                             indexes          => ''},

	email_msgtags		=> { fields           => 2,
	                             indexes          => 'msgid',
	                             oldname          => 'email_tags'},

	email_imports		=> { fields           => 9,
	                             indexes          => ''},

	isms			=> { fields           => 7,
	                             indexes          => ''},

	contacts		=> { fields           => 64,
                                     unique_id_field  => 'contactid',
                                     def_report_order => 'contactid',
	                             indexes          => 'contactid;contactname;nospace;master;email'},

	contacts_group		=> { fields           => 2,
	                             indexes          => ''},

	postit			=> { fields           => 10,
	                             indexes          => ''},

	prices			=> { fields           => 16,
	                             indexes          => ''},

	articles		=> { fields           => 1,
	                             indexes          => ''},

	documentation		=> { fields           => 9,
	                             indexes          => ''},

	services		=> { fields           => 18,
	                             indexes          => 'id;opendate,enddate'},

	services_stats		=> { fields           => 4,
	                             indexes          => ''},

	services_notes		=> { fields           => 7,
	                             indexes          => ''},
	                             
	users			=> { fields           => 50,
                                     unique_id_field  => 'userid',
                                     def_report_order => 'name',
	                             report_left_join => '',
	                             indexes          => 'login'},

	users_groups		=> { fields           => 3,
	                             indexes          => 'groupid'},

	users_groups_link	=> { fields           => 2,
	                             indexes          => 'groupid;userid'},

	users_privileges	=> { fields           => 4,
	                             indexes          => 'resource_id;who'},

	equipments		=> { fields           => 33,
                                     unique_id_field  => 'id',
                                     def_report_order => 'description',
	                             report_left_join => 'contacts',
	                             indexes          => ''},

        equipments_maintenance  => { fields           => 2,
                                     indexes          => ''},

	calendar		=> { fields           => 23,
				     indexes          => 'eventid;parent'},

	todo			=> { fields           => 16,
	                             unique_id_field  => 'todoid',
	                             def_report_order => 'todoid',
	                             report_left_join => 'contacts',
	                             indexes          => ''},

	basic_tables		=> { fields           => 3,
	                             indexes          => ''},

	polls			=> { fields           => 46,
	                             indexes          => ''},

	opportunities		=> { fields           => 13,
                                     unique_id_field  => 'id',
                                     def_report_order => 'id',
	                             report_left_join => 'contacts',
	                             indexes          => ''},

        comments                => { fields           => 10,
                                     indexes          => 'referenceproc,referenceid'},

	system_log		=> { fields           => 8,
	                             indexes          => 'targettable;targetid;level'},

	last_elements_log	=> { fields           => 5,
	                             indexes          => ''},

	sessions_cache		=> { fields           => 4,
	                             indexes          => 'formid'},

	signatures		=> { fields           => 3,
	                             indexes          => 'id'},

	reports			=> { fields           => 9,
	                             indexes          => ''},

        chats_msgs		=> { fields           => 3,
                                     indexes          => ''},

        chats_users		=> { fields           => 8,
                                     indexes          => ''},

	binders			=> { fields           => 7,
                                     unique_id_field  => 'id',
                                     def_report_order => 'id',
	                             report_left_join => 'contacts',
	                             indexes          => 'id'},

	bindeddocs		=> { fields           => 3,
	                             indexes          => 'binderid'},

	form_defs		=> { fields           => 10,
	                             indexes          => ''},

	form_records		=> { fields           => 2,
	                             indexes          => ''}, 

        bookings                => { fields           => 5,
                                     indexes          => 'bookingid;eventid;equipmentid'},
	);

#XXX2DEVELOPE constraint=>'not null' in all table columns

%db_tables = (

signatures=>[
	{ name=>'id',
	  type=>'varchar(15)',},

	{ name=>'issue',
	  type=>'date',},

	{ name=>'md5key',
	  type=>'varchar(32)',},

	{ name=>'owner',
	  type=>'varchar(32)',},
	     ],
chats_msgs=>[
	{ name=>'issuetime',
	  type=>'int',},

	{ name=>'nick',
	  type=>'varchar(20)',},

	{ name=>'message',
	  type=>'text',},

	{ name=>'room',
	  type=>'varchar(100)',},
	     ],
chats_users=>[
	{ name=>'username',
	  type=>'varchar(32)',},

	{ name=>'userhost',
	  type=>'varchar(200)',},

	{ name=>'sessionstart',
	  type=>'int',},

	{ name=>'lastmsg',
	  type=>'int',},

	{ name=>'room',
	  type=>'varchar(100)',},

	{ name=>'nick',
	  type=>'varchar(20)',},

	{ name=>'sessionid',
	  type=>'varchar(20)',},

	{ name=>'status',
	  type=>'int',},

	{ name=>'topic',
	  type=>'varchar(200)',},
	     ],
form_defs=>[
	{ name=>'igformid',
	  type=>'varchar(20)',},

	{ name=>'fieldid',
	  type=>'varchar(20)',},

	{ name=>'fieldtype',
	  type=>'varchar(30)',},

	{ name=>'fieldlabel',
	  type=>'varchar(100)',},

	{ name=>'description',
	  type=>'text',},

	{ name=>'position',
	  type=>'int',},

	{ name=>'defaultvalues',
	  type=>'text',},

	{ name=>'status',
	  type=>'int',},

	{ name=>'fieldstyle',
	  type=>'text',},

	{ name=>'labelstyle',
	  type=>'text',},

	{ name=>'fieldfloat',
	  type=>'varchar(10)',},
	     ],
form_records=>[
	{ name=>'recordid',
	  type=>'varchar(50)',},

	{ name=>'fieldid',
	  type=>'varchar(20)',},

	{ name=>'value',
	  type=>'text',},
	     ],
binders=>[
	{ name=>'id',
	  type=>'varchar(15)',},

	{ name=>'owner',
	  label=>'owner',
	  itype=>'logins',
	  type=>'varchar(32)',},

	{ name=>'issue',
	  label=>'issue',
	  itype=>'date',
	  type=>'date',},

	{ name=>'name',
	  label=>'binder_name',
	  itype=>'text',
	  type=>'varchar(200)',},

	{ name=>'note',
	  label=>'note',
	  itype=>'text',
	  type=>'text',},

	{ name=>'category',
	  label=>'category',
	  itype=>'select',
	  type=>'varchar(200)',},

	{ name=>'contactname',
	  label=>'contact_name',
	  itype=>'text',
	  type=>'varchar(70)',},

	{ name=>'contactid',
	  type=>'varchar(15)',},
	     ],
bindeddocs=>[
	{ name=>'id',
	  type=>'varchar(15)',},

	{ name=>'binderid',
	  type=>'varchar(15)',},

	{ name=>'docid',
	  type=>'varchar(15)',},

	{ name=>'docissue',
	  type=>'date',},
	     ],
sessions_cache=>[
	{ name=>'sessionid',
	  type=>'varchar(65)',},

	{ name=>'formid',
	  type=>'varchar(15)',},

	{ name=>'keyname',
	  type=>'varchar(30)',},

	{ name=>'keyvalue',
	  type=>'text',},

	{ name=>'keydate',
	  type=>'date',},
	     ],
system_log=>[
	{ name=>'id',
	  type=>'varchar(15)',},

	{ name=>'level',
	  type=>'varchar(20)',},

	{ name=>'targettable',
	  type=>'varchar(20)',},

	{ name=>'targetid',
	  type=>'varchar(32)',},

	{ name=>'date',
	  type=>'date',},

	{ name=>'time',
	  type=>'varchar(8)',},

	{ name=>'authuser',
	  type=>'varchar(32)',},

	{ name=>'remotehost',
	  type=>'varchar(100)',},

	{ name=>'text',
	  type=>'text',},
	     ],
last_elements_log=>[
	{ name=>'id',
	  type=>'varchar(15)',},

	{ name=>'description',
	  type=>'text',},

	{ name=>'type',
	  type=>'varchar(20)',},

	{ name=>'owner',
	  type=>'varchar(32)',},

	{ name=>'issuedate',
	  type=>'date',},

	{ name=>'issuetime',
	  type=>'varchar(8)',},
	     ],
comments=>[
	{ name=>'id',
	  type=>'varchar(15)',},

	{ name=>'referenceid',
	  type=>'varchar(100)',},

	{ name=>'referenceproc',
	  type=>'varchar(15)',},

	{ name=>'date',
	  type=>'date',},

	{ name=>'time',
	  type=>'varchar(8)',},

	{ name=>'authorname',
	  type=>'varchar(70)',},

	{ name=>'authoremail',
	  type=>'varchar(100)',},

	{ name=>'authorurl',
	  type=>'varchar(100)',},

	{ name=>'comment',
	  type=>'text',},

	{ name=>'commentowner',
	  type=>'varchar(32)',},

        { name=>'notifyowner',
          type=>'varchar(1)',},
	     ],

opportunities=>[
	{ name=>'id',
	  type=>'varchar(15)',},

	{ name=>'name',
	  label=>'name',
	  itype=>'text',
	  type=>'text',},

	{ name=>'contactid',
	  type=>'varchar(15)',},

	{ name=>'type',
	  label=>'type',
	  itype=>'select',
	  legend=>[([1, $IG::lang{new_business}],
                    [2, $IG::lang{existing_business}])],
	  type=>'varchar(5)',},

	{ name=>'source',
	  label=>'opportunity_source',
	  itype=>'basictable',
	  table=>'opportunities_source',
	  type=>'varchar(5)',},

	{ name=>'description',
	  label=>'description',
	  itype=>'text',
	  type=>'text',},

	{ name=>'amount',
	  label=>'amount',
	  itype=>'currency',
	  type=>'int',},

	{ name=>'issue',
	  label=>'issue',
	  itype=>'date',
	  type=>'date',},

	{ name=>'enddate',
	  label=>'due_date',
	  itype=>'date',
	  type=>'date',},

	{ name=>'stage',
	  label=>'sales_stage',
	  itype=>'basictable',
	  table=>'opportunities_sales_stage',
	  type=>'varchar(5)',},

	{ name=>'probability',
	  label=>'probability',
	  itype=>'select',
	  type=>'varchar(5)',},

	{ name=>'owner',
	  label=>'owner',
	  itype=>'logins',
	  type=>'varchar(32)',},

	{ name=>'contactname',
	  label=>'contact_name',
	  itype=>'text',
	  type=>'varchar(70)',},

	{ name=>'status',
	  legend=>[( [1, $IG::lang{opportunity_open}],
                     [2, $IG::lang{opportunity_closed}],)],
          itype=>'select',
          label=>'status',
	  type=>'varchar(2)',},
	     ],

archive=>[
	{ name=>'id',
	  type=>'varchar(15)',},	#numero

	{ name=>'docref',
	  label=>'document_reference',
	  itype=>'text',
	  type=>'varchar(30)',},	#numrif

	{ name=>'issue',
	  label=>'issue',
	  itype=>'date',
	  type=>'date',},	#data

	{ name=>'contactname',
	  label=>'contact_name',
	  itype=>'text',
	  type=>'varchar(70)',},	#contact

	{ name=>'expire',
	  label=>'due_date',
	  itype=>'date',
	  type=>'date',},	     	#scadenza

	{ name=>'note',
	  label=>'note',
	  itype=>'text',
	  type=>'text',},		#note

	{ name=>'owner',
	  label=>'owner',
	  itype=>'logins',
	  type=>'varchar(32)',},#owner

	{ name=>'type',
	  label=>'document_type',
	  itype=>'documenttype',
	  type=>'varchar(5)',},		#tipo

	{ name=>'days',
	  type=>'int',},		#giorni

	{ name=>'contactid',
	  type=>'varchar(15)',},	#unidest

	{ name=>'docdate',
	  label=>'document_date',
	  itype=>'date',
	  type=>'date',},

	{ name=>'npa',
	  label=>'archive_position',
	  itype=>'text',
	  type=>'varchar(50)',},
	],

letters=>[
	{ name=>'id',
	  type=>'varchar(15)',},	#numero

	{ name=>'issue',
	  label=>'issue',
	  itype=>'date',
	  type=>'date',},		#data

	{ name=>'contactname',
	  label=>'contact_name',
	  itype=>'text',
	  type=>'varchar(70)',},	#contact

	{ name=>'owner',
	  label=>'owner',
	  itype=>'logins',
	  type=>'varchar(32)',},		#owner

	{ name=>'note',
	  label=>'note',
	  itype=>'text',
	  type=>'text',},		#note

	{ name=>'sharemode',
	  type=>'int',},		#sharemode

	{ name=>'free',
	  type=>'varchar(15)',},	#utente

	{ name=>'contactid',
	  type=>'varchar(15)',},	#unidest

	{ name=>'npa',
	  label=>'archive_position',
	  itype=>'text',
	  type=>'varchar(50)',},

	{ name=>'docref',
	  label=>'document_reference',
	  itype=>'text',
	  type=>'varchar(30)',},
	],

offers=>[
	{ name=>'id',
	  type=>'varchar(15)',},	#numero

	{ name=>'issue',
	  label=>'issue',
	  itype=>'date',
	  type=>'date',},		#data

	{ name=>'contactname',
	  label=>'contact_name',
	  itype=>'text',
	  type=>'varchar(70)',},	#contact

	{ name=>'note',
	  label=>'result',
	  itype=>'text',
	  type=>'text',},		#note

	{ name=>'owner',
	  label=>'owner',
	  itype=>'logins',
	  type=>'varchar(32)',},		#owner

	{ name=>'expire',
	  label=>'due_date',
	  itype=>'date',
	  type=>'date',},		#scadenza

	{ name=>'category',
	  itype=>'select',
	  label=>'category',
	  type=>'varchar(2)',},		#categoria

	{ name=>'days',
	  type=>'int',},	        #giorni

	{ name=>'flag',
	  type=>'varchar(2)',},		#flag

	{ name=>'pricesupdate',
	  type=>'date',},		#revisionep

	{ name=>'note1',
	  label=>'note',
	  itype=>'text',
	  type=>'text',},		#note1

	{ name=>'flag1',
	  type=>'varchar(1)',},		#flag1

	{ name=>'flag2',
	  type=>'varchar(1)',},		#flag2

	{ name=>'flag3',
	  type=>'varchar(1)',},		#flag3

	{ name=>'contactid',
	  type=>'varchar(15)',},	#unidest

	{ name=>'npa',
	  label=>'archive_position',
	  itype=>'text',
	  type=>'varchar(50)',},

	{ name=>'amount',
	  label=>'amount',
	  itype=>'currency',
	  type=>'int',},
	],

orders=>[
	{ name=>'id',
	  type=>'varchar(15)',},	#numero

	{ name=>'issue',
	  label=>'issue',
	  itype=>'date',
	  type=>'date',},		#data

	{ name=>'docref',
	  label=>'document_reference',
	  itype=>'text',
	  type=>'varchar(30)',},	#ordine

	{ name=>'contactname',
	  label=>'contact_name',
	  itype=>'text',
	  type=>'varchar(70)',},	#contact

	{ name=>'note',
	  label=>'note',
	  itype=>'text',
	  type=>'text',},		#note

	{ name=>'owner',
	  label=>'owner',
	  itype=>'text',
	  type=>'varchar(32)',},		#owner

	{ name=>'expire',
	  label=>'due_date',
	  itype=>'date',
	  type=>'date',},		#scadenza

	{ name=>'flag',	
	  type=>'varchar(2)',},		#flag

	{ name=>'duedate',
	  label=>'delivery',
	  itype=>'date',
	  type=>'date',},		#consegna

	{ name=>'contactid',
	  type=>'varchar(15)',},	#unidest

	{ name=>'npa',
	  label=>'archive_position',
	  itype=>'text',
	  type=>'varchar(50)',},
	],

fax_sent=> [
	{ name=>'id',
	  type=>'varchar(15)',},	# numero

	{ name=>'issue',
	  label=>'issue',
	  itype=>'date',
	  type=>'date',},        	# data

	{ name=>'contactname',
	  label=>'contact_name',
	  itype=>'text',
	  type=>'varchar(70)',}, 	# contact

	{ name=>'owner',
	  label=>'owner',
	  itype=>'logins',
	  type=>'varchar(32)',},		# owner

	{ name=>'note',
	  label=>'note',
	  itype=>'text',
	  type=>'text',},        	# note

	{ name=>'faxnumber',
	  label=>'fax_number',
	  itype=>'text',
	  type=>'varchar(20)',}, 	# tel

	{ name=>'contactid',
	  type=>'varchar(15)',}, 	# unidest

	{ name=>'category',
	  label=>'document_type',
	  itype=>'documenttype',
	  type=>'varchar(5)',},  	# doctype

	{ name=>'timeissue',
	  label=>'invoice_time',
	  type=>'text',
	  type=>'varchar(8)',},  	#

	{ name=>'npa',
	  label=>'archive_position',
	  itype=>'text',
	  type=>'varchar(50)',},

	{ name=>'docref',
	  label=>'document_reference',
	  itype=>'text',
	  type=>'varchar(30)',},
	],

fax_received=>[
	{ name=>'id',
	  type=>'varchar(15)',},	# numero

	{ name=>'issue',
	  label=>'issue',
	  itype=>'date',
	  type=>'date',},		# data

	{ name=>'timeissue',
	  label=>'arrive_time',
	  ityme=>'text',
	  type=>'varchar(8)',},		# ora

	{ name=>'category',
	  label=>'document_type',
	  itype=>'documenttype',
	  type=>'varchar(5)',},		# tipo

	{ name=>'faxnumber',
	  label=>'fax_number',
	  itype=>'text',
	  type=>'varchar(20)',},	# telefono

	{ name=>'note',
	  label=>'note',
	  itype=>'text',
	  type=>'text',},		# note

	{ name=>'contactname',
	  label=>'contact_name',
	  itype=>'text',
	  type=>'varchar(70)',},	# contact

	{ name=>'owner',
	  label=>'owner',
	  itype=>'logins',
	  type=>'varchar(32)',},		# owner

	{ name=>'contactid',
	  type=>'varchar(15)',},	# unidest

	{ name=>'npa',
	  label=>'archive_position',
	  itype=>'text',
	  type=>'varchar(50)',},

	{ name=>'docref',
	  label=>'document_reference',
	  itype=>'text',
	  type=>'varchar(30)',},
	],

nc_ext=> [
	{ name=>'id',
	  type=>'varchar(15)',},	#numero

	{ name=>'issue',
	  label=>'issue',
	  itype=>'date',
	  type=>'date',},		#data

	{ name=>'contactname',
	  label=>'contact_name',
	  itype=>'text',
	  type=>'varchar(70)',},	#contact

	{ name=>'owner',
	  label=>'owner',
	  itype=>'logins',
	  type=>'varchar(32)',},		#owner

	{ name=>'note',
	  label=>'note',
	  itype=>'text',
	  type=>'text',},		#note

	{ name=>'priority',
	  type=>'varchar(3)',},		#priorita

	{ name=>'contactid',
	  type=>'varchar(15)',},	#unidest

	{ name=>'duedate',
	  label=>'due_date',
	  itype=>'date',
	  type=>'date',},		#chiusura

	{ name=>'npa',
	  label=>'archive_position',
	  itype=>'text',
	  type=>'varchar(50)',},

	{ name=>'docref',
	  label=>'document_reference',
	  itype=>'text',
	  type=>'varchar(30)',},
	],
nc_int=> [
	{ name=>'id',
	  type=>'varchar(15)',},	#numero

	{ name=>'issue',
	  label=>'issue',
	  itype=>'date',
	  type=>'date',},		#data

	{ name=>'contactname',
	  label=>'contact_name',
	  itype=>'text',
	  type=>'varchar(70)',},	#contact

	{ name=>'owner',
	  label=>'owner',
	  itype=>'logins',
	  type=>'varchar(32)',},		#owner

	{ name=>'note',
	  label=>'note',
	  itype=>'text',
	  type=>'text',},		#note

	{ name=>'priority',
	  type=>'varchar(3)',},		#priorita

	{ name=>'contactid',
	  type=>'varchar(15)',},	#unidest

	{ name=>'duedate',
	  label=>'due_date',
	  itype=>'date',
	  type=>'date',},		#chiusura

	{ name=>'npa',
	  label=>'archive_position',
	  itype=>'text',
	  type=>'varchar(50)',},

	{ name=>'docref',
	  label=>'document_reference',
	  itype=>'text',
	  type=>'varchar(30)',},
	],

pages=>[
	{ name=>'id',
	  type=>'varchar(15)',},

	{ name=>'name',
	  type=>'varchar(50)',},

	{ name=>'title',
	  type=>'varchar(200)',},

	{ name=>'category',
	  type=>'varchar(50)',},

	{ name=>'owner',
	  type=>'varchar(32)',},

	{ name=>'date',
	  type=>'date',},

	{ name=>'expire',
	  type=>'date',},

	{ name=>'lastedit',
	  type=>'date',},

	{ name=>'lasteditor',
	  type=>'varchar(32)',},

	{ name=>'showperm',
	  type=>'varchar(1)',},

	{ name=>'editperm',
	  type=>'varchar(1)',},

	{ name=>'status',
	  type=>'varchar(1)',},

	{ name=>'revision',
	  type=>'int',},

	{ name=>'text',
	  type=>'text',},

	{ name=>'approvedby',
	  type=>'varchar(32)',},

	{ name=>'template',
	  type=>'varchar(50)',},

	{ name=>'cryptstatus',
	  type=>'varchar(1)',},

	{ name=>'searchkeys',
	  type=>'text',},
	],

contracts=>[
	{ name=>'id',
	  type=>'varchar(15)',},

	{ name=>'issue',
	  label=>'issue',
	  itype=>'date',
	  type=>'date',},

	{ name=>'contactname',
	  label=>'contact_name',
	  itype=>'text',
	  type=>'varchar(70)',},	# contact

	{ name=>'owner',
	  label=>'owner',
	  itype=>'logins',
	  type=>'varchar(32)',},

	{ name=>'note',
	  label=>'note',
	  itype=>'text',
	  type=>'text',},

	{ name=>'expire',
	  label=>'due_date',
	  itype=>'date',
	  type=>'date',},		# duedate

	{ name=>'startdate',
	  label=>'start_from',
	  itype=>'date',
	  type=>'date',},

	{ name=>'phase',
	  type=>'varchar(15)',},

	{ name=>'type',
	  label=>'contract_type',
	  itype=>'basictable',
	  table=>'contracts_type',
	  type=>'int',},

	{ name=>'docref',
	  label=>'document_reference',
	  itype=>'text',
	  type=>'varchar(30)',},	# refnum

	{ name=>'duration',
	  type=>'int',},

	{ name=>'flag1',
	  type=>'varchar(1)',},

	{ name=>'flag2',
	  type=>'varchar(1)',},

	{ name=>'flag3',
	  type=>'varchar(1)',},

	{ name=>'contactid',
	  type=>'varchar(15)',},

	{ name=>'dayalert',             # NOT USED!
	  type=>'int',},

	{ name=>'npa',
	  label=>'archive_position',
	  itype=>'text',
	  type=>'varchar(50)',},

	{ name=>'amount',
	  label=>'amount',
	  itype=>'currency',
	  type=>'int',},
	],

contracts_phases=>[
	{ name=>'id',
	  type=>'varchar(15)',},

	{ name=>'contracttype',
	  type=>'int',},

	{ name=>'name',
	  itype=>'select',
          label=>'phase_name',
	  type=>'varchar(100)',},

	{ name=>'owner',
	  type=>'varchar(32)',},

	{ name=>'note',
	  type=>'text',},

	{ name=>'priority',
	  type=>'int',},

	{ name=>'bgcolor',
	  type=>'varchar(10)',},

	{ name=>'days',
	  type=>'int',},

	{ name=>'whenapply',
	  type=>'varchar(1)',},

	{ name=>'contractfield',
	  type=>'varchar(15)',},

	{ name=>'action1',
	  type=>'varchar(2)',},

	{ name=>'action1val',
	  type=>'varchar(15)',},

	{ name=>'action2',
	  type=>'varchar(2)',},

	{ name=>'contractstatus',
	  label=>'contract_status',
	  itype=>'select',
	  legend=>[( [0, $IG::lang{inactive_contract}],
                     [1, $IG::lang{active_contract}],
                     [2, $IG::lang{in_revision_contract}] )],
	  type=>'int',},

	{ name=>'owner1',
	  type=>'varchar(32)',},
	],
contacts_group=>[
	{ name=>'type',
	  type=>'varchar(15)',}, 	#tipo

	{ name=>'groupid',
	  type=>'varchar(15)',},	#cntgruppo

	{ name=>'contactid',
	  type=>'varchar(15)',},	#cntnumero
	],
reports=>[
	{ name=>'id',
	  type=>'varchar(15)',},

	{ name=>'owner',
	  type=>'varchar(32)',},

	{ name=>'name',
	  type=>'varchar(100)',},

	{ name=>'dbquery',
	  type=>'text',},

	{ name=>'dbcols',
	  type=>'text',},

	{ name=>'cgiquery',
	  type=>'text',},

	{ name=>'type',
	  type=>'varchar(30)',},

	{ name=>'orderby',
	  type=>'varchar(30)',},

	{ name=>'orderdirection',
	  type=>'varchar(4)',},

	{ name=>'lastchange',
	  type=>'date',},
	],
contacts=>[
	{ name=>'contactname',
	  type=>'varchar(70)',
          itype=>'text',
	  label=>'contact_name'},	#nominativo

	{ name=>'address1',
	  label=>'operations_headquarters_address',
          itype=>'text',
	  type=>'varchar(60)',},	#indirizzo

	{ name=>'city1',
	  label=>'operations_headquarters_city',
          itype=>'text',
	  type=>'varchar(40)',},	#citta

	{ name=>'zip1',
	  label=>'operations_headquarters_zip_code',
          itype=>'text',
	  type=>'varchar(15)',},	#cap

	{ name=>'prov1',
	  label=>'operations_headquarters_province',
	  itype=>'select',
	  type=>'varchar(10)',},	#prov

	{ name=>'piva',
	  label=>'vat_number',
          itype=>'text',
	  type=>'varchar(20)',},	#piva

	{ name=>'taxidnumber',
          label=>'vat_code',
          itype=>'text',
	  type=>'varchar(20)',},	#cfisc

	{ name=>'cciaa',
	  type=>'varchar(20)',},	#cciaa

	{ name=>'jobtitle',
	  type=>'varchar(60)',},	#contatto1

	{ name=>'confidence',
	  type=>'varchar(60)',},	#contatto2

	{ name=>'tel4',
	  type=>'varchar(20)',},	#telcon1

	{ name=>'tel5',
	  type=>'varchar(20)',},	#telcon2

	{ name=>'tel1',
	  label=>'telephone_exchange',
          itype=>'text',
	  type=>'varchar(20)',},	#tel1

	{ name=>'tel2',
	  type=>'varchar(20)',},	#tel2

	{ name=>'tel3',
	  type=>'varchar(20)',},	#tel3

	{ name=>'fax',
	  label=>'fax_number',
          itype=>'text',
	  type=>'varchar(20)',},	#fax

	{ name=>'qualification',
	  type=>'varchar(20)',},	#affidabile

	{ name=>'category',
	  type=>'varchar(20)',},	#categoria

	{ name=>'data1',
	  type=>'date',},		#data1

	{ name=>'data2',
	  type=>'date',},		#data2

	{ name=>'note',
	  label=>'notes',
          itype=>'text',
	  type=>'text',},		#note

	{ name=>'contactid',
	  type=>'varchar(15)',},	#univoco

	{ name=>'pricelistflag',
	  type=>'varchar(2)',},		#prezzi

	{ name=>'pricelistupdate',
	  type=>'date',},		#revisionep

	{ name=>'free1',
	  type=>'varchar(5)',},		# Recuperato instant_msgs_type

	{ name=>'free2',
	  type=>'varchar(5)',},		#acquisto

	{ name=>'lastupdate',
	  label=>'last_change',
          itype=>'date',
	  type=>'date',},		#agg

	{ name=>'activity',
	  type=>'text',},		#prodotti

	{ name=>'vendorslistflag',
	  type=>'varchar(2)',},		#qualita

	{ name=>'owner',
	  label=>'owner',
	  itype=>'logins',
	  type=>'varchar(32)',},	#owner

	{ name=>'email',
	  label=>'email',
          itype=>'text',
	  type=>'varchar(100)',},	#email

	{ name=>'url',
	  label=>'url',
          itype=>'text',
	  type=>'varchar(100)',},	#url

	{ name=>'address2',
	  label=>'operating_center_address',
          itype=>'text',
	  type=>'varchar(50)',},	#indirizzo2

	{ name=>'city2',
	  label=>'operating_center_city',
          itype=>'text',
	  type=>'varchar(35)',},	#citta2

	{ name=>'zip2',
	  label=>'operating_center_zip_code',
          itype=>'text',
	  type=>'varchar(15)',},	#cap2

	{ name=>'prov2',
	  label=>'operating_center_province',
          itype=>'select',
	  type=>'varchar(10)',},	#prov2

	{ name=>'address3',
	  label=>'legal_situs_address',
          itype=>'text',
	  type=>'varchar(50)',},	#indirizzo3

	{ name=>'city3',
	  label=>'legal_situs_city',
          itype=>'text',
	  type=>'varchar(35)',},	#citta3

	{ name=>'zip3',
	  label=>'legal_situs_zip_code',
          itype=>'text',
	  type=>'varchar(15)',},	#cap3

	{ name=>'prov3',
	  label=>'legal_situs_province',
          itype=>'select',
	  type=>'varchar(10)',},	#prov3

	{ name=>'note1',
	  type=>'text',},		#note1

	{ name=>'qualifmethod',
 	  type=>'varchar(2)',},		#metodo

	{ name=>'contactvalue',
	  itype=>'basictable',
	  table=>'contactvalue',
	  label=>'class',
	  type=>'int',},		#qualifica

	{ name=>'passwd',
	  type=>'varchar(72)',},	#passwd

	{ name=>'nospace',
 	  type=>'varchar(70)',},	#nospace

	{ name=>'free3',
	  type=>'varchar(60)',},	#contatto3 Recuperato personal_doc

	{ name=>'free4',
	  type=>'varchar(20)',},	#telcon3 Recuperato instant_msgs_value

	{ name=>'master',
	  type=>'varchar(15)',},	#master

	{ name=>'lastfaxowner',
	  type=>'varchar(32)',},		#lastfaxowner

	{ name=>'rea',
	  label=>'rea',
	  itype=>'text',
	  type=>'varchar(20)',},	#rea

	{ name=>'istat',
	  type=>'varchar(20)',},	#istat

	{ name=>'economicsector',
	  itype=>'basictable',
	  table=>'economicsector',
	  label=>'economic_sector',
	  type=>'varchar(100)',},	#attivita

	{ name=>'employees',
	  label=>'employees',
          itype=>'text',
	  type=>'int',},		#addetti

	{ name=>'billing',
	  itype=>'basictable',
	  table=>'billing',
	  label=>'billing',
	  type=>'int',},		#fatturato

	{ name=>'employername',
	  label=>'company_owner',
	  itype=>'text',
	  type=>'varchar(60)',}, 	#rappresentante

	{ name=>'sharemode',
	  type=>'int',},		#sharemode

	{ name=>'contactsource',
	  itype=>'basictable',
	  table=>'contactsource',
	  label=>'contact_origin',
	  type=>'int',},		#origine

	{ name=>'birthdate',
	  type=>'date',},		#nascita

	{ name=>'outfromlist',
	  type=>'int',},		#outfromlist

	{ name=>'contacttype',
	  label=>'contact_type',
          itype=>'contacttype',
	  type=>'int',},		#tipo

	{ name=>'economiczone',
          itype=>'basictable',
	  table=>'economiczone',
	  label=>'zone',
	  type=>'int',},		#zona

	{ name=>'country1',
	  label=>'operations_headquarters_country',
          itype=>'select',
	  type=>'varchar(2)',},		#country

	{ name=>'country2',
	  label=>'operating_center_country',
          itype=>'select',
	  type=>'varchar(2)',},		#country2

	{ name=>'country3',
	  label=>'legal_situs_country',
          itype=>'select',
	  type=>'varchar(2)',},		#country3

	{ name=>'operativefunction',
	  type=>'int',},
	],
isms=>[
	{ name=>'id',
	  type=>'varchar(15)',}, 	#univoco

	{ name=>'date',
	  type=>'date',},        	#data

	{ name=>'sender',
	  type=>'varchar(32)',},		#mittente

	{ name=>'receiver',
	  type=>'varchar(32)',},  	#destinatario

	{ name=>'body',
	  type=>'text',},		#testo

	{ name=>'status',
	  type=>'varchar(2)',},		#esito

	{ name=>'time',
	  type=>'varchar(5)',},		#ora

	{ name=>'type',
	  type=>'varchar(2)',},		#tipo
	],
email_msgs=>[
	{ name=>'id',
	  type=>'varchar(200)',}, 	#univoco # era 32char

 	{ name=>'issue',
	  type=>'date',},        	#data

	{ name=>'timeissue',
	  type=>'varchar(20)',}, 	#time

	{ name=>'sender',
	  type=>'varchar(250)',},	#sender

	{ name=>'contactid',
	  type=>'varchar(15)',}, 	#unidest

	{ name=>'receiver',
	  type=>'text',},        	#receiver

	{ name=>'owner',
	  type=>'varchar(32)',},  	#owner

	{ name=>'subject',
	  type=>'text',},        	#subject

	{ name=>'folder',
	  type=>'varchar(200)',},	#folder

	{ name=>'content',
	  type=>'varchar(250)',},	#content

	{ name=>'status',
	  type=>'varchar(10)',}, 	#status

	{ name=>'size',
	  type=>'int',},         	#size

	{ name=>'sharemode',
	  type=>'int',},         	#sharemode

	{ name=>'category',
	  type=>'varchar(5)',},  	#category

	{ name=>'body',
	  type=>'text',},        	#body

	{ name=>'pid',
	  type=>'varchar(15)',}, 	#

	{ name=>'originalid',
	  type=>'varchar(250)',},	#

	{ name=>'idsreferences',
	  type=>'text',},        	#

	{ name=>'threadid',
	  type=>'varchar(100)',},	#
	],
email_filter=>[
	{ name=>'id',
	  type=>'varchar(15)',}, #univoco

	{ name=>'owner',
	  type=>'varchar(32)',}, #owner
	  
	{ name=>'name',
	  type=>'varchar(100)',},#name

	{ name=>'query',
	  type=>'text',},        #query

	{ name=>'form',
	  type=>'text',},        #form

	{ name=>'when_apply',
	  type=>'int',},         #when_apply

	{ name=>'action',
	  type=>'text',},        #

	{ name=>'replymsg',
	  type=>'text',},        #

	{ name=>'priority',
	  type=>'int',
	  queries=> [( "update email_filter set priority=50")] },            # apply order
	],

email_imports=>[
	{ name=>'id',		type=>'varchar(32)',},
	{ name=>'owner',	type=>'varchar(32)',},
	{ name=>'host',   	type=>'varchar(200)',},
	{ name=>'port',		type=>'varchar(10)',},
	{ name=>'login',	type=>'varchar(200)',},
	{ name=>'password',	type=>'varchar(72)',},
	{ name=>'authmode',	type=>'varchar(50)',},
	{ name=>'usessl',	type=>'varchar(2)',},
	{ name=>'keepmsgs',	type=>'varchar(2)',},	
	{ name=>'autodownload',	type=>'varchar(1)',
                 queries=> [( "update email_imports set autodownload='n'")] },
	],
email_msgtags=>[
	{ name=>'id',		type=>'varchar(32)',},
	{ name=>'msgid',	type=>'varchar(200)',},
	{ name=>'name',		type=>'varchar(100)',},
	],
postit=>[
	{ name=>'link',		type=>'text',},
	{ name=>'title',	type=>'text',},
	{ name=>'type',		type=>'varchar(50)',},
	{ name=>'owner',	type=>'varchar(32)',},
	{ name=>'id',		type=>'varchar(15)',},
	{ name=>'target',	type=>'varchar(10)',},
	{ name=>'category',	type=>'varchar(100)',},
	{ name=>'sharemode',	type=>'varchar(1)',},
	{ name=>'description',	type=>'text',},
	{ name=>'rating',	type=>'int',},
	{ name=>'visibility',   type=>'int',
	  queries => [( "update postit set visibility=2 ".
	                "where category='' and sharemode='0'" )] },
	],
prices=>[
	{ name=>'id',		type=>'varchar(15)',},
	{ name=>'description',	type=>'text',},
	{ name=>'price',	type=>'varchar(20)',},
	{ name=>'fromdate',	type=>'date',},
	{ name=>'todate',	type=>'date',},
	{ name=>'articleid',	type=>'varchar(15)',},
	{ name=>'rebate',	type=>'varchar(20)',},
	{ name=>'contactid',	type=>'varchar(15)',},
	{ name=>'docid',	type=>'varchar(10)',},
	{ name=>'docnotes', 	type=>'text',},
	{ name=>'measureunit',	type=>'varchar(20)',},
	{ name=>'note',		type=>'text',},
	{ name=>'minquantity',	type=>'varchar(20)',},
	{ name=>'maxquantity',	type=>'varchar(20)',},
	{ name=>'deliverymode',	type=>'varchar(5)',},
	{ name=>'deliverytime',	type=>'varchar(5)',},
	{ name=>'packing',	type=>'varchar(5)',},
	],
articles=>[
	{ name=>'id',		type=>'varchar(15)',},
	{ name=>'shortdescription',type=>'text',},
	],

users=>[
	{ name=>'name',
	  type=>'varchar(70)',
	  label=>'name',
	  itype=>'text' },	# nominativo
	  
	{ name=>'userid',
	  type=>'varchar(15)',},  # matricola

	{ name=>'hierarchycode',
	  label=>'emplacement',
	  itype=>'text',
	  type=>'varchar(10)',},	# codice 

	{ name=>'address',
	  label=>'address',
	  itype=>'text',
	  type=>'varchar(50)',},	# indirizzo

	{ name=>'city',
	  label=>'city',
	  itype=>'text',
	  type=>'varchar(30)',},	# citta

	{ name=>'zip',
	  label=>'zip_code',
	  itype=>'text',
	  type=>'varchar(15)',},	# cap

	{ name=>'prov',
	  label=>'province',
	  itype=>'text',
	  type=>'varchar(10)',},	# prov

	{ name=>'taxid',
	  label=>'tax_id_number',
	  itype=>'text',
	  type=>'varchar(20)',},	# codfisc

	{ name=>'company',
	  itype=>'select',
	  label=>'company',
	  type=>'varchar(70)',},	# societa

	{ name=>'hierarchyref',
	  label=>'referring',
	  itype=>'select',
	  type=>'varchar(10)',},	# referente

	{ name=>'level',
	  label=>'level',
	  itype=>'text',
	  type=>'varchar(5)',},	# livello

	{ name=>'assumption',
	  label=>'employment_date',
	  itype=>'date',
	  type=>'date',},		# dataass

	{ name=>'contracttype',
	  label=>'contract_type',
	  itype=>'text',
	  type=>'varchar(100)',},	# tipocontr

	{ name=>'function',
	  label=>'function',
	  itype=>'select',
	  type=>'varchar(100)',},	# funzione

	{ name=>'jobtitles',
	  label=>'qualifications',
	  itype=>'text',
	  type=>'text',},		# titoli

	{ name=>'jobexperiences',
	  label=>'job_experience',
	  itype=>'text',
	  type=>'text',},	# esperienze

	{ name=>'jobphone',
	  label=>'extension',
	  itype=>'text',
	  type=>'varchar(25)',},	# interno

	{ name=>'doc1id',
	  label=>'personal_document',
	  itype=>'text',
	  type=>'varchar(20)',},	# cartaid

	{ name=>'doc1expire',
	  type=>'date',},		# scadcart

	{ name=>'doc2id',
	  label=>'drive_licence',
	  itype=>'text',
	  type=>'varchar(20)',},	# patente

	{ name=>'doc2type',
	  type=>'varchar(20)',},	# tipopat

	{ name=>'doc2expire',
	  type=>'date',},		# scadpat

	{ name=>'birthday',
	  label=>'birth_date',
	  itype=>'date',
	  type=>'date',},		# nascita

	{ name=>'personalphone',
	  label=>'phone_number',
	  itype=>'text',
	  type=>'varchar(25)',},	# telefono

	{ name=>'mobilephone',
	  label=>'mobile_phone',
	  itype=>'text',
	  type=>'varchar(25)',},	# cellulare

	{ name=>'signature',
	  label=>'email_signature',
	  itype=>'text',
	  type=>'text',},		# note

	{ name=>'status',
	  label =>'status',
	  itype=>'select',
	  legend=>[( [ 3, $IG::lang{all_users}],
	             [ 1, $IG::lang{all_active_users}],
                     [ 2, $IG::lang{all_inactive_users}] )],
	  type=>'varchar(30)',},	# stato

	{ name=>'statusdate',
	  type=>'date',},		# finoal

	{ name=>'fuelcardid',
	  label=> 'fuel_card',
	  itype=>'text',
	  type=>'varchar(10)',},	# carburante

	{ name=>'login',
	  label=>'login',
	  itype=>'text',
	  type=>'varchar(32)',},	# login

	{ name=>'passwd',
	  label=>'password',
	  itype=>'text',
	  type=>'varchar(72)',},	# passwd 

	{ name=>'initial',
	  type=>'varchar(5)',},	# iniziali

	{ name=>'acronym',
	  type=>'varchar(10)',},	# sigla

	{ name=>'igprivileges',
	  type=>'varchar(200)',},	# permessi

	{ name=>'email',
	  label=>'email',
	  itype=>'text',
	  type=>'varchar(100)',},	# email

	{ name=>'doc3id',
          label=>'special_drive_licence',
          itype=>'text',
	  type=>'varchar(20)',},	# patente2

	{ name=>'doc3type',
          type=>'varchar(10)',},	# tipopat2

	{ name=>'doc3expire',
	  type=>'date',},		# scadpat2

	{ name=>'pop3login',
	  type=>'varchar(100)',},	# host

	{ name=>'pop3pwd',
	  type=>'varchar(72)',},	# tipohost

	{ name=>'healthopinion',
	  label=>'health_opinion',
	  itype=>'select',
	  type=>'text',},		# giudiziomedico

	{ name=>'lasthealthck',
	  label=>'last_sanitary_inspection',
	  itype =>'date',
	  type=>'date',},		# ultimavisita

	{ name=>'healthckfreq',
	  type=>'int',},		# intervallovisita

	{ name=>'jobformation',
	  type=>'text',},		# formazione

	{ name=>'isosyncpwd',
	  type=>'varchar(72)',},	# isosyncpwd

	{ name=>'lastsync',
	  type=>'date',},		# lastsync

	{ name=>'lastpwdchange',
	  type=>'date',},# 

	{ name=>'note',
	  label=>'note',
	  itype=>'text',
	  type=>'text',},#

	{ name=>'dismissal',
	  label=>'dismissal',
	  itype=>'date',
	  type=>'date',},#

	{ name=>'emailfrom',
	  type=>'text',},#

	{ name=>'hostsallow',
	  type=>'text',},#
	],

users_groups=>[
	{ name=>'groupid',	type=>'varchar(15)',},
	{ name=>'name',		type=>'varchar(50)',},
	{ name=>'description',	type=>'text',},
	{ name=>'igprivileges',	type=>'varchar(200)',},
	],
users_groups_link=>[
	{ name=>'uid',		type=>'varchar(15)',},
	{ name=>'userid',	type=>'varchar(32)',},
	{ name=>'groupid',	type=>'varchar(15)',},
	],
users_privileges=>[
	{ name=>'resource_id',	type=>'varchar(250)',},
	{ name=>'resource_proc',type=>'varchar(20)',},
	{ name=>'who',		type=>'varchar(32)',},
	{ name=>'owner',	type=>'varchar(32)',},
	{ name=>'privilege_type',type=>'varchar(5)',},
	],
basic_tables=>[
	{ name=>'id',		type=>'int',},         #univoco 
	{ name=>'tablename',	type=>'varchar(50)',}, #tablename
	{ name=>'tablevalue',	type=>'varchar(200)',},#tablevalue
	{ name=>'status',	type=>'int',},         #status
	],
polls=>[
	{ name=>'id',		type=>'varchar(15)',},#univoco
	{ name=>'owner',	type=>'varchar(32)',}, #owner
	{ name=>'issue',	type=>'date',},       #data
	{ name=>'expire',	type=>'date',},       #expire
	{ name=>'question',	type=>'text',},       #question
	{ name=>'voters',	type=>'text',},       #voters
	{ name=>'a1',		type=>'varchar(250)',},
	{ name=>'a2',		type=>'varchar(250)',},
	{ name=>'a3',		type=>'varchar(250)',},
	{ name=>'a4',		type=>'varchar(250)',},
	{ name=>'a5',		type=>'varchar(250)',},
	{ name=>'a6',		type=>'varchar(250)',},
	{ name=>'a7',		type=>'varchar(250)',},
	{ name=>'a8',		type=>'varchar(250)',},
	{ name=>'a9',		type=>'varchar(250)',},
	{ name=>'a10',		type=>'varchar(250)',},
	{ name=>'a11',		type=>'varchar(250)',},
	{ name=>'a12',		type=>'varchar(250)',},
	{ name=>'a13',		type=>'varchar(250)',},
	{ name=>'a14',		type=>'varchar(250)',},
	{ name=>'a15',		type=>'varchar(250)',},
	{ name=>'a16',		type=>'varchar(250)',},
	{ name=>'a17',		type=>'varchar(250)',},
	{ name=>'a18',		type=>'varchar(250)',},
	{ name=>'a19',		type=>'varchar(250)',},
	{ name=>'a20',		type=>'varchar(250)',},
	{ name=>'n1',		type=>'int',},
	{ name=>'n2',		type=>'int',},
	{ name=>'n3',		type=>'int',},
	{ name=>'n4',		type=>'int',},
	{ name=>'n5',		type=>'int',},
	{ name=>'n6',		type=>'int',},
	{ name=>'n7',		type=>'int',},
	{ name=>'n8',		type=>'int',},
	{ name=>'n9',		type=>'int',},
	{ name=>'n10',		type=>'int',},
	{ name=>'n11',		type=>'int',},
	{ name=>'n12',		type=>'int',},
	{ name=>'n13',		type=>'int',},
	{ name=>'n14',		type=>'int',},
	{ name=>'n15',		type=>'int',},
	{ name=>'n16',		type=>'int',},
	{ name=>'n17',		type=>'int',},
	{ name=>'n18',		type=>'int',},
	{ name=>'n19',		type=>'int',},
	{ name=>'n20',		type=>'int',},
	{ name=>'groupid',	type=>'varchar(15)',},
	],
calendar=>[
	{ name=>'fromuser',
	  type=>'varchar(32)',},	# mittente

	{ name=>'touser',
	  type=>'varchar(32)',},	# destinatario

	{ name=>'day',
          type=>'int',},	# g

	{ name=>'month',
	  type=>'int',},	# m

	{ name=>'year',
	  type=>'int',},	# a

	{ name=>'weekday',
	  type=>'int',},	# giorno

	{ name=>'reserved',
	  type=>'int',},	# riserv

	{ name=>'starttime',
	  type=>'int',},	# ora

	{ name=>'endtime',
	  type=>'int',},	# ora1

	{ name=>'eventtext',
	  type=>'text',},	# testo

	{ name=>'startdate',
	  type=>'date',},	# data

	{ name=>'eventid',
	  type=>'varchar(15)',},# univoco

	{ name=>'showbyisms',
	  type=>'int',},	# byposta

	{ name=>'location',
	  type=>'int',},	# luogo

	{ name=>'activepopup',
	  type=>'int',},	# popup

	{ name=>'contactid',
	  type=>'varchar(15)',},# unidest

	{ name=>'category',
	  type=>'int',},

	{ name=>'repeatend',
	  type=>'date',},

        { name=>'notes',
          type=>'text',},

        { name=>'popupstatus',
          type=>'int' },

	{ name=>'eventtype',
	  type=>'int',
          queries=> [( "update calendar set eventtype=location",
		       "update calendar set location=0",
		       "update calendar set location=1 where eventtype=1",
		       "update calendar set eventtype=1 where eventtype=0",
		       "update calendar set eventtype=5 where starttime=2500"
                     )] },

        { name=>'parent',
          type=>'varchar(15)' },# id of parent event (for invitation)

        { name=>'confirmation', 
          type=>'int' },        # invitation: 0=to be confirmed, 1=confirmed, 2=rejected

        { name=>'invitation_note', # nota relativa all'invito
          type=>'text'},
	],

bookings=>[
	{ name=>'bookingid',	type=>'varchar(15)',}, # booking id (unique key)
	{ name=>'eventid',	type=>'varchar(15)',}, # calendar event id
	{ name=>'equipmentid',	type=>'varchar(15)',}, # booked equipment id
	{ name=>'approvedby',	type=>'varchar(32)',}, # user who has approved the booking
	{ name=>'note',	        type=>'text',},        # annotation about the booking
	{ name=>'claimed',      type=>'int',},         # time this booking is claimed from
	],

todo=>[
	{ name  => 'login',
	  itype => 'logins',
	  label => 'participant',
	  type  => 'varchar(32)',}, #login

	{ name  => 'todoid',
	  type  => 'varchar(15)',},#univoco

	{ name  => 'startdate',
	  itype => 'date',
	  label => 'start_from',
	  type  => 'date',},       #emissione

	{ name  => 'enddate',
	  itype => 'date',
	  label => 'solution',
	  type  => 'date',},       #risoluzione

	{ name  => 'status',
	  type  => 'int',},        #stato

	{ name  => 'todotext',
	  itype => 'text',
	  label => 'title',
	  type  => 'text',},       #testo

	{ name  => 'priority',
	  itype => 'select',
          legend=> [( [1, $IG::lang{smaller} ],
                      [2, $IG::lang{low}     ],
                      [3, $IG::lang{normal}  ],
                      [4, $IG::lang{high}    ],
                      [5, $IG::lang{highest} ] )],
	  label => 'priority',
	  type  => 'int',},        #priorita

	{ name  => 'owner',
	  itype => 'logins',
	  label => 'owner',
	  type  => 'varchar(32)',}, #owner

	{ name  => 'duedate',
	  itype => 'date',
	  label => 'due_date',
	  type  => 'date',},       #scadenza 

	{ name  => 'description',
	  itype => 'text',
	  label => 'description',
	  type  => 'text',},       #descrizione

	{ name  => 'sharemode',
	  itype => 'select',
          legend=> [( [0, $IG::lang{public}],
                      [1, $IG::lang{private}] )],
	  label => 'reserve',
	  type  => 'int',},        #riservatezza

	{ name  => 'master',
	  type  => 'varchar(15)',},#master

	{ name  => 'progress',
	  itype => 'select',
          legend=>[( ['0', $IG::lang{to_start}],
                     [10,  "10% $IG::lang{in_progress}"],
                     [20,  "20% $IG::lang{in_progress}"],
                     [30,  "30% $IG::lang{in_progress}"],
                     [40,  "40% $IG::lang{in_progress}"],
                     [50,  "50% $IG::lang{in_progress}"],
                     [60,  "60% $IG::lang{in_progress}"],
                     [70,  "70% $IG::lang{in_progress}"],
                     [80,  "80% $IG::lang{in_progress}"],
                     [90,  "90% $IG::lang{in_progress}"],
                     [100, "100% $IG::lang{completed}" ] )],
	  label => 'progress',
	  type  => 'int',},        #avanzamento

	{ name  => 'contactid',
	  type  => 'varchar(15)',},#unidest

	{ name  => 'category',
	  itype => 'basictable',
	  label => 'category',
	  table => 'todo_categpry',
	  type  => 'int',},

	{ name  => 'duration',
	  itype => 'text',
	  label => 'duration',
	  type  => 'varchar(15)',},

	{ name  => 'issue',
          queries=> [( "update todo set issue=startdate" )],
	  itype => 'date',
	  label => 'issue',
	  type  => 'date',},
	],
services=>[
	{ name=>'opendate',	type=>'date',},	      #datar
	{ name=>'humantime',	type=>'varchar(10)',},#ora
	{ name=>'enddate',	type=>'date',},       #datae
	{ name=>'equipment',	type=>'varchar(15)',},#mezzo
	{ name=>'servicetype',	type=>'varchar(5)',}, #servizio
	{ name=>'materials',	type=>'varchar(5)',}, #materiale
	{ name=>'priority',	type=>'varchar(5)',}, #priorita
	{ name=>'docref',	type=>'varchar(30)',},#numero
	{ name=>'weight',	type=>'int',},        #kg 
	{ name=>'volume',	type=>'int',},        #mc
	{ name=>'contactname',	type=>'varchar(70)',},#contact
	{ name=>'owner',	type=>'varchar(32)',}, #owner
	{ name=>'contactid',	type=>'varchar(15)',},#unidest
	{ name=>'note',		type=>'text',},       #note
	{ name=>'opentime',	type=>'varchar(15)',},#oraric 
	{ name=>'endtime',	type=>'varchar(15)',},#oraeff
	{ name=>'contactvalue',	type=>'int',},        #qualifica
	{ name=>'checks',	type=>'text',},       #controlli
	{ name=>'id',		type=>'varchar(15)',},#univoco
	],
services_stats=>[
	{ name=>'statdate',	type=>'date',},     #data
	{ name=>'totalservices',type=>'int',},      #vgtot
	{ name=>'maxservices',	type=>'int',},      #vgmax
	{ name=>'minservices',	type=>'int',},      #vgmin
	{ name=>'averageservices',type=>'int',},    #vgmedia
	],
services_notes=>[
	{ name=>'contactid',	type=>'varchar(15)',}, #numero
	{ name=>'opendate',	type=>'date',},        #data
	{ name=>'opentime',	type=>'varchar(8)',},  #ora
	{ name=>'category',	type=>'varchar(5)',},  #tipo
	{ name=>'owner',	type=>'varchar(32)',},  #owner
	{ name=>'opentext',	type=>'text',},        #testo
	{ name=>'id',		type=>'varchar(15)',}, #soluzione
	{ name=>'closedate',	type=>'date',},        #risolutore
	],
equipments=>[
	{ name=>'id',
	  type=>'varchar(15)',},         #numero

	{ name=>'description',
	  itype=>'text',
	  label=>'description',
	  type=>'text',},                #descrizione
	  
	{ name=>'builtcertificate',
	  itype=>'text',
	  label=>'certificate',
	  type=>'varchar(50)',},         #certificato
	  
	{ name=>'brand',
	  itype=>'text',
	  label=>'plate',
	  type=>'varchar(50)',},         #marca
	  
	{ name=>'location',
	  itype=>'text',
	  label=>'department',
	  type=>'varchar(200)',},        #locazione
	  
	{ name=>'type',
	  itype=>'basictable',
	  label=>'type',
	  table=>'equipments_type',
	  type=>'varchar(5)',},          #tipo
	  
	{ name=>'mntncinterval',
	  itype=>'select',
	  label=>'maintenance_range',
	  type=>'varchar(5)',},          #giorni
	  
	{ name=>'date0',
	  itype=>'date',
	  label=>'next_general_revision',
	  type=>'date',},                #data
	  
	{ name=>'date1',
	  itype=>'date',
	  label=>'safety_certification_system',
	  type=>'date',},                #data1
	  
	{ name=>'date2',
	  itype=>'date',
	  label=>'property_tax',
	  type=>'date',},                #data2
	  
	{ name=>'date3',
	  itype=>'date',
	  label=>'insurance',
	  type=>'date',},                #data3
	  
	{ name=>'mntnchoures',
	  itype=>'select',
	  label=>'time_needed',
	  type=>'varchar(3)',},          #ore
	  
	{ name=>'note',
	  itype=>'text',
	  label=>'notes',
	  type=>'text',},                #note
	  
	{ name=>'date4',
	  itype=>'date',
	  label=>'warranty',
	  type=>'date',},                #data4
	  
	{ name=>'manual',
	  type=>'varchar(15)',},         #manuale
	  
	{ name=>'taxescost',
	  itype=>'text',
	  label=>'taxes_cost',
	  type=>'varchar(15)',},         #prezzobo
	  
	{ name=>'assurancecost',
	  itype=>'text',
	  label=>'assurance_cost',
	  type=>'varchar(15)',},         #prezzoas
	  
	{ name=>'gasolconsumption',
	  itype=>'text',
	  label=>'fuel_consumption_cost',
	  type=>'varchar(15)',},         #kmlt
	  
	{ name=>'electrconsumption',
	  itype=>'text',
	  label =>'power_consumption_cost',
	  type=>'varchar(15)',},         #forzamotrice
	  
	{ name=>'maintenance',
	  itype=>'text',
	  label=>'annual_maintenance_cost',
	  type=>'varchar(15)',},         #manutenzione
	  
	{ name=>'staffcost',
	  itype=>'text',
	  label=>'operators_cost',
	  type=>'varchar(15)',},         #personale
	  
	{ name=>'date5',
	  itype=>'date',
	  label=>'register_date',
	  type=>'date',},                #data5
	  
	{ name=>'date6',
	  itype=>'date',
	  label=>'charter_party',
	  type=>'date',},                #data6
	  
	{ name=>'date7',
	  itype=>'date',
	  label=>'authorization_to_transport',
	  type=>'date',},                #data7
	  
	{ name=>'date8',
	  itype=>'date',
	  label=>'term_authorization',
	  type=>'date',},                #data8
	  
	{ name=>'services',
	  type=>'int',},
	  
	{ name=>'date9',
	  itype=>'date',
	  label=>'last_maintenance_date',
	  type=>'date',},
	  
	{ name=>'status',
	  type=>'int',
	  itype=>'select',
	  legend=>[([ 0, $IG::lang{available}      ],
                    [ 1, $IG::lang{alienate}       ],
                    [ 2, $IG::lang{out_of_service} ] )],
	  label=>'status',
	  queries=> [( "update equipments set status=0 ",

                       "update equipments set status=1 ".
		       "where mntncinterval='2'",

                       "update equipments set status=2 ".
		       "where mntncinterval='0'"
	             )] },
	  
	{ name=>'contactid',
	  type=>'varchar(15)',},

	{ name=>'mntn_interventions',
	  itype=>'text',
	  label=>'ordinary_mntn_services',
	  type=>'text',},                #note

	{ name=>'owner',
	  label=>'assigned_to',
	  itype=>'logins',
	  type=>'varchar(32)',},

	{ name=>'booking_group',
	  type=>'varchar(15)',},         # group whose users can book this equipment

	{ name=>'booking_admin_group',
	  type=>'varchar(15)',},         # group whose users can admin bookings

	{ name=>'booking_approve_group',
	  type=>'varchar(15)',},         # group whose users have to approve bookings
	],
equipments_maintenance=>[
	{ name=>'id',
	  type=>'varchar(20)',},

	{ name=>'equipment_id',
	  type=>'varchar(15)',},
	  
	{ name=>'maintenance_date',
	  type=>'date',},
	],
documentation=>[
	{ name=>'id',
	  type=>'varchar(15)',}, #numero
	{ name=>'description',
	  type=>'varchar(100)',},#descrizione
	{ name=>'function',
	  type=>'varchar(32)',}, #ente
	{ name=>'pages',
	  type=>'int',},         #pagine 
	{ name=>'issueid',
	  type=>'int',},         #emissione
	{ name=>'revisionid',
	  type=>'int',},         #revisione
	{ name=>'issue',
	  type=>'date',},        #data
	{ name=>'publishstatus',
	  type=>'varchar(5)',},  #pubblica
	{ name=>'approvalstatus',
	  type=>'varchar(5)',},  #stato
	{ name=>'managementsystem',
	  type=>'varchar(25)',},
	]
  );

%db_views = (); #( last_docs => "create view last_docs".
		#	   " (id, description, type, owner) ".
		#	   "as select targetid, text, targettable, authuser ".
		#	   "from system_log ".
		#	   "where level='view' ".
		#	   "order by date desc, time desc ".
		#	   "limit 1000" );

1;
