unit module App::Crag:ver<0.0.38>:auth<zef:librasteve>;

use Slang::Roman;
use Slang::NumberBase;
use Physics::Measure :ALL;
use Physics::Vector;
use Physics::Constants;
use CodeUnit:ver<0.0.6+>:auth<zef:lizmat>;
use Prompt:ver<0.0.10+>:auth<zef:lizmat>;
use LLM::DWIM;

#- helper subs / ops -----------------------------------------------------------

# persist rounding at repl session level
my $round-val = 0.001;
sub r( $x ) { $round-val = $x }

# now provided by Physics::Measure
#multi prefix:<^>(Str:D $str) {
#    ♎️"$str";
#}
# roadmap is to also migrate these multis to Physics::Measure
multi prefix:<^>(List:D $new where $new.head ~~ Real) {
    my $str = $new.join(' ');
    ♎️"$str";
}
multi prefix:<^>(List:D $new where $new.head ~~ List) {
    Physics::Vector.new: |$new
}

multi prefix:<?>(Str:D $new) {
    chomp dwim $new ~ 'in a short sentence'
}
multi prefix:<?>(List:D $new) {
    chomp dwim $new.join('') ~ 'in a short sentence'
}

sub dwim-to-measure(Str $new) {
    my $preamble  = 'what is the ';
    my $postamble = ' just give me a decimal number, if exponential use simple e notation with no spaces, always omit the units';

    my $units;

    if $new ~~ / 'in' \s+ (.+) $ / {
        $units = ~$0
    } else {
        $units = '①';
    }

    my $value = chomp dwim $preamble ~ $new ~ $postamble;

    ♎️"$value $units";
}

multi prefix:<?^>(Str:D  $new) { dwim-to-measure($new) }
multi prefix:<?^>(List:D $new) { dwim-to-measure($new.join(' ')) }

#viz. https://github.com/Raku/problem-solving/issues/400
sub fraction(Str() $x) { $x.subst(/<ws>/, :g).AST.EVAL }

#- setting up evaluation construct ---------------------------------------------
my $context := context;
my $cu      := CodeUnit.new(:lang(BEGIN $*LANG), :$context, :multi-line-ok);
my $previous;

#- actual evaluation -----------------------------------------------------------
sub eval-me(Str() $cmd) is export {
    $Physics::Measure::round-val = $round-val;
    $Physics::Measure::round-sig = True;

    my $value := $cu.eval(
        'no strict;' ~
        $cmd
        .subst(/ '$_' /, { $previous }, :g)                                             # $_ topic is previous value
        .subst(/(\d+)'!'/, { [*] [1..$0] }, :g)                                         # ! for factorials
        .subst(/ '§|' (<-[|]>+) '|' /, { fraction($0) }, :g)                            # § for fractions
        .subst(/ (\w) '^' ([\D|$]) /, { "$0\c[Combining Right Arrow Above]$1" }, :g)    # ^ for vector notation
    );
    with $cu.exception {
        .say;
        $cu.exception = Nil;
    }

    # save value as previous
    if $value ~~ Measure {
        # reconstitute Measure as string
        my $error = ' ±' ~ $_ with $value.error // '';
        $previous = '♎️<' ~ $value.value ~ ' ' ~ $value.units ~ $error ~ '>';
    } else {
        $previous = $value;
    }

    if $value ~~ Order | Bool {
        $value
    } elsif $value ~~ Numeric && $round-val.defined {
        $value.round: $round-val;
    } else {
        $value;
    }
}

sub run-cmd(Str:D $cmd --> Nil) is export {
    try {
        if $cmd {
            my $out   := $*OUT.tell;
            my $value := eval-me($cmd);
            say $value if $*OUT.tell == $out;
        }
    }
    with $! { say "Error: " ~ .^name ~ " «" ~ .message ~ "»" }
}

#- script logic ----------------------------------------------------------------
proto sub MAIN (|) is export(:MAIN) {*}
multi sub MAIN () {
    # Redirect STDERR to /dev/null
    $*ERR = '/dev/null'.IO.open(:w);

    my $prompt = Prompt.new(:history($*HOME.add(".crag.history")));
    loop {
        last without my $line = $prompt.readline("> ");
        last if $line eq 'exit';
        run-cmd($line);
    }
    $prompt.save-history;
}
multi sub MAIN(Bool :$help!) {
    say q:to/HELP/;
Usage:
    crag [--help] <cmd>
    -or-
    crag -> REPL
Examples:
    [1] (1.6km / (60 * 60 * 1s)).in: <mph>       #0.99mph
    [2] $m=95kg; $a=^<9.81 m/s^2>; $m*$a         #931.95N
    [3] ^<12.5 ft ±3%> .in: <mm>                 #3810mm ±114.3
    [4] $λ=2.5nm; $ν=c/$λ; $ν.norm               #119.91PHz
    [5] $c=^<37 °C>; $f=^<98.6 °F>; $f cmp $c    #Same
    [6] @physics-constants-symbols.join: "\n"    # ...
    [7] ?^<TNT energy in J/kg>                   #4184000J/kg
    [8] US$42 .in: <£>                           #31.41GBP
More info:
    - https://github.com/librasteve/raku-Physics-Measure.git
    - https://github.com/librasteve/raku-Physics-Unit.git
    - https://github.com/librasteve/raku-Physics-Error.git
    - https://github.com/librasteve/raku-Physics-Constants.git
    - https://github.com/raku-community-modules/Slang-Roman
    - https://github.com/bduggan/raku-llm-dwim
- crag goes '^<value units [±error]>' => 'Physics::Measure.new: :$value, :$units :$error' )
- crag goes sub r( $x = 0.01 ) { $Physics::Measure::round-val = $x }
- crag goes ```subst( '§|(.+?)|' => 'Q|$0|.AST.EVAL' )```
- crag goes '?<something>' => dwim )
- crag goes '?^<something in units>' => dwim => 'Physics::Measure.new: value => dwim, :$units' )
- echo RAKULANG='en_US' for us gallons, pints, mpg, etc.
- zef install Physics::Units --force-install to refresh currency rates
HELP
}

multi sub MAIN(Str() $cmd) {
    run-cmd($cmd);
}

# vim: expandtab shiftwidth=4
