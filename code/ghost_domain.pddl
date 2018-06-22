;; The ghost domain just aims at eating a static pacman
(define (domain  ghost)
  (:requirements [:strips] [:equality] [:typing] [:adl])
  (:predicates (isWall ?pacmanPosition)
               (isPacman ?pacman)
               (connected ?x ?y)
               (currentposition ?position)
               
    )

  (:action move
    :parameters (?position ?nextMove)
    :precondition (and  (not (isWall ?nextMove))
                        (connected ?position ?nextMove)
                        (currentposition ?position))
    :effect 
                (currentposition ?nextMove)
    )
  (:action eat
    :parameters (?position)
    :precondition (and  (isPacman ?position)
                        (currentposition ?position))
    :effect 
                (not (isPacman ?position))
  )
)