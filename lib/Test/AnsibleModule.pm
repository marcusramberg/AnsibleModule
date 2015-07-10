package Test::AnsibleModule;

use Mojo::Base -base;

has 'last_response';

our @EXPORT_OK = qw/run_ok/;

sub run_ok {
  my ($self, $module, @args) = @_;


}

1;
