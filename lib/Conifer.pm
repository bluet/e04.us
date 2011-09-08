package Conifer;
use Mojo::Base 'Mojolicious';
use Data::Dumper;
use Mojo::ByteStream 'b';
use Image::Size;
use Redis;
#~ use Text::Xslate;
#~ use namespace::clean;

my %redis_server = (server => '127.0.0.1:6379');
my $secret = '';

__PACKAGE__->attr('redis');

__PACKAGE__->redis( Redis->new(%redis_server) );
print Dumper __PACKAGE__->redis;
#~ $self->redis( Redis->new(%redis_server) );
#~ print Dumper $self->redis;

# This method will run once at server start
sub startup {
	my $self = shift;
	
	
	
	#####
	# Routes
	#####
	
	# Documentation browser under "/perldoc" (this plugin requires Perl 5.10)
	#~ $self->plugin('PODRenderer');
	
	# use Xslate for page rendering
	#~ $self->plugin('xslate_renderer');
	
	$self->secret($secret);

	# Routes
	my $r = $self->routes;
	# $r->route('/:controller/:action/:id')->to('example#welcome', id => 1);
	
	$r->route('/')->to('page#index');
	$r->route('/index')->to('page#index');

	# Normal route to controller
	$r->route('/welcome')->to('example#welcome');
	
	# User related page
	my $r_user = $r->route('/user')->to('user#');
	$r->route('/login')->to('user#login');
	#~ $r_user->any('/login')->to('#login');
	$r_user->any('/logout')->to('#logout');
	$r_user->any('/register')->to('#register');
	
	#~ ladder sub {
		#~ my $user = $self->session('name');
		#~ if (not &check_user( $user )->{"login"}) {
			#~ $self->flash(message => 'Please login first!');
			#~ $self->redirect_to('login');
		#~ }
	#~ }
	
	$r->route('/user/(.user)/edit')->to('user#edit');
	$r->route('/user/(.user)')->to('user#info');
	
}

1;