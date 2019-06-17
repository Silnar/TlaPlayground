----------------------------- MODULE Channels ---------------------------------

EXTENDS Naturals, Sequences

CONSTANT Player
CONSTANT Msg

VARIABLE chans

TypeInvariant == chans \in [Player -> Seq(Msg)]

Init == chans = [p \in Player |-> <<>>]

Ready(p) == Len(chans[p]) > 0

Send(p, msg) == chans' = [chans EXCEPT ![p] = Append(@, msg)]

Receive(p) == chans' = [chans EXCEPT ![p] = Tail(@)]

===============================================================================