# Markov Chains

## What are they?
A collection of random variables that transition from one state to another according to
certain probabilistic rules.  These rules should be dependent only on the current state
and the time elapsed, and not on a sequence of states that preceded the change.  _Due to
this rule, Markov sequences are_ **memoryless**, _since they don't need to store previous
state._

### Discrete Time Markov Chain
A random process with a discrete set of times, rather than a discrete state space.  "Markov
Chain" usually refers to this type.

### Transition Matrix
This is a table that contains the probability of transitioning from one state to another.
The table is represented as such:
```
Rows:  Starting State
Cols:  Ending State
IMPORTANT:
  Each row's values must sum to 1
```
| | | | |
| --- |
|   | A | B | C |
| A | 0.5 | 0.2 | 0.3 |
| B | 0.1 | 0.5 | 0.4 |
| C | 0.8 | 0.1 | 0.1 |

### Important Properties of Markov Chains
1. **Reducibility:**  A Markov Chain is irreducible if there exists a chain of states from any
starting state to any ending state _that has a positive probability_.
2. **Periodicity:**  A state in a Markov Chain is periodic if, given the state _i_, you can
only return to state _i_ at multiples of an integer greater than **1**, otherwise the Markov
Chain is "aperiodic".
3. **Transience:**  A state _i_ is transient if there is a non-zero probability
of never returning to state _i_.
4. **Recurrence:**  A state is positive recurrent if it is not transient and is expected to return
in a finite number of steps -- otherwise it is "null recurrent".
5. **Ergodicity:**  A state is ergodic if it is _aperiodic_ and _positive recurrent_.  If all states
of an irreducible Markov Chain are ergodic, then the entire chain is ergodic.
6. **Absorbing State:**  A state _i_ is absorbing if it is impossible to leave this state.  So:
State `i` is "absorbing" if P<sub>ii</sub> = 1 and P<sub>ij</sub> = 0 for i ≠ j.
