unit module App::Crag:ver<0.0.5>:auth<Steve Roe (librasteve@furnival.net)>;

use MONKEY-SEE-NO-EVAL;

sub eval-me( $cmd ) is export {

    my $new = $cmd;
    $new ~~ s:g/':<'/♎️\</;
    $new ~~ s:g/'|<'/♓️\</;

    EVAL qq/
        use Physics::Constants;
        use Physics::Navigation;
        use Physics::Measure :ALL;
        no strict;
        $new/;

}

#nothing to see
