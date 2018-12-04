
/*
 Crucial Crew 2017. "A crucial day out"
 Authors: Jacey Lamerton and Pat Smith
*/

LIST location = kitchen_, garden_, street_, street_crossing_, park_, railway_, river_, park_bully_, garden_fixed_, kitchen_fixed_

LIST goals = phone_gas, online_safety, saved_bernie, house_fire_first, saved_swimmer, bully_challenged

LIST contacts = mum, emergency_services, gas_emergency, alisha

LIST inventory = phone, bottle, empty_can, stick

LIST bottle_state = full, empty, nearly_empty

VAR score = 0

VAR max_possible_score = 25

CONST PHONE_EMERGENCY = "999"
CONST PHONE_EMERGENCY_EU = "112"
CONST PHONE_GAS_EMERGENCY = "0800 111 999"
CONST PHONE_NON_EMERGENCY_POLICE = "101"

// 999 and 112 calls are free and can be dialled from a locked mobile phone.


-> kitchen
//-> garden
//-> street
//-> park
//-> river
//-> river.river_rescue
//-> railway
//-> park_bully.jenemica_arrives
//-> kitchen_fixed

=== test ===
    ~ location = kitchen_
    #PLAYER:pos:150:650:happy
    This is a test not part of the game. This bit is a paragraph of story text!
    MSG_NEG: This is a negative message. You did a bad thing and there will be consequences!
    MSG_POS: This is a positive message. You did a good thing and there will be consequences!
    You: This is the PC talking.
    Alisha: This is Alisha talking.
    Dad: This is Dad talking.
    Officer: This is the Offier talking.
    Bernie: This is Bernie talking.
    Firefighter: This is the Firefighter talking.
    Swimmer: This is the Swimmer talking.
    {score_points(1)}
    + CUE: This is a player cue
    + Option One
    + Option Two is really long which we generally avoid.
    + Continue
    -
    -> test

// a tunnel - more conversation based perhaps
=== advice_gas ===
    MSG_NEG: If you smell gas, don't switch anything electrical on or off! Open a window or door if you can and then get out fast.
    MSG_NEG: Tell an adult - or call the gas emergency number 0800 111 999.
-   ->->

=== advice_meetup ===
    MSG_NEG: Oh dear! Never meet up with anyone you don't know in real life.
-   ->->

=== save_bernie ===
    - (start)
    VAR bernie_ref = "There's a kid called Bernie"
    Tell the police officer about,
    *   [Bernie and the trains]
        #FRAME:officer:worried
        #PLAYER:mood:hurt
        You: {bernie_ref} messing about down on the railway lines!
        You point to the hole in the hedge.
        Officer: Oh no! That's extremely dangerous! Excuse me.
        * * [Continue]
            #FRAME:officer:neutral
            #PLAYER:mood:contented
            Officer Paula grabs her radio microphone and speaks into it.
            Officer: Officer responding to a report of a child playing on railway lines on East Street. Proceeding immediately.
            {score_points(1)}
        - -
        * * [Continue]
            #DEPART:officer
            Officer Paula, nods at you and runs off towards the hedge.
            -> end
    *   [Bernie trespassing]
        You: {bernie_ref} trespassing on private land!
        Officer: Oh? Whereabouts?
        ~bernie_ref = "He's"
        -> start
    - (end)
    ~ goals += saved_bernie
-   ->->


// a function
=== function print_score ===
    You scored {score} out of a possible {max_possible_score}.

=== function score_points (points) ===
    ~score += points
    SCORE:Your score has gone up by {points} point{points > 1:s}.
    SCORE:You now have {score}.

//=== radio_switch(-> return_to)
//    // Track radio state in a var. play music in game
//    +   [SPRITE:kitchen:radio:675:635:off]
//        Alisha:Moosique!                #FRAME:alisha:whistling
//    -   (done) -> return_to

