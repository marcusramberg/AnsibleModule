use Test::More;
use strict;
use warnings;

use_ok('Test::AnsibleModule');
my $t = Test::AnsibleModule->new;
$t->run_ok('t/ext/exit_json', {});
is_deeply(
  $t->last_response,
  {changed => 1, msg => "exit_json", failed => 0},
  'Response as expected'
);
done_testing;
