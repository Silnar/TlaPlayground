-------------------- MODULE TlaInstanceIntoCollection1 ------------------------

EXTENDS Naturals, Sequences

CONSTANT Player
CONSTANT Msg
CONSTANT msg

ASSUME msg \in Msg

VARIABLE channels

Channels(p) == INSTANCE Channel1 WITH chan <- channels[p]  

TypeInvariant == \A p \in Player: Channels(p)!TypeInvariant 

Init ==
    /\  channels \in [p \in Player |-> Seq(Msg)]
    /\  \A p \in Player: Channels(p)!Init

PlayerSend(self) ==
    /\  ~Channels(self)!Ready
    /\  Channels(self)!Send(Msg)
    /\  \A q \in Player \ {self}: UNCHANGED channels[q]

PlayerReceive(self) ==
    /\  Channels(self)!Ready
    /\  Channels(self)!Receive
    /\  \A q \in Player \ {self}: UNCHANGED channels[q]

Next ==
    \E p \in Player:
        \/  PlayerSend(p)
        \/  PlayerReceive(p)

===============================================================================