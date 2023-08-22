unit module App::Crag:ver<0.0.7>:auth<Steve Roe (librasteve@furnival.net)>;

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

sub eval-me( $cmd ) is export {
    my $settings = q/
        $Physics::Measure::number-comma = '';

        $Physics::Measure::round-val = 0.01;
        sub r( $x ) { $Physics::Measure::round-val = $x; }
    /;

    my $new = $cmd;
    $new ~~ s:g/':<'/♎️\</;
    $new ~~ s:g/'|<'/♓️\</;
    $new ~~ s:g/'^<'/♑️\</;
    $new = $settings ~ $new;

    multi prefix:<♑️> ( Str:D $new ) { capricorn( $new) }
    multi prefix:<♑️> ( Duration:D $new ) { capricorn( $new) }
    multi prefix:<♑️> ( List:D $new ) { capricorn( $new) }

    EVAL qq/
        use Physics::Constants;
        use Physics::Navigation;
        use Physics::Measure :ALL;
        no strict;
        $new/;

}