=== kitchen ===
    ~ location = kitchen_
    #PLAYER:pos:150:650:happy
    It's a fine Saturday morning at the start of the holiday and you've got the whole day ahead of you and no plans.
    Well, except maybe to eat some of the food Dad is going to barbecue later on.
    "KNOCK, KNOCK!" There's somebody at the door.
    *   CUE:Choose an action
    *   [Hide in a cupboard]
        #PLAYER:mood:contented
        - -(cupboard)
        It's full of pots and pans which clatter about as you try to squeeze in.
        You give up and shut the cupboard.
        "KNOCK, KNOCK"
        A voice you know calls through the door,
        Alisha: I can hear you in there you know!
        * * [Open the door]
            The gig is up so you <>
    *   [Shout 'Go away']
        #PLAYER:mood:sad
        You shout through the door,
        You:Go away! There's nobody home.
        A voice you recognise shouts back,
        Alisha:So who's that talking? Open up, noob!
        * * [Open the door]
            You <>
    *   [Answer the door]
        You <>
    -
    #ARRIVE:alisha:378:650:happy
    #PLAYER:mood:happy
    open the door. It's your friend Alisha. She gives you a big grin.
    Alisha: Hello {~dude|doodlie|doodlington}! How're you? {cupboard: What was all the racket?}
    Alisha: I had an epic game of {~Crossy Street|Clash of Grans|Call of Doodie|Footy 2018|MintCraft|Octomum} last night, you should've seen it! I should start my own YouTube channel.
    She's really into gaming.
    *   [Great, I was doing a jigsaw]
        #PLAYER:mood:contented
        You: I was doing a 2000 piece map of the world jigsaw.
        Alisha laughs.
        Alisha: Neat, but you have some funny ideas about fun.
    *   [Cool, I was reading my comics]
        #PLAYER:mood:contented
        You: I was reading the new Fiona and Cake Adventures comic.
        Alisha: Adventure Time? Man, I have to get into those as well. I love the TV show.
    -
    Alisha pauses, looks at you and says,
    Alisha: So, I've been talking to this really cool boy. Met him on XBox Live and we've added each other on Snapchat.
    -(kitchen_chat)
    *   CUE: How will you respond?
    *   {!first_loop} [XBox is for losers.]
        #FRAME:alisha:contented
        #PLAYER:mood:happy
        In a snooty voice you say,
        You: XBox?! I think you'll find Playstation is superior.
        Alisha gives you a funny look then laughs.
        Alisha: Whuu? You doofus!
        Alisha: This boy though, I really like him - he's cool and funny!
    *   [How old is he?]
        #FRAME:alisha:contented
        #PLAYER:mood:contented
        You: So how old did he say he is?
        Alisha: He's 12 and he lives about 10 miles away.
        * * [Believe]
            #FRAME:alisha:happy
            You: Oh cool, just a bit older than us!
            Alisha: Yes! Neat huh!
        * * [Don't believe]
            #FRAME:alisha:sad
            You: Ha! That's what he says online anyway. He could be anyone.
            Alisha: Listen, I've been hanging out online with this dude a lot. He's legit.
    *   [Do you know him in real life?]
        #FRAME:alisha:contented
        You: Is he from school or something?
        Alisha: No, he goes to a different school but that doesn't matter. He's called Kafe.
        Alisha looks a little embarrassed, then she says,
        Alisha: He sent me a picture, he looks really cute. I've sent him a picture of me too. We're going to meet up.
        * * [Well, okay. Have a brilliant time.]
            #FRAME:alisha:happy
            #PLAYER:mood:happy
            You: Go for it! You only live once!
            Alisha: Thanks dude! You're always so positive!
            * * * [No problem!]
                -> advice_meetup ->
                -> end_chat
        * * [I'll come too if you like.]
            #FRAME:alisha:whistling
            #PLAYER:mood:happy
            You: Oh exciting! Can I come too?
            Alisha: Sorry, we've agreed to meet alone.
            * * *   [Oh OK, whatever.]
                    #PLAYER:mood:contented
                    #FRAME:alisha:happy
                    You:  Fine then, you go for it!
                    Alisha: Ha! You're a good friend.
                    She gives you a friendly shove.
            - - -
            * * *   [Continue]
                    -> advice_meetup ->
                    -> end_chat
        * * [Hmm, are you sure?]
            #PLAYER:mood:contented
            #FRAME:alisha:sad
            You: But you don't know if he is really who he says he is. I wouldn't meet him.
            Alisha: Oh, I suppose you're right but part of me wants to believe.
            MSG_POS: You've given good advice. You should never share personal information, personal images or passwords.
            MSG_POS: Always think about what you post online and who might be able to see it.
            {score_points(2)}
            ~ goals += online_safety
            -> end_chat
-   (first_loop)
    -> kitchen_chat

-   (end_chat)
    #FRAME:alisha:contented
    #PLAYER:mood:contented
    Alisha: Well, I've got some errands to run so I've got to go now. I'll remember what you said.
    Alisha: I'll be at the park later so maybe see you there?
    *   [Sure, see ya!]
    *   [Catch you later then!]
    *   [Stay safe]
    -
    #DEPART:alisha
    #PLAYER:mood:hurt
    Alone again, but wait ...
    What's that funny smell? It smells horrible, a bit like bad eggs.
    You know it's not your little brother this time because he's gone out with Mum!
    -   (gas_smell)
    {Wow! It smells worse than your socks after PE.|What a pong and it's getting stronger!|Is that a hiss coming from behind the cooker?}
    * [Check the cooker]
        It smells stronger here.
        You quickly check the cooker's controls. They're all turned off.
        It must be a gas leak!
        -> gas_action
    * [Check the kettle]
        Nope, it's not coming from the kettle.
    * [Check the radio]
        Nope, it's not coming from the radio.
    - ->gas_smell
    - (gas_action)
    *   CUE:What are you going to do?
    *   [Switch the light on]
        #BOOM
        BOOM! An electrical spark lit the gas leaking from the cooker.
        You died.
        MSG_NEG: Well done, you've found the ONLY way to die in this game! No points for that though.
        -> advice_gas ->
        -> game_over
    *   [Call emergency services]
        On second thoughts, maybe doing that here isn't such a great idea.
        This is a very dangerous situation.
        -> gas_action
    *   [Open the window]
        #PLAYER:mood:contented
        You open the window and fresh air from outside starts blowing in.
        MSG_POS: Yes, if it's safe to do so, opening a door or window is a good move.
        - -(opened_window)
        {score_points(1)}
        -> gas_action
    *   [Run outside]
        -> garden

=== garden ===
    ~ location = garden_

    VAR dad_called = ""

    #PLAYER:pos:120:750
    Phew! Safely outside!
    {score_points(2)}
    But where's Dad? He's supposed to be out here somewhere.
    *   [Shout DAAAD!!]
        #ARRIVE:dad:650:750:happy
        Dad runs up from to bottom of the garden.
        Dad: Hello, what's up?
    -
    * [Tell dad about the smell of gas]

-   (start)
    #FRAME:dad:shocked
    #PLAYER:mood:contented
    You: Dad, I can smell gas in the kitchen! {kitchen.opened_window: I've opened a window.}
    Dad: { kitchen.opened_window:
            Good job!
            - else:
            Oh no!
         } <> This is an emergency, but who do I call?
    He looks at his phone, unsure what to do.
    *   [Call { PHONE_EMERGENCY}]
        #FRAME:dad:happy
        You: Dad, just call {PHONE_EMERGENCY}!
        Dad: Are you sure? Oh well, okay.
        ~ dad_called = contacts.emergency_services
    *   [Call {PHONE_GAS_EMERGENCY}]
        #FRAME:dad:happy
        #PLAYER:mood:happy
        You: Dad, you should call {PHONE_GAS_EMERGENCY} in a gas emergency.
        Dad: Brilliant! How did you know that?
        ~ goals += phone_gas
        ~ dad_called = contacts.gas_emergency
        * * [Dad, I've been to Crucial Crew!]
            You: Dad, how do you NOT KNOW? I've been to Crucial Crew!
    *   [Call Mum]
        #FRAME:dad:happy
        You: Maybe you should call Mum?
        Dad: Mum is brilliant, but last time I looked she was a civil engineer, <>
        not a gas engineer. Oh well ...
        ~ dad_called = contacts.mum
    -
        #PLAYER:mood:contented
        Suddenly you remember something else.
    *   CUE: Tell Dad to:
    *   [Turn off the gas supply]
        You: Oh Dad! I just remembered, we should turn off the gas supply <>
        at the gas meter as well!
        {score_points(1)}
        Dad: That make sense, I'll do it.
    *   [Turn off the electricity supply]
        You: I think we should turn off the electricity supply.
        Dad: Hmm, I'm not sure about that, it might spark and cause an explosion <>
        but you've given me an idea - I'll turn off the gas supply at the meter.
    *   [Turn off the water supply]
        You: I think we should turn off the water supply.
        Dad: Hmm, I'm not sure that will help <>
        but it gives me an idea - I'll turn off the gas supply at the meter.
    -
        #PLAYER:mood:contented
        Dad: Hmm, how do I know when the gas supply is off?
    *   [Valve handle in line with the pipe]
        You: I think it's off when the handle is inline with the pipe.
        Dad: Righto!
    *   [Valve handle at 90 degrees to the pipe]
        #PLAYER:mood:happy
        You: It's off when the handle is sticking out at 90 degrees from the pipe.
        Dad: Good stuff!
        {score_points(1)}
    -
    *   [Continue]
        # DEPART:dad
        #PLAYER:mood:happy
        Dad dials <>
        {dad_called ? contacts.gas_emergency:{PHONE_GAS_EMERGENCY} <>}
        {dad_called ? contacts.mum:Mum <>}
        {dad_called ? contacts.emergency_services:{PHONE_EMERGENCY} <>}
        and heads off to turn the gas off at the meter.
        {dad_called ? contacts.gas_emergency: {score_points(2)}}
    -
    *   [Chill]
        You start chillin' or chilling, or relaxing; whatever's your thing.
        Suddenly ...
    *   [Take a breath]
        You take a deep breath, and slowly let it out. Busy morning already.
        Wait a glob darn minute ...
    *   [Let one go]
        You look around, no one is about so ... you let a big one go.
        Phew! You wave it away. Maybe too much gas this morning.
        Hang on ...

-   (garden_search)
        #PLAYER:mood:hurt
        {~You sense there's something wrong|Your spidey sense is tingling|You have a bad feeling about this|You feel somethings not right, if only you could PUT YOUR FINGER ON IT}.
    *   CUE:Find the hidden danger in the picture
    +   [SPRITE:light]
        #ARRIVE:dad:500:750:happy
        Yep, that light is broken and dangerous!
        Dad returns.
        Dad: <>
        { dad_called ? contacts.emergency_services: Apparently I should have called the Gas Emergency Number {PHONE_GAS_EMERGENCY}. Anyway, }<>
        { dad_called ? contacts.gas_emergency:  That number was perfect, }<>
        { dad_called ? contacts.mum: I don't think Mum was impressed. I've called the Gas Emergency Number {PHONE_GAS_EMERGENCY} and }<>
        a gas crew are on their way!
        - - (brokenlamp)
        * *     [Tell Dad about the broken light]
                #PLAYER:mood:contented
                You: Dad this light looks really dangerous. I can see the metal of the wires.
                Dad: Good grief! Well spotted, you're on fire today! I'll fix that after the Gas Emergency Team has finished.
                MSG_POS: Good move. Never touch loose wires, sockets or switches.
                {score_points(1)}
                * * *   [I don't feel safe here]
                        -> garden.end
        * *     [Pull a wire]
                You go over and give the wire a good tug to see if it's safe.
                It isn't.
                Zap! You just got an electric shock.
                Dad: You mellonhead! What did you do that for?
                * * *   [I just wanted to see]
                        You: I just wanted to see what would happen.
                        Dad: Well, I expect that hurt. You're lucky you're not dead! Are you okay?!
                        Dad checks you over and gives you a hug.
                        * * * * [Continue]
                * * *   [I wasn't sure it was broken]
                        You: I wasn't sure it was broken.
                        Dad: Well it is. Are you okay?!
                        * * * * [Continue]
                * * *   [YOLO]
                        You: You only live once Dad!
                        Dad: That's so true, but carry on like that and you'll miss MOST of it!
                        * * * * [Continue]
                - - -   // MSG_NEG: Loose wires can be very dangerous. Tell an adult.
                        -> garden.end
        * *     [Dive for cover]
                #FRAME:dad:happy
                You leap behind a bush.
                You: Take cover Dad! This thing could blow!
                MSG_NEG: Loose wires won't blow up but they could give you an electric shock or cause a fire.
                Dad gives you a funny look and laughs 
                Dad: What ARE you doing, you whackbrain?!
        - -     -> brokenlamp
    +   [SPRITE:ball]
        That's just a football <>
        {, still, you thought you'd put that away|. Hmm, better not play right now |and you've already checked it out}.
    +   [SPRITE:bbq]
        That's Dad's barbecue. <>
        {The sausages smell good|It is a bit smokey but not dangerous|It's fine, Dad's looking after it}.
    +   [SPRITE:hose]
        That's the garden hose. <>
        {It's a bit leaky but not dangerous|You're pretty sure it's not a killer hose.| It's fine.}
-   -> garden_search
-   (end)
    #PLAYER:mood:contented
    MSG_NEG: When you are out playing, never go near electrical wires, pylons or substations. Stay safe and stay away.
    You: I think I'll head to the park for a bit Dad.
    Dad: Good idea. It IS getting a bit dangerous around here!
    *   [Walk to the street]
        #DEPART:dad
-    -> street


=== street ===
LIST crossing_state = lit, (unlit)

~ location = street_

    - (wrong_side_of_road)
    #PLAYER:pos:250:700
    You're on the street outside your house but you need to cross the road if you're going to get to the park.
    There's a lot of traffic on the road.
    * {railway.watch_kid}{goals !? saved_bernie} [Find a police officer]
        #ARRIVE:officer:450:700:neutral
        You look for a police officer.
        -> save_bernie ->

        - - -> wrong_side_of_road
    * {!rtc_quiz.pelican_crossing_known}[Stop, Look and Listen]
        #PLAYER:pos:250:700:contented:rev
        #ARRIVE:officer:450:700:neutral
        You stop look and listen at the side of the road. But, boy! This is a BUSY road...
        There's no chance of crossing here without getting splatted and ending up like strawberry jam.
        Officer: Hello, having trouble?
        You: I'm trying to cross but it so busy today!
        -> rtc_quiz ->
        - -
        * * [Say goodbye]
            #DEPART:officer
             -> wrong_side_of_road
    * {!rtc_quiz.pelican_crossing_known}[{Run madly across the road|Go for it}]
        Alright, lets do this! Crossy Road for reals!
        You take deep breaths,bounce and shake your arms out just like an athlete warming up for the 100 meters.
        * * [Look for a big gap]
        * * [Look for a medium gap]
        * * [Look for a little gap]
        - -
        #ARRIVE:officer:450:700:neutral
        Suddenly you hear a very loud cough behind you and a voice speaks.
        It's a police officer.
        Officer: I hope you aren't about to do something dumb.
        * * [Yes, I was]
            #FRAME:officer:worried
            You: I'm in a hurry to cross and I'm good at video games so I thought I'd go for it.
            The police officer gives you an astonished look.
            Officer: You know, there are no extra lives in real life and some really dumb ways to die ...
        * * [No, I wasn't]
            #FRAME:officer:happy
            You: No, no of course not. I was just warming up for my Park Run. I know how to cross the road!
            Officer: Hmm ok, it just looked as if you were about to hurl yourself into the traffic.
        - -
        -> rtc_quiz ->
        - -
        * * {railway.watch_kid}{goals !? saved_bernie}[Tell about Bernie]
            -> save_bernie ->
            - - - -> wrong_side_of_road

        * * [Continue]
            Officer: Listen, my name is Paula. I'll be around if you need me for anything.
            You: Thanks
        - -
        * * [Wave goodbye]
            #DEPART:officer
        - - -> wrong_side_of_road
    * {rtc_quiz.pelican_crossing_known}[Walk up to the pelican crossing]
        -> street_crossing

    +  {!railway.watch_kid} [Crawl through the hole in the hedge]
        You push your way through the hole in the hedge. When you come out ...
        -> railway


=== rtc_quiz ===
    #FRAME:officer:happy
    Officer: Well, I suggest you use the pelican crossing just over there.
    She points to the crossing just up the street.
    -(pelican_crossing_known)
    * [Yes of course]
    You: Oh, yes of course. I'm just being lazy.
    -
    Officer: Since we're talking, if you ever did see someone get run over, who would you call?
    *   [I'd call {PHONE_EMERGENCY}]
        #FRAME:officer:happy
        Officer: Good! Or, you could also call {PHONE_EMERGENCY_EU}. It works just the same but also works in Europe AND the rest of the world if you use a mobile phone. How cool is that?
        {score_points(1)}
    *   [I'd call {PHONE_EMERGENCY_EU}]
        #FRAME:officer:happy
        Officer: Good, that works exactly the same as {PHONE_EMERGENCY}
        {score_points(1)}
    *   [I'd call {PHONE_GAS_EMERGENCY}]
        #FRAME:officer:neutral
        Officer: Isn't that for gas emergencies? I wouldn't have throught that would help.
        You should dial {PHONE_EMERGENCY} or {PHONE_EMERGENCY_EU}. Either works but {PHONE_EMERGENCY_EU} works in Europe and the rest of the world as well!
    *   [I'd call {PHONE_NON_EMERGENCY_POLICE}]
        Officer: That's the non emergency number for the police. You probably want to dial {PHONE_EMERGENCY}.
    -
    #FRAME:officer:neutral
    Officer: {And|So} which service would you ask for first?
    *   [Police]
        You: I'd ask for the police.
        Officer: Maybe, but that's not the first service you should ask for. You really want an Ambulance.
    *   [Ambulance]
        #FRAME:officer:happy
        You: I'd ask for an ambulance.
        Officer: Good, right answer! They might send the police and even a fire crew as well but that should be your first choice - well done.
        {score_points(1)}
    *   [Fire Service]
        You: I'd ask for the fire service.
        Officer:  Hmm no, not at first. The fire service might be needed but there's a better choice. You really want an Ambulance.
-   ->->


=== street_crossing
~ location = street_crossing_
    - (pelican_crossing)
    #PLAYER:pos:400:700
    You're stood at the pelican crossing.
    The WAIT light is <>
    { crossing_state ? lit:
        ON!
    - else:
         {button_pressed:still{button_pressed_hard:, unbelievably}} off.
    }
    *   [Press the button]
        Hmm, nothing happens ... is it broken?
        - - (button_pressed)
            -> pelican_crossing
    *   {button_pressed}[Press the button HARD]
        You press the button HARD.
        Nothing happens ... HARDER.
        - - (button_pressed_hard)
            -> pelican_crossing
    *   {button_pressed_hard}[Press the button VERY RAPIDLY]
        You furiously jab the button again and again as fast as you can...
        DAKA-DAKA-DAKA-DAKA!
        WOAH! That did it!
        ~ crossing_state = lit
        -> pelican_crossing
    +   [Wait]
        { crossing_state ? unlit:
            You wait ...
            Heavy traffic rolls by ...
            -> pelican_crossing
        }
        { crossing_state ? lit:
            The lights change and the traffic stops.
            Some other people are crossing the road, including your teacher Mrs Bottomly. She smiles at you as you pass each other on the crossing.
            -> right_side_of_road
        }

    +   [{&Look|Listen|Hold up your hand|Wave|Shout|Look angry|Wave your fist} and step out]
        #HORN
        A {&car|van|lorry|taxi|motorcycle|monster truck|grizzly bear|Death Monkey(tm)} nearly runs you over.
        You step back to safely. Phew.
        -> pelican_crossing
    - -> park

-   (right_side_of_road)
    You're on the street outside Princely Park.
    {goals !? saved_bernie:Police officer Paula smiles and waves at you from the other side.}
    {score_points(1)}
    *   [Head into the park]
        -> park

=== railway
~ location = railway_
    #PLAYER:pos:500:750:contented:rev
    You're by the side of the train track. There's a hole in the hedge back the way you came.
    Bernie is here but he hasn't seen you. What's he doing?
    *   [Talk to Bernie]
        You: Hey, Bernie!
        Bernie looks over at you and hisses
        Bernie: Go away!
        * * [You shouldn't be here]
            You: Bernie! You shouldn't be here.
            Bernie: And neither should you so go away!
            -> watch_kid
        * * [Watcha doin?]
            You: Hey Bernie! What are you doing?
            Bernie: Nothing for nosey parkers! This is my biz. Go AWAY!
            -> watch_kid
    +   [Watch Bernie]
        Bernie is crouching behind a bush a little way from the side of the track. He looks around nervously.
        * * [Sneak closer for a better look]
            You sneak closer.
    -   (watch_kid)
        #REMOVE:bernie_hiding
        #ADD:bernie_daring
        {As you watch|Again,|Once more,} Bernie runs up to the railway track.
    +   [Watch]
        You wait.
        Bernie waits.
        The tracks begin to hum. A{|nother} train is coming.
    -
    +   [Wait]
        #TRAIN
        The humming gets louder, you can't see what Bernie sees but he suddenly dives back behind the bush...
        and then suddenly the train is whooshing by.
        It's speed surprises you and you feel a little shaken.
        Bernie: {Yesss!|Nice!|Heh!} Hahaha!
    -
    +   [Watch]
        #REMOVE:bernie_daring
        #ADD:bernie_hiding
        Bernie punches the air and then he hides behind the bush again.
        MSG_NEG: Playing on railway lines or crossings is extremely dangerous.
    -
    +   [Continue watching]
        -> watch_kid
    +   [Crawl back through the hedge]
        -> street


=== park
~ location = park_
LIST park_state = seen_window, seen_bin, seen_dog, seen_bbq

LIST calls_made = called_window, called_bin

    #PLAYER:pos:160:750
    You're in Princely Park. On the other side of the park, outside the far gates you can see the river.
    You wonder if Alisha will turn up soon. She said she'd be here.
    *   [Look for Alisha]
        You look around for Alisha but you can't see her
        Hang on though, something's not right here ...
    -   (fire_watch)
        {calls_made ? (called_window, called_bin):
            -> services_arrive
        }

    *   CUE: {inventory !? phone:
            Search the scene <>
            {park_state !? (seen_window, seen_bin):
                for dangers.
            -else:
                for something to help.
            }
        -else:
            {park_state !? (seen_window, seen_bin):
                Look for dangers.
            -else:
                Make an emergency call.
            }
        }
        
    +   [SPRITE:litter]
        {&That's a piece of litter someone hasn't put in the bin|It's litter, if the bin wasn't smoking you could dispose of it properly}.
    +   [SPRITE:bbq]
        {&That's a barbecue, a bit smokey|Smelly, in a good way.|You wonder who's gonna eat those sausages.}
        ~ park_state += seen_bbq
    *   [SPRITE:phone]
        #REMOVE:phone
        Someone has lost their mobile phone.
        There's no one around, so you pick it up. It needs handing in to the police.
        ~ inventory += phone
        {score_points(1)}
    *   [SPRITE:smoke]
        There's smoke coming from that window!
        ~ park_state += seen_window
        {inventory !? phone:
            If only you had your phone with you!
        }
    *   [SPRITE:bin]
        There's smoke coming from the bin!
        ~ park_state += seen_bin
    +   [SPRITE:dog]
        {&There's a dog roaming about about the park. You can't see the owner.|The dog is rolling in something.|The dog starts chasing it's tail}
        ~ park_state += seen_dog
    +   {inventory ? (phone) } {calls_made !? (called_window, called_bin)}
        [Use the lost phone]
        {LIST_COUNT(calls_made) == 0:
            Yes! You remember that you can call emergency services from any mobile phone, even if it's locked.
            MSG_POS: Remember to stay calm and tell the operator what you can see and hear.
        - else:
            Time for another emergency call!
        }
        * * CUE: What will you call about {LIST_COUNT(calls_made) == 0:
                first
                -else:
                next
            }?
        * * (bin){park_state ? (seen_bin)}
            [Call about the bin]
            You activate the phone, a fire in the park is an emergency after all.
            -> emergency_call ->
            -> emergency_exposition ->
            * * * [Hang up]
                ~ calls_made += called_bin
                {score_points(1)}
        * * (window){park_state ? (seen_window)}
            [Call about the smoky window]
            You activate the phone, smoke coming from a window is an emergency for sure.
            -> emergency_call ->
            -> emergency_exposition ->
            * * * [Hang up]
                {calls_made ? (called_bin):
                    You can't help feeling that maybe the house fire is a bigger emergency than the bin.
                    {score_points(1)}
                - else:
                    MSG_POS: Well done, a house fire is a very serious situation indeed!
                    {score_points(4)}
                    ~goals += house_fire_first
                }
                ~ calls_made += called_window
        * * {park_state ? seen_dog}
            [Call about loose dog]
            You look again, the dog is rolling about and having fun. Maybe that isn't an emergency after all.
            MSG_NEG: If it's not an emergency do not call the emergency services.
        * * {park_state ? seen_bbq}
            [Call about the barbecue]
            You have a feeling that phoning the emergency services about an unattended barbecue might not be right move.
            MSG_NEG: Something might be breaking the rules or even the law but do not call the emergency services unless it is an emergency.
        + + [Call {&Mum|Dad|Alisha|Nan|Mrs Bottomly|Spiderman}]
            You can't unlock the phone and anyway that would be wrong ... right?
        - - ->fire_watch
    *   {inventory !? phone}{park_state ? seen_window}
        [Look for help]
        There's no one else around! It's up to you!
    - ->fire_watch

    - (services_arrive)
    #ARRIVE:firefighter:500:700:neutral
    #ADD:fire_engine
    #ADD:water
    You hear the sound of sirens. The Fire service arrives, responding to your calls.
    In the distance the engine begins spraying water into the window.
    Firefighter: Stand back, kiddo! We'll get this fixed.

    *   [Stand back]
    -
        #REMOVE:bin_smoke
        #FRAME:firefighter:happy
        You watch as the firefighter puts the bin fire out.
        Firefighter: Are you the kid who called about the house fire as well?
    *   [Yes, that was me]
        You: Yes, I did. Do you know if anyone has been hurt?
        Firefighter: No, no one was hurt. Apparently it started from an overloaded electrical socket.
        Firefighter: Sometimes people use too many power plug adapters and it overloads the supply, gets hot and catches fire.
        Firefighter: Anyway, well done you. Nice job! These fires are under control. Goodbye!
    -
    *   [Bye!]
        #DEPART:firefighter
        #ARRIVE:officer:500:720:neutral
        You: Bye!
        Officer: Hello again! You're having a busy day.
        Officer: I don't suppose you saw how this bin caught fire did you?
    -
    *   [No, sorry]
        #FRAME:officer:happy
        You: No sorry I just got here and it was already on fire.
        You: But I did find this phone on that bench. Maybe the person who owns it knows something?
        You hand the lost phone over to Officer Paula.
        ~inventory -= phone
        Officer: Thanks! I'll take this to the station, maybe someone will report it missing.
        Officer: Hopefully I won't see you again today!
    -
    *   [Bye!]
        #DEPART:officer
        You: Bye!
    -
    * [Head down to the river]
        -> river


=== emergency_exposition ===
    {second_call:
        It's a similar call to the one you made a moment ago - WHAT A DAY!
    - else:
        The operator asks for the address of the emergency and asks for the number of the phone you're calling from.
        They ask if you or anyone else is in danger. They have more questions that you had expected but you answer as best you can.
        MSG_POS: Emergency services will be sent straight away, it's important to keep an cool head and answer the operator's questions as clearly as you can.
    }
    - (second_call)
    - ->->

=== emergency_call ===
    -(start)

    +   [Dial {PHONE_EMERGENCY}]
        You call the UK emergency number. It rings ...
    +   [Dial {PHONE_EMERGENCY_EU}]
        You call the international emergency number. It rings ...
    +   [Dial {PHONE_GAS_EMERGENCY}]
        No, not for this situation.
        Try again.
        -> start
    +   [Dial {PHONE_NON_EMERGENCY_POLICE}]
        That's the non emergency number, not really suitable for this situation.
        Try again.
        -> start
    - ->->


=== river
~ location = river_
~bottle_state = full
    #PLAYER:pos:700:750:contented:rev
    You're by the river, no sign of Alisha here either.
    {goals !? online_safety:
        You start to worry that maybe the advice you gave Alisha wasn't very good after all.
    - else:
        You're not too worried though, she'll won't have done anything stupid after your chat.
    }
    *   [Look around for Alisha]
        You look around but there's no sign of Alisha...
    *   [Watch the ducks]
        You watch the ducks for a bit thinking about the stale bread you could've brought for them.
        But didn't someone say bread was bad for ducks, oh, well. Don't have any anyway.
    -   (swimmer)
        There's someone in the water!
    +   [CUE:Tap them to see if they're okay.]
    +   [SPRITE:ducks]
        Not them! They look happy enough. They're definitely not {&drowning|caught in the undertow|biting one another}.
        -> swimmer
    *   [SPRITE:swimmer_danger]
        #PLAYER:mood:hurt
        That person is upright in the water, isn't shouting or waving for help but their head is low in the water.
        As you watch, their head goes quietly under the water before coming back up again.
        It's happening again and it doesn't look like they've had time to breathe properly.
        MSG_POS:Perhaps surprisingly, these are the REAL signs of someone DROWNING. Not like the movies. <>
        People who are drowning usually cannot speak or shout - they're quiet.
        * * [Continue]
        You saw a life buoy further up the river bank but it'd take too long to go and fetch it. <>
        You need to help NOW!
    -
    *   CUE: How do you want to do this?
    *   [Swim out and rescue]
        You look uncertainly at the cold, dark water.
        * * [Check the freezing water temperature?]
        * * [Check the dangerously strong currents?]
        * * [Check the spiky underwater obstacles?]
        * * [Check the speeding boats?]
        * * [Check the pollution levels?]
        - -
        You suddenly realise that entering the water would be a terrible mistake!
        MSG_NEG: It's incredibly dangerous to swim in wild water.
    *   [Look for something on the river bank]
        MSG_POS: Good move! Remember, "Reach, Throw, Don't Go!"
        {score_points(1)}
    -   (rescue)
        #PLAYER:mood:contented
    +   {inventory !? (bottle)}[CUE:Look for something {|else} to help.]
    *   [SPRITE:bottle]
        #REMOVE:bottle
        You pick up a plastic bottle. It's big but it's full of water.
        ~ inventory += bottle
    *   [SPRITE:stick]
        #REMOVE:stick
        You pick up a stick. Hmm, hefty, but not long enough to reach the swimmer.
        ~ inventory += stick
    *   [SPRITE:tincan]
        #REMOVE:tincan
        You pick up an empty tin can.
        ~ inventory += empty_can
    *   {inventory ? bottle}{bottle_state == full}
        [Use the bottle of water]
        It's full of liquid and has the top screwed on.
        What do you want to do with it?
        * * [Throw it]
            You throw it to the drowning swimmer.
            It sails through the air,
            right towards the swimmer, splashes down
            ...
            and immediately sinks from view.
            ~ inventory -= bottle
        * * [Pour out the water]
            You unscrew the top and start pouring out the liquid.
            * * *   [Pour it all out]
                    You squeeze the bottle to squirt all the liquid out as fast as possible.
                    It's nice and light now.
                    ~ bottle_state = empty
            * * *   [Pour out most of it]
                    You carefully squeeze the bottle to squirt most of the liquid out but take care to keep some back.
                    It lighter and good for throwing now.
                    {score_points(1)}
                    ~ bottle_state = nearly_empty

    *   {inventory ? bottle}{bottle_state == empty}
        [Throw the empty bottle]
        You throw the empty bottle towards the swimmer.
        But it's so light now that it doesn't go as far enough and the wind blows it off course.
    *   {inventory ? bottle}{bottle_state == nearly_empty}
        [Throw the perfectly weighted bottle]
        You throw the bottle towards the swimmer.
        The bit of liquid inside provides just enough weight and the bottle sails right over to the drowning swimmer.
        MSG_POS: Good job! A little liquid in a container will help you throw it accurately.
        {score_points(1)}
        * * [Continue]
        - - -> swimmer_assisted

    +   {inventory ? stick}
        [Use the stick]
        What do you want to do with the stick?
        * * [Reach out with it]
            It's not long enough, if they were closer this'd be a great tool.
        * * [Throw it]
            You swing the stick back an lob it high towards the drowning swimmer.
            ~ inventory -= stick
            {score_points(1)}
            -> swimmer_assisted

    *   {inventory ? empty_can}
        [Use the tin can]
        What do you want to do with it?
        * * [Throw it]
            You throw it towards the drowning swimmer.
            It sails feebly through the air then lands with a plop on the surface of the water.
            No good! You need to think of something else.
            ~inventory -= empty_can
        * * [Throw it away]
            Yeah, it's not going to be much use. You throw it away.
            ~inventory -= empty_can
    -
    -> rescue

    - (swimmer_assisted)
    #REMOVE:swimmer_danger
    #ADD:swimmer_floating
    The swimmer {grabs it and hugs it, using it as a float. Looks like you've bought them some time.| is starting to struggle, looks like time is running out.| is really struggling again.}
        You see someone on the other side with a phone in their hand.
    * CUE:You shout out to them:
    * [Call an ambulance!]
    * [Call the police!]
    * [Call the fire service!]
        MSG_POS: Yes, that's right. For river emergencies you need the Fire Service.
        MSG_POS: There won't always be a rescue boat, it depends where you are but the operator will always help.
    -
        The person stops, sees the swimmer and starts dialling.
        You can see them talking on the phone. They give you a thumbs up.
        * * [Continue]
        -> river_rescue
    - (river_rescue)
    ~goals += saved_swimmer
    #ARRIVE:firefighter:200:750:neutral
    #REMOVE:swimmer_floating
    #ARRIVE:swimmer:370:750:happy
    The swimmer holds on, using the float you provided and a <>
    few minutes later you hear the roar of a speedboat engine. <>
    It's a rescue boat!
    They fish the swimmer out of the river and bring them to safety.
    * [Continue]
    -
    Firefighter: You were lucky this kid was passing! Most people don't recognise the REAL signs of someone drowning.
    * [It was nothing]
    * [It took all my cunning]
    * [It took all my strength]
    -
    #PLAYER:mood:happy
    You: Yeah, I mean. I don't want to boast but I'm smashing it today!
    Swimmer: It was so cold I got tired really quickly. That never happens at the swimming pool! I just couldn't keep my head about water. Oh it was horrible.
    * [There might be hidden dangers]
      You: Plus, you never know what's under the surface in a river - could be shopping trolley, bikes, all sorts!
    * [There can be strong currents]
      You: Plus, there can be strong currents that'll drag you under.
    -
    Swimmer: Oh my gosh, I hadn't thought of that! I'm going to stick to the swimming pool from now on!
    Firefighter: Come on then, better get you checked out at hospital.
    * [Continue]
    -
    #DEPART:firefighter
    #DEPART:swimmer
    #PLAYER:mood:contented
    The firefighter escorts the swimmer away to an awaiting ambulance.
    The swimmer calls back,
    Swimmer: Thank you! You saved my life!
    -
    * [Look for Alisha in the park]
        -> park_bully


=== park_bully
~ location = park_bully_

    #PLAYER:pos:150:750:contented
    You head back to the park. The fires are out and everything looks fine.
    *   [Look for Alisha]
        #ARRIVE:alisha:378:690:contented
        Oh! Here comes Alisha now.
        Alisha: Hi dude!
        You: Hi dude!
        {goals !? online_safety:
            You're relieved to have found Alisha as last.
        - else:
            Alisha is so cool, you're glad that you're friends.
        }
    -
    *   {goals !? (online_safety)}
        [Did you meet Kafe yet?]
        #FRAME:alisha:happy
        You: Did you meet that boy Kafe in real life yet?
        Alisha: Not yet. I'm going to see him later on.
        * * [Sure I can't come?]
            #PLAYER:mood:happy
            You: Okay, I hope he's cool. Wish I could come too.
            Alisha: Like I said, he want's to meet alone.
            - - -
            * * * [Continue]
        * * [Alisha, don't go.]
            #FRAME:alisha:sad
            You: Alisha, I've changed my mind. I don't think you should meet him.
            Alisha: Why, are you jealous?
            * * * [No.]
            * * * [A little]
            * * * [Yes, totally!]
            - - -
                  #FRAME:alisha:happy
                  You: I think it might be dangerous. I mean, what do you REALLY know about him?
                  Alisha: Well, he ...
                  Alisha: Come to think of it, not much really ...
                  You: Right.
                  Alisha: You know, I've changed my mind too. I'm not going.
                  ~ goals += online_safety
            * * * [I'm relieved to hear it]
                  You: Okay, I'm pretty happy about that. I was worried for a while there.
            - - -
            * * * [Continue]
    *   {goals ? (online_safety)}
        [You're not going to meet that boy, Kafe?]
        #FRAME:alisha:sad
        You: I'm glad you decided not to meet that boy from online.
        Alisha: Yeah, that would've been a pretty dumb move. Although I was excited for a while.
        You: You can still chat online, just don't give him any personal info.
    - (jenemica_arrives)
    #ARRIVE:jenemica:570:710:mean
    Suddenly you hear a shout,
    Jenemica: Yo, {~losers|buttfaces|foopfaces|jerps|drips|stinkers|weirdos}!
    It's Jenemica from school.
    *   [Continue]
    -
    #ANIMATE:jenemica:blowing_bubble
    #FRAME:alisha:sad
    Alisha: Hi Jenemica, how're you doing?
    Jenemica: Pretty good.
    She smirks.
    Jenemica: And err, how're you doing Alisha? Got a boyfriend yet?
    Alisha looks uncomfortable, she can't think what to say.
    *   [What's that supposed to mean?]
        #FRAME:jenemica:mean
        You: What's that supposed to mean, Jenemica? Just 'cos you're going out with Dustin now, you think you're better?
        Jenemica:Nope, just heard she was desperate.
    *   [Alisha doesn't need a boyfriend]
        #FRAM:jenemica:mean
        You: She doesn't need a boyfriend to be happy. She's cool as she is.
        Jenemica: Ha, well, that's not what I heard.
    -
    * [Continue]
    
    #FRAME:alisha:sad:rev
    Alisha: You don't know anything Jenemica.
    Jenemica: Oh really? I heard you were talking to a guy called Kafe online.
    Alisha: Whu... how did you know about that Jenemica?!
    You: Yeah, how DID you know about that?
    -
    * [Continue]
    #FRAME:alisha:sad
    A mean look comes over Jenemica's face.
    Jenemica: I heard you sent him a photo as well.
    Alisha looks crestfallen.
    -
    * [Continue]
    #ANIMATE:jenemica:blowing_bubble
    #PLAYER:mood:sad
    It looks as though Jenemica is enjoying being horrible to Alisha.
    Jenemica: In fact, I think I have it here on my phone.
    Alisha looks horrified.
    Alisha: WHAT?!!
    You: WHAT?!!
    She takes her phone out and starts up an app. Then she holds it out for Alisha to see.
    -
    * [Continue]
    -
    #FRAME:jenemica:pointing
    Jenemica: Yeah, you see,
    Jenemica: ...
    Jenemica: Kafe isn't real! Me, Tulisa and Tara made him up and you fell for it! HAHAHA!
    Alisha: but ...
    * [You're the worst]
        You: Jememica, you are the worst person I know! Just horrible. Why would you do that?
        Jenemica: For fun against you freaks!
    * [You're a bully]
        You: Jemenica, you know you're a bully right? I feel sorry for you, something must be really wrong in your life for you to act this way.
        Jenemica looks unsettled for a moment but then says,
        Jenemica: I don't care what you think.
        {score_points(1)}
    * [Punch Jenemica]
        You: I'm so angry with you right now. I'm going to knock your block off.
        You step made a fist and step towards Jenemica.
        Alisha: No! Don't do it, you'll make it worse.
        You feel the anger like a sick knot in your stomach, you're shaking, but you hold it together. You know you won't hit Jenemica.
    -
    * [Continue]
    -
    Jenemica: Everyone at school is going to see this photo on Monday then everyone will know how stupid you are!
    * [Why do you need to do this?]
        You: Why do you do this Jenemica? Why are you lashing out when Alisha has done nothing to you?
        You: I feel sorry for you. Something must be really wrong in your life.
    * [What are you scared of?]
        You: What are you scared of Jenemica? Does it scare you that Alisha can be happy without trying to be just like you?
    -
    #FRAME:jenemica:sad
    Anger flashes across Jenemica's face.
    Jenemica: Shut it loser or you'll be next.
    -
    * [Continue]
    -
    #FRAME:alisha:contented
    #PLAYER:mood:contented
    You: Alisha, you don't have to worry about this. We can handle it together.
    You: Jenemica, you don't scare me. I think what you've done is sad. I'm even going to tell my parents to tell your parents.
    Alisha: Yeah, and I'm telling my parents EVERYTHING too. You don't scare me either.
    -
    * [Continue]
    -
    You: By Monday morning Mrs Bottomly will know all about what you've done and what you were planning.
    Alisha: And if you show that photo around you'll be in bigger trouble.
    You: And finally, we'll report your Kafe account online. So there'll be proof of what you've done.
    -
    * [Continue]
    -
    ~goals += bully_challenged
    You: You need to talk to a grown up Jenemica, 'cos you've gone wrong, properly wrong.
    Jenemica doesn't say anything for a moment. You've taken the wind out of her sails.
    Jenemica: Ah, forget it you losers.
    She stomps off.
    -
    * [Continue]
    -
    #DEPART:jenemica
    #FRAME:alisha:happy
    #PLAYER:mood:happy
    You look at Alisha, she looks okay despite what just happened.
    You: Alisha, you are amazing! I think I might have cried.
    Alisha: I nearly did! But you were amazing too. You're such a good friend.
    You: Hey, it's what I do!
    You: Wanna come back to mine? Dad's cooking sausages!
    Alisha: Sure.
    {score_points(1)}
    -
    *   [Head home]
        -> garden_fixed

=== garden_fixed
~ location = garden_fixed_
    #PLAYER:pos:150:750:contented
    You're back at home in the garden. Looks like Dad was true to his word.
    The light is fixed and there's a delicious smell of sausages in the air.
    * [Head inside]
    -
    -> kitchen_fixed

=== kitchen_fixed
~ location = kitchen_fixed_

    #PLAYER:pos:350:650:contented:rev
    #DEPART:alisha
    You're back in the kitchen. No more smells of gas! What a day it's been!
    * [Continue]
    -
    #ARRIVE:dad:150:750:happy:rev
    #ARRIVE:alisha:508:590:contented
    Dad: Hey, you two. Had a nice time at the park?
    You: Well now...
    You: That's going to be a long story Dad.
    Dad: Hmm, maybe some sausages while we talk then?
    * [Sure Dad, that'd be nice]
    -
    You tell him about Jenemica, and Kafe and the photo. He nods thoughtfully as he listens. When you finish he says,
    Dad: Well done you two, you did the right thing and if anyone ever bullies you in person or online you must always tell someone.
    * [Continue]
    -
    {goals !? (saved_bernie):
        #FRAME:alisha:sad
        #FRAME:dad:shocked
        #PLAYER:mood:sad
        Dad: I heard some terrible news on the radio today.
        Dad: I'm afraid a boy from your school was hit and killed by a train today. The police said he'd been playing on the tracks near here.
        - else:
        Dad: I saw a boy from your school getting a serious talking to by the police today. I think he'd been playing on the railway.
        Dad: He was lucky to have not been killed I reckon.
    }
    Dad: Come to think of it, I've been hearing sirens all day long. There was a fire engine just up the road earlier attending a house fire.
    * [Tell Dad about your day]
        #FRAME:dad:happy:rev
        #FRAME:alisha:happy:rev
        #PLAYER:mood:contented
        You tell Dad all about your day. He listens and is amazed, surprised and proud as you all munch sausages.
        Dad: Mum will never believe this. What a day you've had! You should get a medal.
        {goals !? (online_safety):
            Alisha: No medal for online safety advice though, eh?
        }
        Alisha: I realise now that I was lucky that it was only Jenemica being horrible. It could have been someone much worse trying to trick me.
    -
    * [Agree]
        You: Yeah, I'm going the check the privacy settings on my apps.
        Alisha: Me too, and I'm going to check where the 'Report abuse' links are as well.
    -
    * [Ask Dad for your phone]
        #FRAME:dad:happy
        You: Where is my phone Dad? I could've really used it today.
        Dad rolls his eyes.
        Dad: Probably where you left it. Um, here.
        He pulls it from a drawer.
    -
    * [Take the phone]
        #FRAME:dad:happy:rev
        #FRAME:alisha:happy
        #PLAYER:mood:happy
        You take the phone and look at the screen.
        There's an app notification.
        You: It looks like I'm half way to level 23 on Pokemon Go!
        Alisha: Not bad!
        Dad: Nice, I'm only level 8.
        Alisha: I'm level 35.
        Dad: Okay then, let's all go out for a walk tomorrow and see what we can catch!
        You: Yes!

    // {goals ? (phone_gas):You got Dad to call the right number for a gas emergency.}
    // {goals ? (online_safety):You gave Alicia good advice about online safely.}
    // {goals ? (saved_bernie):You saved Bernie's life.}
    // {goals ? (house_fire_first):You called about the house fire first.}
    // {goals ? (saved_swimmer):You saved the swimmer from drowning.}
    // {goals ? (bully_challenged):You stood up to Jenemica's bullying.}

    // {goals !? (phone_gas):You didn't give Dad the right number for a gas emergency.}
    // {goals !? (online_safety):You're advice to Alicia about online safety wasn't very good.}
    // {goals !? (saved_bernie):You didn't saved Bernie's life.}
    // {goals !? (house_fire_first):You didn't call about the house fire first.}
    // {goals !? (saved_swimmer):You didn't save the swimmer from drowning.}
    // {goals !? (bully_challenged):You didn't stand up to Jenemica's bullying.}
    -> game_over

=== game_over
    {print_score()}
    * [The End]
    -
    -> END
