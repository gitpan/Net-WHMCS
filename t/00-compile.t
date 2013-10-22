use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::Compile 2.037

use Test::More {
    { $test_more_version || '' }
}
tests => {
    {
        my $count = @module_filenames + @script_filenames;
          $count += 1 if $fail_on_warning eq 'all';
          $count .= ' + ($ENV{AUTHOR_TESTING} ? 1 : 0)'
          if $fail_on_warning eq 'author';
          $count;
    }
};

{
    {
        $needs_display
          ? <<'CODE'
BEGIN {
    # Skip all tests if you need a display for this test and $ENV{DISPLAY} is not set
    if( not $ENV{DISPLAY} and not $^O eq 'MSWin32' ) {
        plan skip_all => 'Needs DISPLAY';
        exit 0;
    }
}
CODE
          : ''
    }
}

my @module_files = (
    {
        {
            join( ",\n",
                map { "    '" . $_ . "'" }
                map { s/'/\\'/g; $_ } sort @module_filenames )
        }
    }
);

{
    {
        @script_filenames
          ? 'my @scripts = (' . "\n"
          . join( ",\n",
            map { "    '" . $_ . "'" }
            map { s/'/\\'/g; $_ } sort @script_filenames )
          . "\n" . ');'
          : ''
    }
}

{
    {
        $fake_home
          ? <<'CODE'
# fake home for cpan-testers
use File::Temp;
local $ENV{HOME} = File::Temp::tempdir( CLEANUP => 1 );
CODE
          : '# no fake home requested';
    }
}

my $inc_switch = -d 'blib' ? '-Mblib' : '-Ilib';

use File::Spec;
use IPC::Open3;
use IO::Handle;

my @warnings;
for my $lib (@module_files) {

    # see L<perlfaq8/How can I capture STDERR from an external command?>
    open my $stdin, '<', File::Spec->devnull or die "can't open devnull: $!";
    my $stderr = IO::Handle->new;

    my $pid = open3( $stdin, '>&STDERR', $stderr, $^X, $inc_switch, '-e',
        "require q[$lib]" );
    binmode $stderr, ':crlf' if $^O eq 'MSWin32';
    my @_warnings = <$stderr>;
    waitpid( $pid, 0 );
    is( $?, 0, "$lib loaded ok" );

    if (@_warnings) {
        warn @_warnings;
        push @warnings, @_warnings;
    }
}

{
    {
        @script_filenames
          ? <<'CODE'
foreach my $file (@scripts)
{ SKIP: {
    open my $fh, '<', $file or warn("Unable to open $file: $!"), next;
    my $line = <$fh>;
    close $fh and skip("$file isn't perl", 1) unless $line =~ /^#!.*?\bperl\b\s*(.*)$/;

    my @flags = $1 ? split(/\s+/, $1) : ();

    open my $stdin, '<', File::Spec->devnull or die "can't open devnull: $!";
    my $stderr = IO::Handle->new;

    my $pid = open3($stdin, '>&STDERR', $stderr, $^X, $inc_switch, @flags, '-c', $file);
    binmode $stderr, ':crlf' if $^O eq 'MSWin32';
    my @_warnings = <$stderr>;
    waitpid($pid, 0);
    is($?, 0, "$file compiled ok");

   # in older perls, -c output is simply the file portion of the path being tested
    if (@_warnings = grep { !/\bsyntax OK$/ }
        grep { chomp; $_ ne (File::Spec->splitpath($file))[2] } @_warnings)
    {
        warn @_warnings;
        push @warnings, @_warnings;
    }
} }

CODE
          : '';
    }
}

{
    {
        (
            $fail_on_warning ne 'none'
            ? q{is(scalar(@warnings), 0, 'no warnings found')}
            : '# no warning checks'
          )
          . (
            $fail_on_warning eq 'author' ? ' if $ENV{AUTHOR_TESTING};'
            : ';'
          )
    }
}

{
    {
        $bail_out_on_fail
          ? 'BAIL_OUT("Compilation problems") if !Test::More->builder->is_passing;'
          : '';
    }
}
