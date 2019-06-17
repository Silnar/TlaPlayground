----------------------------- MODULE Channel2 ---------------------------------

EXTENDS Naturals, Sequences

Type(Msg) == Seq(Msg)

New == <<>>

Ready(chan) == Len(chan) > 0

Send(chan, msg) == Append(chan, msg)

Receive(chan) == Tail(chan)

===============================================================================