unit module App::Crag:ver<0.0.5>:auth<Steve Roe (librasteve@furnival.net)>;

$Physics::Measure::number-comma = ''; 
$Physics::Measure::round-val = 0.1;

use Time::Duration::Parser;

multi prefix:<♑️> ( Str:D $new )      is export { Time.new( value => duration-to-seconds($new), units => 's') }
multi prefix:<♑️> ( Duration:D $new ) is export { Time.new( $new ) }
