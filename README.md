[![License: Artistic-2.0](https://img.shields.io/badge/License-Artistic%202.0-0298c3.svg)](https://opensource.org/licenses/Artistic-2.0)

# raku App::Crag

Calculator using RAku Grammars for the command line

NB. The syntax for measures changed from `:<...>` to `^<...>` to avoid clashes with the colon

## Install
```raku
zef install App::Crag
```

## Usage
#### Use the `crag` command:
```raku
crag [--help] <cmd>
```
#### Use the `crag` REPL:
```raku
crag
```

## Examples
```raku
[1] > crag '(1.6km / (60 * 60 * 1s)).in: <mph>'               #0.99mph
[2] > crag '$m=95kg; $a=^<9.81 m/s^2>; $f=$m*$a; $f'          #931.95N
[3] > crag '^<12.5 ft ±3%> .in: <mm>'                         #3810mm ±114.3
[4] > crag '$λ=2.5nm; $ν=c/$λ; $ν.norm'                       #119.91PHz
[5] > crag '$c=^<37 °C>; $f=^<98.6 °F>; $f cmp $c'            #Same
[6] > crag '@physics-constants-symbols.join: "\n"'            # ...
```
- crag goes ```subst( '^<' => '♎️<' )``` 
- crag goes ```sub r( $x = 0.01 ) { $Physics::Measure::round-val = $x }```
- crag goes ```subst( '§|(.+?)|' => 'Q|$0|.AST.EVAL' )```
- crag goes ```subst( (\w)’^’ => $0\c[Combining Right Arrow Above] )```
- ```echo RAKULANG='en_US'``` for us gallons, pints, mpg, etc.

## More Info
- https://github.com/librasteve/raku-Physics-Measure.git
- https://github.com/librasteve/raku-Physics-Unit.git
- https://github.com/librasteve/raku-Physics-Error.git
- https://github.com/librasteve/raku-Physics-Constants.git
- https://github.com/raku-community-modules/Time-Duration-Parser
- https://github.com/raku-community-modules/Slang-Roman
- https://github.com/antononcube/Raku-Chemistry-Stoichiometry

### Copyright
copyright(c) 2023-2025 Henley Cloud Consulting Ltd.
