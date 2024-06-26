unit module App::Crag:ver<0.0.19>:auth<Steve Roe (librasteve@furnival.net)>;

use MONKEY-SEE-NO-EVAL;

multi sub capricorn( Str:D $new ) {
    use Physics::Measure :ALL;
    use Time::Duration::Parser;

    Time.new( value => duration-to-seconds($new), units => 's');
}

multi sub capricorn( Duration:D $new ) {
    use Physics::Measure :ALL;
    use Time::Duration::Parser;

    Time.new( $new );
}

multi sub capricorn( List:D $new ) {
    use Physics::Measure :ALL;
    use Time::Duration::Parser;

    Time.new( value => duration-to-seconds($new.join(' ')), units => 's');
}

#viz. https://github.com/Raku/problem-solving/issues/400
sub fraction($x) {
    $x.AST.EVAL;
}

sub eval-me( $cmd ) is export {
    my $settings = q/
        $Physics::Measure::number-comma = '';

        $Physics::Measure::round-val = 0.01;
        sub r( $x ) { $Physics::Measure::round-val = $x; }

        sub pos(\a,\b) {Position.new: a,b}
    /;

    my $new = $cmd;
    $new ~~ s:g/':<'/♎️\</;
    $new ~~ s:g/'|<'/♓️\</;
    $new ~~ s:g/'^<'/♑️\</;
    $new ~~ s:g/'§|' (.+?) '|'/{fraction($0)}/;
    $new ~~ s:g/(\w)'^'/$0\c[Combining Right Arrow Above]/;
    $new = $settings ~ $new;

    multi prefix:<♑️> ( Str:D      $new ) { capricorn( $new) }
    multi prefix:<♑️> ( Duration:D $new ) { capricorn( $new) }
    multi prefix:<♑️> ( List:D     $new ) { capricorn( $new) }

    use Math::Vector;
    multi prefix:<^> ( List:D $new ) { Math::Vector.new: $new }

    EVAL qq/
        use Physics::Unit;
        use Physics::Constants;
        use Physics::Navigation;
        use Physics::Measure :ALL;
        use Slang::Roman;
        use Chemistry::Stoichiometry;
        use Math::Vector;
        no strict;

        $new/;
}



