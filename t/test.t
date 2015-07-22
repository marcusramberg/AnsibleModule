use Test::More;
use strict;
use warnings;

use_ok('Test::AnsibleModule');
my $t = Test::AnsibleModule->new;
$t->run_ok('t/ext/exit_json', {});
is_deeply(
  $t->last_response,
  {changed => 0, msg => "exit_json"},
  'Response as expected'
);
$t->fail_ok('t/ext/fail_json', {});
is_deeply(
  $t->last_response,
  {msg => "fail_json", failed => 1},
  'Response as expected'
);
done_testing;
