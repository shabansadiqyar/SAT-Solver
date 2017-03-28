# SAT-Solver

The purpose of this project is to solve the satisfiability (SAT) problem. Given some propositional sentence ins conjunctive normal form (CNF) the lisp program will return if its satisfiable. The CNF will be satisfiable if there exists a complete variable assignment that satisfies all of the clauses. In this project, a CNF file is given in the form of:
```
p cnf 3 4
1 -2 3 0
-1 0
-2 -3 0
3 0
```
The first line corresponds to the problem line which states its in cnf, there are 3 variables and 4 clauses in the CNF. The rest of the lines are clause lines where a negative can be represented with a - sign. The end of a clause is represented by a 0. 

## How to Run and Test

The code can be run by first loaded into the lisp interpreter by typing
```
(load "sat-solver.lsp").
```
The code can be ran by typing
```
(sat? 3 ’((1 -2 3) (-1) (-2 -3))).
```
which should return (-1 -2 3). This is just an example but a CNF file can also be given to the sat-solver.
