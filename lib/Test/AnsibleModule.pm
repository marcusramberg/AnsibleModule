package Test::AnsibleModule;

use Mojo::Base -base;
use Test::More;
use Mojo::JSON qw/decode_json encode_json/;
use Carp qw/croak/;

has 'last_response';
has 'success';

sub fail_ok {
  my $self = shift;
  my $rc   = $self->_exec_ok(@_);
  $self->_test('ok', $rc, 'Returned non-zero return code');
}

sub run_ok {
  my $self = shift;
  my $rc   = $self->_exec_ok(@_);
  $self->_test('ok', !$rc, 'Returned zero return code');
}

sub _exec_ok {
  my ($self, $module, $args) = @_;
  $args ||= {};
  my $p;
  my (@mapped_args) = map { $_ . '=' . $args->{$_} } keys %$args;

  open($p, "-|", join(" ", $module, @mapped_args))
    // croak "Could not run module: $!";
  my $response = "";

  while (my $line = <$p>) {
    $response .= $line;
  }
  my $res = decode_json($response);
  $self->last_response($res);
  close $p;
  return $? >> 8;
}

sub _test {
  my ($self, $name, @args) = @_;
  local $Test::Builder::Level = $Test::Builder::Level + 2;
  return $self->success(!!Test::More->can($name)->(@args));
}


1;

=head1 NAME

Test::AnsibleModule - Test your ansible modules.

=head1 SYNOPSIS

use Test::AnsibleModule;
my $t=Test::AnsibleModule->new();
$t->run_ok('modules/foobar');
is_deeploy($t->last_response,{ changed => 0 });

=head1 DESCRIPTION

Test an Ansible module by running it and passing it input as JSON, and decoding the response.

=head1 ATTRIBUTES

=head2 last_response

The deserialized response from the last module run.

=head1 METHODS

=head2 run_ok

Test that the job runs, and returns a 0 error code (succeeds).

=head failed_ok

Test that the jobs runs, and returns a non-zero error code (fails).

=cut
