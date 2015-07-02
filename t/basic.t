use Test::More;

use_ok('AnsibleModule');
my $m = AnsibleModule->new;
isa_ok $m, 'AnsibleModule';

done_testing;
