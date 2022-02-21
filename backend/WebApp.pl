use Mojolicious::Lite -signatures;
use Mojo::Asset::File;
use Data::Dumper;


# Retrieve example data from a separate file
require './Data.pl';
my $all_data = get_data();

# Serve the static HTML when the browser requests the root
get '/' => sub {
  my $c = shift;
  $c->res->headers->content_type('text/html; charset=UTF-8');
  $c->res->content->asset(Mojo::Asset::File->new(path => './public/index.html'));
  $c->rendered(200);
};

# Provide JSON data of all courses available
get '/api/courses' => sub {
  my $c = shift;
  $c->render(json => $all_data->{'courses'});
};

# Provide JSON data of the workflows available for a course
get '/api/courses/:course/workflows' => sub {
  my $c = shift;
  $c->render(json => $all_data->{'workflows'});
};

# Provide JSON data of the years available for a course/workflow combination
get '/api/courses/:course/workflows/:workflow/years' => sub {
  my $c = shift;
  $c->render(json => $all_data->{'years'});
};

# Provide a JSON object with all relevant data related to a form
get '/api/courses/:course/workflows/:workflow/years/:year/formdata' => sub {
  my $c = shift;
  my $course = $c->param('course');
  my $workflow = $c->param('workflow');
  my $year = $c->param('year');
  my $resp = {
	'data' => $all_data->{'data'}->{$course}->{$workflow}->{$year},
	'schema' => $all_data->{'specs'}->{$workflow}
  };
  $c->render(json => $resp);
};

# Receive an object with updated form data. Currently this is just printed.
post '/api/courses/:course/workflows/:workflow/years/:year/store' => sub {
  my $c = shift;
  my $course = $c->param('course');
  my $workflow = $c->param('workflow');
  my $year = $c->param('year');
  my $req_object = $c->req->json;
  say "Received data to store for course '$course', workflow '$workflow' and year '$year'";
  say Dumper $req_object;
  $all_data->{'data'}->{$course}->{$workflow}->{$year} = $req_object;
  $c->rendered(200);
};

# Start the web application
app->start;
