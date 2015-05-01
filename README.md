[![Code Climate](https://codeclimate.com/github/jacobcmurphy/elevators/badges/gpa.svg)](https://codeclimate.com/github/jacobcmurphy/elevators)

Contact
=======
Jacob Murphy  
jcmurphy@brandeis.edu

Simulation Usage
==================
To run, type: *ruby sim.rb*

To change simulation variables:  
In sim.rb
  * NUM_OF_FLOORS = 4
    - the number of floors in the building
  * MAX_PEOPLE_PER_FLOOR = 5
    - the most people that can wait for an elevator on one floor
  * NUM_OF_ELEVATORS = 2
    - the number of elevators in the building
  * NUM_OF_TICKS = 5
    - the number of turns in the simulation

In elevator.rb
  * ELEV_MAX_PERSONS = 5
    - the maximum capacity of an elevator
  * ELEV_RESTING_FLOOR = 0
    - the floor that elevators wait at when unneeded

Elevator Logic Design
=====================
My approach believes that a Building and its ElevatorController
should control the logic of how the elevators move. This allows
for more intelligent direction decisions since elevators are
not operating entirely independently. The general idea of the
algorithm is to load currently occupied elevators with people
going in the same direction, and then determine where to move
the unoccupied elevators. Unoccupied elevators move to the
closest floor that has people waiting; if there are no waiting
people, then the elevator goes to its resting floor.

The Person class exists largely as a data store for
which floor they are going to. A Floor only knows if it has people
waiting for an elevator and if people want to go up or down.
An Elevator knows to switch directions if it has reached the top
or bottom floor. It also counteracts the move option if it is
unneeded and at its resting floor. When an elevator moves, it
increments its current floor if going up or decrements it if
going down. At the new floor, all passengers are emptied from
the elevator and ignored by the program from then on.


Simulation Structure
====================
The Simulation class is very straight-forward. It just registers
items and tells each item to simulate action. For how I structured
my work, it is important that the Building is the first item
registered (and thus told to act for each tick) due to its
importance in elevator motion logic. The Floors do not need
registration since they react when an elevator arrives.

The flow of events for each simulated moment is:
* All partially occupied elevators are loaded with people from
the floor they currently are at.
* The direction of all empty elevators is decided and they are loaded.
* All elevators move in their required directions.
* All elevators are unloaded
