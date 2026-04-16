// 0: neutral
// 1: happy
// 2: determined
// 3: concerned
// 4: shocked
VAR ryl = 0
VAR elvyria = 0

// 0: elvyria responds
// 1: ryl responds
// 2: no one in particular responds
VAR btn1 = 0
VAR btn2 = 0
VAR btn3 = 1
VAR btn4 = 1

// 0: elvyria speaks
// 1: ryl speaks
// anything else: blank icon
VAR dialog = 2

~btn1 = 0
~btn2 = 0
~btn3 = 1
~btn4 = 1

So, you're from Mystia, eh? How exactly did you get here?
* [I was pulled through a Sacred Gate!] -> SacredGate
* [Do you also not believe Mystia exists?] -> Disbelief
* [Elvyria appeared out of nowhere!] -> SacredGate
* [We should talk about the monsters first!] -> Monsters


===SacredGate===
~btn1 = 0
~btn2 = 0
~btn3 = 0
~btn4 = 1
A Sacred Gate, hmm? I've heard tales of those in my travels.
* [Do you know how to find one?] -> Home
* [It's the only way home!] -> Home
* [Monsters broke the Sacred Gate here!] -> Monsters
* [Really? Where?] -> Silas

===Home===
~btn1 = 0
~btn2 = 1
~btn3 = 1
~btn4 = 1
I can't help you but I know someone who may be able to help you.
* [Who?] -> Silas
* [What about the monster problem?] -> Monsters

===Disbelief===
~btn1 = 0
~btn2 = 1
~btn3 = 1
~btn4 = 1
Not particularly, but I know someone who does.
* [Who?] -> Silas
* [...Really?] -> Silas

===Monsters===
~btn1 = 1
~btn2 = 0
~btn3 = 0
~btn4 = 0
Monsters?
* [Creatures made of dark magic!]
* [They want to consume the Dullworld!]
* [Like the ones from millennia ago!]

-Hmm. What would Silas say?
* [Is that the fancy scholar?] -> Silas
* [Who?] -> Silas

===Silas===
~btn1 = 0
~btn2 = 1
~btn3 = 1
~btn4 = 1
Silas is a researcher of the old fairytales. He tries to separate truth from myth.
* [...A fairytale researcher?]
* [Truth from myth, huh...]
-I met him when I was visiting a nearby village. He had recently moved there from the capital. People found him a bit... eccentric.
* [I've been called that, too.]
* [Why?]
-...He believes he has found artifacts that prove aspects of the fairytales were real.
* [What fairytales?]
* [Artifacts...?]

-You should talk to Silas about that. Out of anyone, he'd know what to do.
* [Great!]
* [Got it.]

-Oh, and I'd like to give you two some gear to keep you safe on your travels.
* [Oh, thank you!] -> END
* [Wow! Your own traveling gear!] -> END
