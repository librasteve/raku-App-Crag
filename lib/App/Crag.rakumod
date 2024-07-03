unit module App::Crag:ver<0.0.19>:auth<Steve Roe (librasteve@furnival.net)>;

use MONKEY-SEE-NO-EVAL;

#viz. https://github.com/Raku/problem-solving/issues/400
sub fraction($x) {
    $x.AST.EVAL;
}

sub eval-me( $cmd ) is export {
    my $settings = q/
        $Physics::Measure::number-comma = '';

        $Physics::Measure::round-val = 0.01;
        sub r( $x ) { $Physics::Measure::round-val = $x }

        multi prefix:<^> ( List:D $new ) { Math::Vector.new: $new }

    /;

    my $new = $cmd;
    $new ~~ s:g/':<'/♎️\</;
    $new ~~ s:g/'§|' (.+?) '|'/{fraction($0)}/;
    $new ~~ s:g/(\w)'^'/$0\c[Combining Right Arrow Above]/;
    $new = $settings ~ $new;

    EVAL qq/
        use Physics::Measure :ALL;
        use Physics::Constants;
        use Math::Vector;
        use Slang::Roman;
        use Chemistry::Stoichiometry;
        no strict;

        $new/;
}

