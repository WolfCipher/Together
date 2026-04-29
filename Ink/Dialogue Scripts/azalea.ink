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

Tell me everything, you two.
* [One of the Sacred Gates is broken!] -> SacredGate
* [Monsters are everywhere!] -> Monsters


===SacredGate===
~btn1 = 0
~btn2 = 1
~btn3 = 1
~btn4 = 0
~ryl = 3
~elvyria = 3
Hmm. I would say that's impossible if not for the evidence in front of me... nor the dream that I had last night.
* [What was your dream this time?] -> MonsterDream
* [Dream?] -> Prophecy

===Monsters===
~btn1 = 0
~btn2 = 1
~btn3 = 0
~btn4 = 0
~ryl = 2
~elvyria = 4

Monsters... so it is as I feared.

* [Did you have a dream?] Indeed... -> MonsterDream
* [You suspected it?] -> Prophecy

===Prophecy===
~btn1 = 0
~btn2 = 1
~btn3 = 1
~btn4 = 0
~ryl = 4
~elvyria = 0
I am called a Dreamer, young Ryl. Usually, Dreamers dream up ideas for a better world. Occasionally, our dreams are omens. And sometimes, our dreams are just dreams.
* [She's the First Dreamer!] -> Bashful
* [So, you had a prophetic dream?] Yes, Ryl. -> MonsterDream

===Bashful===
~btn1 = 0
~btn2 = 1
~btn3 = 1
~btn4 = 0
~ryl = 0
~elvyria = 1
Well, yes, but I couldn't have achieved anything without my dear companion, Gentian. But that's a story for another day.
* [Someday, I'll be just like her, Ryl!]
* [I wonder what Vyerity would think...]
- Ahem... -> MonsterDream

===MonsterDream===
~ryl = 3
~elvyria = 4
Last night, I dreamt about monsters. I was concerned the dream was an omen. That's why I'm all the way out here. I was on my way to check out the Sacred Gate here.
* [...I broke through the seal to get back.] -> Alright
===Alright===
~ryl = 3
~elvyria = 1
That's alright, dear. I'm happy you're back.
* [Me too!] -> Now
* [What now?] -> Now
===Now===
~ryl = 0
~elvyria = 0
All that matters now is to deal with the fate we've been given.
* [How can we help?] -> No
* [Count me in!] -> No
===No===
~ryl = 3
~elvyria = 2
No. Anything you have faced has only been a fraction of dark magic's power. The adults will handle it.
* [This is my home, too!] -> Ryl
* [But...] -> Ryl
===Ryl===
~ryl = 2
~elvyria = 4
Besides, Ryl needs to go home.
*[But she hasn't seen everything yet!] -> Seal
*[I just got here!] -> Seal
===Seal===
~ryl = 3
~elvyria = 3
If we reseal the Sacred Gates now, Ryl will be stuck in Mystia.
*[So, I'll never see her again?] -> Night
*[...] -> Night
===Night===
~ryl = 3
~elvyria = 3
...It'll take some time to hunt down the monsters and strengthen the Sacred Gates. Ryl can stay the night.
*[...Okay.] -> END
*[...Thanks.] -> END
