use utf8;
package FixMyStreet::DB::Result::UsersPmb;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->load_components("FilterColumn", "InflateColumn::DateTime", "EncodedColumn");
__PACKAGE__->table("users_pmb");
__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "twitter_id",
  { data_type => "bigint", is_nullable => 1 },
  "facebook_id",
  { data_type => "bigint", is_nullable => 1 },
  "ci",
  { data_type => "integer", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->belongs_to(
  "id",
  "FixMyStreet::DB::Result::User",
  { id => "id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2014-04-15 17:51:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:LkXBLzNeudc1T9N8IKTAng
# These lines were loaded from '/home/santiago/fixmystreet/datauy/perllib/FixMyStreet/DB/Result/UsersPmb.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package FixMyStreet::DB::Result::UsersPmb;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->load_components("FilterColumn", "InflateColumn::DateTime", "EncodedColumn");
__PACKAGE__->table("users_pmb");
__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "twitter_id",
  { data_type => "bigint", is_nullable => 1 },
  "facebook_id",
  { data_type => "bigint", is_nullable => 1 },
);
__PACKAGE__->belongs_to(
  "id",
  "FixMyStreet::DB::Result::User",
  { id => "id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2014-04-12 17:51:00
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:YPW/ju8FS+1V80lsOsQGRA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from '/home/santiago/fixmystreet/datauy/perllib/FixMyStreet/DB/Result/UsersPmb.pm' 


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
