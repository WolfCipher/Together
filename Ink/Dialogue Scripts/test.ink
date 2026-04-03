// 0: neutral
// 1: happy
// 2: determined
// 3: concerned
// 4: shocked
VAR ryl = 4
VAR elvyria = 4

// 0: elvyria responds
// 1: ryl responds
// 2: no one in particular responds
VAR btn1 = 0
VAR btn2 = 0
VAR btn3 = 0
VAR btn4 = 0

// 0: elvyria speaks
// 1: ryl speaks
// anything else: blank icon
VAR dialog = 1


What were those things?

 * Oh no, this is bad. -> Huh
 * I... no... -> Huh
 * This can't be happening! -> Huh
 * They're beasts! -> Huh


===Huh===
~ryl = 3
~elvyria = 4

- Huh?

 * [This is the Dullworld, isn't it?] -> Dullworld
 * [Where am I?] -> Where
 
 
 ===Dullworld===
~ryl = 3
~elvyria = 3

 What? I haven't heard of that place. You're in Tamewood.

 -> Tamewood
 
 
 ===Where===
 ~ryl = 0
 ~elvyria = 0
 
 You're in Tamewood. -> Tamewood
 
 
 ===Tamewood===
 * [Tamewood...] -> Cmon
 * [The way back home...] -> Cmon
 
 
 ===Cmon===
 ~ryl = 1
 ~elvyria = 3
 
 - C'mon, let me show you around.
 
 * ...
 * OK

-

-> END
