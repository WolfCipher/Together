// 0: neutral
// 1: happy
// 2: determined
// 3: concerned
// 4: shocked
VAR ryl = 3
VAR elvyria = 3

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

// RYL
~btn1 = 0
~btn2 = 0
~btn3 = 0
~btn4 = 0
~dialog = 1
~ryl = 3
~elvyria = 3
So...
* This is the last day... ->Last

// ELVYRIA
===Last===
~btn1 = 1
~btn2 = 1
~dialog = 0

* Yes... -> Silence
* Does it have to be? -> Convince

// RYL
===Silence===
~btn1 = 0
~btn2 = 0
~btn3 = 0
~btn4 = 0
~dialog = 1

 * ... -> Silence2
 
// Elvyria
===Silence2===
~btn1 = 1
~btn2 = 1
~btn3 = 1
~btn4 = 1
~dialog = 0

 * ... -> Convince
 
// RYL
===Convince===
~btn1 = 0
~btn2 = 0
~btn3 = 0
~btn4 = 0
~dialog = 1

 * Someday, we'll meet again! -> Elvyria

// ELVYRIA
===Elvyria===
~ryl = 4
~elvyria = 2
~btn1 = 1
~btn2 = 1
~btn3 = 1
~btn4 = 1
~dialog = 0

* Elvyria... -> Again
* You never give up. -> Again

// RYL
===Again===
~ryl = 0
~elvyria = 3
~btn1 = 0
~btn2 = 0
~btn3 = 0
~btn4 = 0
~dialog = 1

* I'll convince them... I swear it! -> Swear

// ELVYRIA
===Swear===
~ryl = 3
~elvyria = 2
~btn1 = 1
~btn2 = 1
~btn3 = 1
~btn4 = 1
~dialog = 0

 * You'll get them to open the gates...? -> Next
 * Elvyria... -> Next
 
 // RYL
 ===Next===
~ryl = 0
~elvyria = 3
~btn1 = 0
~btn2 = 0
~btn3 = 0
~btn4 = 0
~dialog = 1

 * Let me give you my amulet! -> What
 
 // Elvyria
 ===What===
 ~ryl = 4
 ~elvyria = 2
 ~btn1 = 1
 ~btn2 = 1
 ~btn3 = 1
 ~btn4 = 1
 ~dialog = 0
 
 * But it's special to you! -> Promise
 
 // Ryl
 ===Promise===
 ~ryl = 3
 ~elvyria = 0
 ~btn1 = 0
 ~btn2 = 0
 ~btn3 = 0
 ~btn4 = 0
 ~dialog = 1
 
 * And one day I'll come back to get it. -> Arrow
 
 // Elvyria
 ===Arrow===
 ~ryl = 0
 ~elvyria = 1
 ~btn1 = 1
 ~btn2 = 1
 ~btn3 = 1
 ~btn4 = 1
 ~dialog = 0
 
 * ...Then take one of my finest arrows. -> Carve
 
 // Ryl
 ===Carve===
 ~ryl = 2
 ~elvyria = 4
 ~btn1 = 0
 ~btn2 = 0
 ~btn3 = 0
 ~btn4 = 0
 ~dialog = 1
 * The ones you made yourself? -> MadeYourself
 
// Elvyria
===MadeYourself===
 ~ryl = 0
 ~elvyria = 3
 ~btn1 = 1
 ~btn2 = 1
 ~btn3 = 1
 ~btn4 = 1
 ~dialog = 0
* Yes... Are you crying? -> Crying

// Ryl
===Crying===
~ryl = 3
 ~elvyria = 0
 ~btn1 = 0
 ~btn2 = 0
 ~btn3 = 0
 ~btn4 = 0
 ~dialog = 1
* Heh. The question is, why aren't you? -> Ha

// Elvyria
===Ha===
 ~ryl = 0
 ~elvyria = 0
 ~btn1 = 1
 ~btn2 = 1
 ~btn3 = 1
 ~btn4 = 1
 ~dialog = 0
 * Ha! -> Cmon
 
 // RYL
 ===Cmon===
 ~ryl = 1
 ~elvyria = 0
 ~btn1 = 0
 ~btn2 = 0
 ~btn3 = 0
 ~btn4 = 0
 ~dialog = 1
 
 * Follow me! I'll show you around. -> Continue
 
 
// ELVYRIA
 ===Continue===
 ~ryl = 1
 ~elvyria = 1
 ~btn1 = 1
 ~btn2 = 1
 ~btn3 = 1
 ~btn4 = 1
 ~dialog = 0
 
 * Let's go!
 * OK

-

-> END
