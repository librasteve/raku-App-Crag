unit module App::Crag:ver<0.0.24>:auth<Steve Roe (librasteve@furnival.net)>;

use MONKEY-SEE-NO-EVAL;

#viz. https://github.com/Raku/problem-solving/issues/400
sub fraction($x is copy) {
    $x ~~ s:g/<ws>//;
    $x.AST.EVAL;
}

sub eval-me( $cmd ) is export {
    my $settings = q/
        $Physics::Measure::number-comma = '';

        $Physics::Measure::round-val = 0.01;
        sub r( $x ) { $Physics::Measure::round-val = $x }

        multi prefix:<^>(Str:D $new) {Measure.new: $new}
        multi prefix:<^>(List:D $new where $new[0] ~~ Real) {Measure.new: $new.join(' ')}
        multi prefix:<^>(List:D $new where $new[0] ~~ List) {Physics::Vector.new: |$new}

    /;

    my $new = $cmd;

    $new ~~ s:g/'§|' (.+?) '|'/{fraction($0)}/;
    $new ~~ s:g/(\w)'^'([\D|$])/$0\c[Combining Right Arrow Above]$1/;

    $new = $settings ~ $new;

    EVAL qq/
        use Physics::Measure :ALL;
        use Physics::Vector;
        use Physics::Constants;
        use Slang::Roman;
        use Slang::NumberBase;
        use Chemistry::Stoichiometry;
#        use Math::Sequences;
        no strict;

        $new/;
}

