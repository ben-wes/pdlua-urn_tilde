# urn~

pdlua external for urn model random number generation.

### arguments
* `<int>` - numbers will be picked from 0 to n-1

### inlet
* impulse to pick next number
* `reset` to reset the current cycle
* `seed (<float>)` to reseed the random row (this should probably be manageable via signal input as well - or at least through mode changes of repeating or changing cycles)

### outlet 1
* picked number signal

### outlet 2
* impulse on cycle reset
