unit module App::Crag:ver<0.0.25>:auth<zef:librasteve>;

use Slang::Roman;
use Slang::NumberBase;
use Physics::Measure :ALL;
use Physics::Vector;
use Physics::Constants;
use Chemistry::Stoichiometry;
use CodeUnit:ver<0.0.6+>:auth<zef:lizmat>;
use Prompt:ver<0.0.10+>:auth<zef:lizmat>;

#- helper subs / ops -----------------------------------------------------------
sub r( $x ) { $Physics::Measure::round-val = $x }

multi prefix:<^>(Str:D $new) {
    Measure.new: $new
}
multi prefix:<^>(List:D $new where $new.head ~~ Real) {
    Measure.new: $new.join(' ')
}
multi prefix:<^>(List:D $new where $new.head ~~ List) {
    Physics::Vector.new: |$new
}

#viz. https://github.com/Raku/problem-solving/issues/400
sub fraction(Str() $x) { $x.subst(/<ws>/, :g).AST.EVAL }

#- setting up evaluation construct ---------------------------------------------
my $context := context;
my $cu      := CodeUnit.new(:lang(BEGIN $*LANG), :$context, :multi-line-ok);

#- actual evaluation -----------------------------------------------------------
my sub eval-me(Str() $cmd) is export {
    $Physics::Measure::number-comma = '';
    $Physics::Measure::round-val = 0.01;

    my $value := $cu.eval('no strict; ' ~ $cmd
      .subst(/ '§|' (<-[|]>+) '|' /, { fraction($0) }, :g)
      .subst(/ (\w) '^' ([\D|$]) /, { "$0\c[Combining Right Arrow Above]$1" }, :g)
    );
    .say with $cu.exception;
    $value
}

my sub run-cmd(Str:D $cmd --> Nil) {
    if $cmd {
        my $out   := $*OUT.tell;
        my $value := eval-me($cmd);
        say $value if $*OUT.tell == $out;
    }
}

#- script logic ----------------------------------------------------------------
my proto sub MAIN (|) is export(:MAIN) {*}
my multi sub MAIN () {

    my $prompt = Prompt.new(:history($*HOME.add("crag.history")));
    loop {
        last without my $line = $prompt.readline("> ");
        run-cmd($line);
    }
    $prompt.save-history;
}
my multi sub MAIN(Bool :$help!) {
    say q:to/HELP/;
Usage:
    ./crag [--help] <cmd>
Examples:
    [1] > crag '(1.6km / (60 * 60 * 1s)).in: <mph>'        #0.99mph
    [2] > crag '$m=95kg; $a=^<9.81 m/s^2>; $m*$a'          #931.95N
    [3] > crag '^<12.5 ft ±3%> .in: <mm>'                  #3810mm ±114.3
    [4] > crag '$λ=2.5nm; $ν=c/$λ; $ν.norm'                #119.91PHz
    [5] > crag '$c=^<37 °C>; $f=^<98.6 °F>; $f cmp $c'     #Same
    [6] > crag '@physics-constants-symbols.join: "\n"'     # ...
More info:
    - https://github.com/librasteve/raku-Physics-Measure.git
    - https://github.com/librasteve/raku-Physics-Unit.git
    - https://github.com/librasteve/raku-Physics-Error.git
    - https://github.com/librasteve/raku-Physics-Constants.git
    - https://github.com/raku-community-modules/Slang-Roman
    - https://github.com/antononcube/Raku-Chemistry-Stoichiometry
- crag goes subst( '^<' => '♎️<' )
- crag goes sub r( $x = 0.01 ) { $Physics::Measure::round-val = $x }
- crag goes ```subst( '§|(.+?)|' => 'Q|$0|.AST.EVAL' )```
- echo RAKULANG='en_US' for us gallons, pints, mpg, etc.
HELP
}

my multi sub MAIN(Str() $cmd) {
    run-cmd($cmd);
}

# vim: expandtab shiftwidth=4
