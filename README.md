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

For LLM::DWIM features, you will need e.g. a [Gemini App Key](https://ai.google.dev/gemini-api/docs/api-key)

## Examples
```
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

- crag goes '^<...>' => '♎️<...>' )
- crag goes sub r( $x = 0.01 ) { $Physics::Measure::round-val = $x }
- crag goes subst( '§|(.+?)|' => 'Q|$0|.AST.EVAL' )
- crag goes '?<...>' => dwim )
- crag goes '?^<...>' => dwim => '♎️<...>' )
- echo RAKULANG='en_US' for us gallons, pints, mpg, etc.
```

## More Info
- https://github.com/librasteve/raku-Physics-Measure.git
- https://github.com/librasteve/raku-Physics-Unit.git
- https://github.com/librasteve/raku-Physics-Error.git
- https://github.com/librasteve/raku-Physics-Constants.git
- https://github.com/raku-community-modules/Time-Duration-Parser
- https://github.com/raku-community-modules/Slang-Roman
- https://github.com/bduggan/raku-llm-dwim

### Copyright
copyright(c) 2023-2025 Henley Cloud Consulting Ltd.
