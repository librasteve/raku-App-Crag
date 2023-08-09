[![License: Artistic-2.0](https://img.shields.io/badge/License-Artistic%202.0-0298c3.svg)](https://opensource.org/licenses/Artistic-2.0)

# raku App::Ralc

raku calculator for the command line

## Install
```raku
zef install --verbose App::Ralc
```

## Usage
```raku
ralc [--help] <cmd>
```

## Examples
```raku
[1] > ralc 'say (1.6km / (60 * 60 * 1s)).in: <mph>'               #0.994194mph
[2] > ralc 'my \m=95kg; my \a=♎️<9.81 m/s^2>; my \f=m*a; say f'   #931.95N
[3] > ralc 'say ♎️<12.5 ft ±3%> .in: <mm>'                        #3810mm ±114.3
[4] > ralc 'my \λ=2.5nm; my \ν=c/λ; say ν.norm'                   #119.916..PHz
[5] > ralc 'my \x=♎️<37 °C>; my \y=♎️<98.6 °F>; say x cmp y'      #Same
[6] > ralc 'say ♓️<80°T> + ♓️<43°30′30″M> .T'                     #124°ESE (T)
[7] > ralc 'say @physics-constants-abbreviations.join: "\n"'      # ...
```

## More Info
- https://github.com/librasteve/raku-Physics-Measure.git
- https://github.com/librasteve/raku-Physics-Unit.git
- https://github.com/librasteve/raku-Physics-Error.git
- https://github.com/librasteve/raku-Physics-Constants.git
- https://github.com/librasteve/raku-Physics-Navigation.git

### Copyright
copyright(c) 2023 Henley Cloud Consulting Ltd.
