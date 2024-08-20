# urn~

pdlua external for urn model random number generation.
requires `pdlua` - see https://github.com/agraef/pd-lua

### arguments
* `<int>` - numbers will be picked from 0 to n-1

### inlet 1
* impulse signal to pick next number
* `reset` message to reset the current cycle
* `range <float>` message to set value range
* `seed (<float>)` message to reseed the random row (this should probably be manageable via signal input as well - or at least through mode changes of repeating or changing cycles)

### inlet 1
* integer signal > 0 to set seed and reset on new cycle (useful for fast repeating value output)

### outlet 1
* picked number signal

### outlet 2
* impulse on cycle reset
