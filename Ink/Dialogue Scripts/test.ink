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
VAR btn1 = 1
VAR btn2 = 1
VAR btn3 = 1
VAR btn4 = 1

// 0: elvyria speaks
// 1: ryl speaks
// anything else: blank icon
VAR dialog = 0

// ELVYRIA
~btn1 = 1
~btn2 = 1
~dialog = 0

Phew...

* What were those things? -> RylConfused
* Are you alright? -> RylConcerned

// RYL
===RylConfused===
~ryl = 3
~elvyria = 4
~btn1 = 0
~btn2 = 0
~btn3 = 0
~btn4 = 0
~dialog = 1

 * Oh no, this is bad. -> Huh
 * They're beasts! -> Huh

// ELVYRIA
===RylConcerned===
~ryl = 3
~elvyria = 4
~btn1 = 0
~btn2 = 0
~btn3 = 0
~btn4 = 0
~dialog = 1

* This can't be happening! -> Huh
* I... no... -> Huh

// RYL
===Huh===
~ryl = 3
~elvyria = 3
~btn1 = 1
~btn2 = 1
~btn3 = 1
~btn4 = 1
~dialog = 0

* Huh? -> ElvyriaCalms
* Okay, okay, calm down. -> ElvyriaCalms

// ELVYRIA
===ElvyriaCalms===
~ryl = 3
~elvyria = 0
~btn1 = 0
~btn2 = 0
~btn3 = 0
~btn4 = 0
~dialog = 1

 * This is the Dullworld, isn't it? -> Dullworld
 * Where am I? -> Where
 
 // RYL
 ===Dullworld===
~ryl = 3
~elvyria = 3
~btn1 = 1
~btn2 = 1
~btn3 = 1
~btn4 = 1
~dialog = 0

 * What? I haven't heard of that place. -> Lost
 * You're in Tamewood. -> Tamewood
 * Dullworld? Ha! -> Lost
 
 // RYL
 ===Where===
 ~ryl = 3
 ~elvyria = 3
 ~btn1 = 1
 ~btn2 = 1
 ~btn3 = 1
 ~btn4 = 1
 ~dialog = 0
 
 * You're in Tamewood. -> Tamewood
 * This is my home! -> Lost
 * Wow, you're really lost, aren't you? -> Lost
 
 // ELVYRIA
 ===Tamewood===
 ~ryl = 0
 ~elvyria = 0
 ~btn1 = 0
 ~btn2 = 0
 ~btn3 = 0
 ~btn4 = 0
 ~dialog = 1
 
 * Tamewood... -> Cmon
 * The way back home... -> Cmon
 
 // ELVYRIA
 ===Lost===
 ~ryl = 0
 ~elvyria = 0
 ~btn1 = 0
 ~btn2 = 0
 ~btn3 = 0
 ~btn4 = 0
 ~dialog = 1
 
 * The way back home... -> Cmon
 * The butterfly... -> Cmon
 * At least my amulet is intact. -> Cmon
 
 // RYL
 ===Cmon===
 ~ryl = 0
 ~elvyria = 3
 ~btn1 = 1
 ~btn2 = 1
 ~btn3 = 1
 ~btn4 = 1
 ~dialog = 0
 
 * C'mon, let me show you around. -> Continue
 * Hey, it'll be alright. Follow me. -> Continue
 
 
// ELVYRIA
 ===Continue===
 ~ryl = 1
 ~elvyria = 0
 ~btn1 = 0
 ~btn2 = 0
 ~btn3 = 0
 ~btn4 = 0
 ~dialog = 1
 
 * Let's go!
 * OK

-

-> END
