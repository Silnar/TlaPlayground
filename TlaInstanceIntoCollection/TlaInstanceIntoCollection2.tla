-------------------- MODULE TlaInstanceIntoCollection2 ------------------------

EXTENDS Naturals, Sequences

CONSTANT Player
CONSTANT Msg
CONSTANT msg

ASSUME msg \in Msg

VARIABLE channels

Channel == INSTANCE Channel2

TypeInvariant == channels \in [Player -> Channel!Type(Msg)]

Init == channels = [p \in Player |-> Channel!New]

PlayerSend(self) ==
    /\  ~Channel!Ready(channels[self])
    /\  channels' = [channels EXCEPT ![self] = Channel!Send(@, msg)]

PlayerReceive(self) ==
    /\  Channel!Ready(channels[self])
    /\  channels' = [channels EXCEPT ![self] = Channel!Receive(@)]

Next ==
    \E p \in Player:
        \/  PlayerSend(p)
        \/  PlayerReceive(p)

===============================================================================