
/*
 A test story
 Authors: Pat Smith
*/

LIST location = mess, airlock

LIST active = on, off

LIST goals = restore_power, restore_air

LIST inventory = spanner, paperclip


VAR score = 0
VAR oxygen_level = 100
VAR max_possible_score = 2
VAR alarm_state = on

~inventory += paperclip

-> loc_space


// a function
=== function print_score ===
    You scored {score} out of a possible {max_possible_score}.


=== loc_space ===
    Drifting in space, powerless, the Mastromo slips further into the gravitational well.
    * [Continue]
    -> loc_mess

=== loc_mess ===
    ~ location = mess
    You come round, an alarm ringing in your ears. Last thing you remember, the whole crew, together, eating... then a tremendous jolt, confusion, lights out... then this...
    # PAIN
    Your crew mates are nowhere to be seen.
    -> coming_round_in_the_mess
    
    = coming_round_in_the_mess
    { alarm_state == on: An alarm bleats. }
    { inventory !? (spanner): There is a spanner here. }
    *   [Call out]
        "Aisley!?"
        "Smith!?"
        . . . silence.
        -> coming_round_in_the_mess
    +   [Airlock]
        It's on lockdown<>
        { inventory ? (spanner): but you can use the spanner to override it manually}
        { inventory !? (spanner):: you'd need tools to open it.}
        { inventory !? (spanner): -> coming_round_in_the_mess}
        
        ** { inventory ? (spanner) } [Force the airlock]
           You fit the head of the spanner over the central latch pin, and heave
           . . .
           The airlock releases and swings slowly back.
           
           Beyond you can see... "Wait, what is that? My Grud, no!"
           # SHIVER
           . . .
           
           -> end

    *   [Examine the room]
        There's no sign of damage or your crewmates. The emergency power systems are in operation: basic life support and minimal lighting.
        
        Nearby is a button marked alarm.
        ** [Press button]
           You press the button and after a moment the alarm ceases.
           ~ score += 1
           ~ alarm_state = off
           -> coming_round_in_the_mess
    * { inventory !? (spanner) } [Take the spanner]
        You grab the spanner and tuck it into your toolbelt.
        ~ inventory += spanner
        ~ score += 1
        -> coming_round_in_the_mess

    
=== end ===
    ~ location = airlock
    Thanks for playing. This was a short demo of Ink on the web employing variable observers to implements an inventory and score system in a React UI.
    
-    -> game_over


=== game_over
    {print_score()}
    -> END
