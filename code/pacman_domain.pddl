;; The pacman doman provide some actions
;; action move is a simple move
;; action eat is eat the food on that position
;; action robustmove is after the pacman turn big, the move may 
;;                   not consider the position of a ghost
;; action turnbackmove is a move after which the big pacman 
;;                   turn back to its original state because it 
;;                   run out of robustmoves
;; action eatpellet is the pacman's state's change after it eat the pellet
;; action eatGhostMove is the move that can eat ghost

(define (domain  pacman)
  (:requirements [:strips] [:equality] [:typing] [:adl])
  (:predicates (isWall ?pacmanPosition)
               (isFood ?position)
               (connected ?x ?y)
               (currentposition ?position)
               (isGhost ?position)
               (isBig ?pacman)
               (isPellet ?position)
               (count ?n)
               (countinit ?n1)
               (succ ?x ?y)
               (countEnd ?n)
               
    )

  (:action move
    :parameters (?position ?nextMove ?pacman)
    :precondition (and  (not (isBig ?pacman))
                        (not (isWall ?nextMove))
                        (not (isGhost ?nextMove))
                        (connected ?position ?nextMove)
                        (currentposition ?position))
    :effect 
            (and (not (currentposition ?position))
                 (currentposition ?nextMove))
    )
    
  (:action eat
    :parameters (?position)
    :precondition (and  (isFood ?position)
                        (currentposition ?position))
    :effect 
                (not (isFood ?position))
    )
    
  (:action robustmove
    :parameters (?position ?nextMove ?pacman ?bigCounterFrom ?bigCounterTo)
    :precondition (and  (isBig ?pacman) 
                        (not (isGhost ?nextMove))
                        (not (countEnd ?bigCounterTo))
                        (succ ?bigCounterFrom ?bigCounterTo)
                        (not (count ?bigCounterTo))
                        (not (isWall ?nextMove))
                        (connected ?position ?nextMove)
                        (currentposition ?position)
                        (count ?bigCounterFrom))
    :effect 
            (and  (not (currentposition ?position))
                  (currentposition ?nextMove)
                  (count ?bigCounterTo)
                  (not (count ?bigCounterFrom)))
    )
    
  (:action turnbackmove
    :parameters (?position ?nextMove ?pacman ?bigCounterFrom ?bigCounterTo)
    :precondition (and  (isBig ?pacman)
                        (count ?bigCounterFrom)
                        (countEnd ?bigCounterTo)
                        (succ ?bigCounterFrom ?bigCounterTo)
                        (not (isWall ?nextMove))
                        (not (isGhost ?nextMove))
                        (connected ?position ?nextMove)
                        (currentposition ?position))
    :effect 
           (and (not (currentposition ?position))
                (currentposition ?nextMove)
                (not (isBig ?pacman))
                (not (count ?bigCounterFrom))
                (not (count ?bigCounterTo))
                    
                )
    )
    
  (:action eatpellet
    :parameters (?position ?pacman ?n1)
    :precondition (and  (isPellet ?position)
                        (currentposition ?position)
                        (countinit ?n1))
    :effect 
            (and (not (isPellet ?position))
                 (isBig ?pacman)
                 (count ?n1)
                )
    )    
    
  (:action eatGhostMove
    :parameters (?position ?nextMove ?pacman ?bigCounterFrom ?bigCounterTo)
    :precondition (and  (isBig ?pacman) 
                        (isGhost ?nextMove)
                        (not (countEnd ?bigCounterTo))
                        (succ ?bigCounterFrom ?bigCounterTo)
                        (not (isWall ?nextMove))
                        (connected ?position ?nextMove)
                        (currentposition ?position)
                        (count ?bigCounterFrom))
    :effect 
            (and  (not (currentposition ?position))
                  (currentposition ?nextMove)
                  (count ?bigCounterTo)
                  (not (isGhost ?nextMove))
                  (not (count ?bigCounterFrom)))
    )
)