package MyProject::Module;
use strict;
use warnings;

use LWP::UserAgent;      # For making HTTP requests
use HTTP::Request::Common qw(POST);  # To create POST requests
use HTTP::Body;           # To parse HTTP responses

sub new {
    my ($class) = @_;
    return bless {}, $class;
}

# Method to send a POST request and parse the response
sub post_and_parse {
    my ($self, $url, $post_data) = @_;

    # Create a UserAgent
    my $ua = LWP::UserAgent->new;
    $ua->timeout(10);  # Set timeout in seconds

    # Create a POST request
    my $request = POST($url, Content => $post_data);

    # Send the request
    my $response = $ua->request($request);

    # Check if the request was successful
    unless ($response->is_success) {
        die "HTTP POST failed: " . $response->status_line;
    }

    # Initialize HTTP::Body with the response content
    my $headers = $response->headers;
    my $body_content = $response->decoded_content;
    my $body = HTTP::Body->new($headers->content_type, length($body_content));
    $body->add($body_content);

    # Retrieve the parsed content
    my $parsed_content = $body->param;

    return $parsed_content;  # Return parsed content as a hashref or scalar
}

1;
