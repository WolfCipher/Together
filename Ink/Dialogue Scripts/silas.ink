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
~btn2 = 1
~btn3 = 1
~btn4 = 1

So, the name's Silvanus—Silvus for short. I hear you're interested in my research.
* [Where can we find a Sacred Gate?] -> SacredGate
* [What do you know about monsters?] -> Monsters


===SacredGate===
~btn1 = 0
~btn2 = 1
~btn3 = 1
~btn4 = 0
~ryl = 2
~elvyria = 3
Excellent question! Many believe Sacred Gates to be a simple metaphor for bridging between two peoples but I believe—
* [It's the only way home!] -> Mystical
* [We're in a bit of a hurry.] -> Rude
* [That they're real—we get it!] -> Rude
* [How do I find one?] -> Sigh

===Home===
~btn1 = 0
~btn2 = 1
~btn3 = 1
~btn4 = 1
~elvyria = 0
~ryl = 0
Right, right. You came to me for help, not the other way around.
* [So, how do we find a Sacred Gate?]->Migrate
* [Right.]->Migrate
===Migrate===
~ryl = 0
~elvyria = 1
- I hear that there are magical creatures that migrate to Sacred Gates for their warm, sacred light. These creatures are the only ones that can see the trails of light leading towards a Sacred Gate.
* [Wow! Magical creatures living here?]->Guide
* [Huh.]->Guide
===Guide===
~ryl = 1
~elvyria = 1
- If you find such a creature, it could guide you.
* [Oh! That could work!] -> Unfortunately
* [Neat. Where can we find one?] -> Unfortunately
===Unfortunately===
~ryl = 3
~elvyria = 0
- Unfortunately, that's all I can tell you.

* [I appreciate the help!] -> Journey
* [Well, thanks anyway.] -> Journey
===Journey===
~ryl = 0
~elvyria = 1
- But I can give you something to help you on your journey. Should monsters ambush you, you'll be able to fight them off in close quarters. How's that, eh?
* [Thank you!] -> END
* [Awesome.] -> END

===Mystical===
~btn1 = 0
~btn2 = 1
~btn3 = 1
~btn4 = 1
~ryl = 3
~elvyria = 4
My, my! You're an actual, real-life Mystical?!
* [Ummm... Yes?] -> MoonDapples
===MoonDapples===
~ryl = 2
~elvyria = 4
- Let me get a good look at you! I see... These markings on your face... How are they changing color?!
* [My moon dapples?] -> ColorChange
* [She just has magical freckles!] -> ColorChange
===ColorChange===
~ryl = 2
~elvyria = 3
- Yes, yes! How do they change color?
* [They just change with my emotions...] -> Ceremonial
===Ceremonial===
~ryl = 3
~elvyria = 3
- Fascinating! I've read about color-changing markings before. I thought they were simply ceremonial!
* [...] -> TellEverything
* [Soooo...] -> TellEverything
===TellEverything===
~ryl = 2
~elvyria = 4
- You must tell me everything there is to know about Mystia!
* [...] -> Home
* [Ahem. About getting Elvyria home?] -> Home

===Rude===
~btn1 = 0
~btn2 = 1
~btn3 = 1
~btn4 = 1
~ryl = 4
~elvyria = 3
My, my. How rude!
* [She didn't mean to be!] -> Sigh
* [...Sorry] -> Sigh
* [You don't understand! There are monsters!] -> Monsters

===Monsters===
~btn1 = 0
~btn2 = 1
~btn3 = 0
~btn4 = 0
~ryl = 2
~elvyria = 4
Ah! You must mean the spirits mentioned in my texts. From my studies, I believe that the battles of lore were real. Mysticals and Dullians, fighting side-by-side.
* [They were real! Mystia remembers them!] -> Mystical
* [Dullians...?] -> Dullians
* [Yes, exactly!] -> Agree

===Dullians===
~btn1 = 0
~btn2 = 1
~btn3 = 0
~btn4 = 0
~ryl = 3
~elvyria = 3
In the fairytales, the people of the non-magical land were called Dullians. That would most obviously be people like the three of us.
* [Actually... I'm a Mystical.] -> Mystical
* [Vyerity didn't tell you about Elvyria?] -> Mystical

===Sigh===
~btn1 = 0
~btn2 = 1
~btn3 = 0
~btn4 = 0
~elvyria = 1
~ryl = 3
Yes, yes. I understand. Few are interested in my work. Many think I'm crazy.
* [Don't worry. I'm crazy, too.] -> Agree
* [Elvyria just needs to return to Mystia!] -> Mystical

===Agree===
~btn1 = 0
~btn2 = 1
~btn3 = 0
~btn4 = 0
~elvyria = 0
~ryl = 0
It's so nice whenever someone understands! I suppose you two have known Vyerity for a long time?
* [No. I recently fell into the Dullworld.] -> Mystical
* [I have, but Elvyria's a Mystical.] -> Mystical
