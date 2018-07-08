import numpy as np
import random as rnd

# The statespace
states = ["Sleep", "Run", "Icecream"]

# All possible state transitions
transitionName = [
  ["SS", "SR", "SI"],
  ["RS", "RR", "RI"],
  ["IS", "IR", "II"]
]

# Probability Matrix
transitionMatrix = [
  [0.2, 0.6, 0.2],
  [0.1, 0.6, 0.3],
  [0.2, 0.7, 0.1]
]

# Mapping of states
stateMap = {
  "Sleep": {
    "transitions": transitionName[0],
    "matrixRow":   transitionMatrix[0]
  },
  "Run": {
    "transitions": transitionName[1],
    "matrixRow":   transitionMatrix[1]
  },
  "Icecream": {
    "transitions": transitionName[2],
    "matrixRow":   transitionMatrix[2]
  }
}

# assert sum(transitionMatrix[0]) == 1, "1st row of matrix does not sum to 1!"
# assert sum(transitionMatrix[1]) == 1, "2nd row of matrix does not sum to 1!"
# assert sum(transitionMatrix[2]) == 1, "3rd row of matrix does not sum to 1!"

def forecast(days):
  # Choose a starting state
  curState = "Sleep"
  print("Start State: " + curState)
  # Store the sequence of states taken so far
  stateList = [curState]
  prob = 1
  for i in range(0, days):
    data = stateMap[curState]
    trans = data["transitions"] # The list of transitions from `curState`
    row = data["matrixRow"] # The list of probabilities starting at `curState`
    change = np.random.choice(trans, replace=True, p=row) # Pick a random transition to perform
    idx = trans.index(change) # Identifier for finding the transition
    prob *= row[idx] # Change the probability
    curState = states[idx] # Change to new current state
    stateList.append(states[idx]) # Add to the list of visited states
  print("State List: ")
  print(stateList)
  print("-----------")
  print("End state after {} days: {}".format(days, curState))
  print("Probability of the sequence of events: {0:.2f}%".format(prob*100))

forecast(5)
