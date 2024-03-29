-------------------- MODULE TlaInstanceIntoCollection3 ------------------------

(*
Example of instancing into a collection.

Version with extracting variables to separate file.
*)

EXTENDS Naturals, Sequences

CONSTANT Player
CONSTANT Msg
CONSTANT msg

ASSUME msg \in Msg

VARIABLE channels

Channels == INSTANCE Channels WITH chans <- channels

TypeInvariant == Channels!TypeInvariant 

Init == Channels!Init

PlayerSend(self) ==
    /\  ~Channels!Ready(self)
    /\  Channels!Send(self, msg)

PlayerReceive(self) ==
    /\  Channels!Ready(self)
    /\  Channels!Receive(self)

Next ==
    \E p \in Player:
        \/  PlayerSend(p)
        \/  PlayerReceive(p)

===============================================================================