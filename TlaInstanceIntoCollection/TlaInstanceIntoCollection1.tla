-------------------- MODULE TlaInstanceIntoCollection1 ------------------------

(*
Example of instancing into a collection.

Version that seems to be the most obvious, at first,
from programming reusability perspective,
but horribly complicated and inneficient.
*)

EXTENDS Naturals, Sequences

CONSTANT Player
CONSTANT Msg
CONSTANT msg

ASSUME msg \in Msg

VARIABLE channels

Channels(p) == INSTANCE Channel1 WITH chan <- channels[p]  

(*
NOTE: Can't use Channells(p)!TypeInvariant like below:

TypeInvariant == \A p \in Player: Channels(p)!TypeInvariant

because it doesn't constrain channels to be a function
*)
TypeInvariant == channels \in [Player -> Seq(Msg)]


(*
NOTE: It's required to define channels before using Channels(P)!Init.

As a consequence TLC cannot enumerate infinite set [Player -> Seq(Msg)]

and Seq(Msg) have to be overriden with finite set, for example:

Seq(S) == UNION {[1..n -> S] : n \in 0..2}

Msg should also be overriden if it is an infinite set.
*)
Init ==
    /\  channels \in [Player -> Seq(Msg)]
    /\  \A p \in Player: Channels(p)!Init

(*
NOTE: It's required to fully define channels' before changing it in Channels(self)!Send(msg)
*)
PlayerSend(self) ==
    /\ channels' \in [Player -> Seq(Msg)]
    /\  ~Channels(self)!Ready
    /\  Channels(self)!Send(msg)
    /\  \A q \in Player \ {self}: UNCHANGED channels[q]

(*
NOTE: It's required to fully define channels' before changing it in Channels(self)!Receive
*)
PlayerReceive(self) ==
    /\ channels' \in [Player -> Seq(Msg)]
    /\  Channels(self)!Ready
    /\  Channels(self)!Receive
    /\  \A q \in Player \ {self}: UNCHANGED channels[q]

Next ==
    /\  \E p \in Player:
            \/  PlayerSend(p)
            \/  PlayerReceive(p)

===============================================================================