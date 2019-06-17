----------------------------- MODULE Channel1 ---------------------------------

EXTENDS Naturals, Sequences

CONSTANT Msg
VARIABLE chan

TypeInvariant == chan \in Seq(Msg)

Init == chan = <<>>

Ready == Len(chan) > 0

Send(msg) == chan' = Append(chan, msg)

Receive == chan' = Tail(chan)

===============================================================================