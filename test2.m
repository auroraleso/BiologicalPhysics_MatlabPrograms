state = [0 1 0 0 1];

state_2  = [1 state ~state(end)]
state_3 = cumsum(state_2)
open_array = diff(state_3)
open_array (open_array == 0) = []