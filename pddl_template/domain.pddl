(define (domain Dangeon)
    (:requirements :typing :negative-preconditions)

    (:types swords cells)

    (:predicates
        (at-hero ?loc - cells)
        (at-sword ?s - swords ?loc - cells)
        (has-monster ?loc - cells)
        (has-trap ?loc - cells)
        (is-destroyed ?obj)
        (connected ?from ?to - cells)
        (arm-free)
        (holding ?s - swords)
        (trap-disarmed ?loc)
    )

    (:action move
        :parameters (?from ?to - cells)
        :precondition (and
                            (at-hero ?from)
                            (connected ?from ?to)
                            (not (has-trap ?from))
                            (not (has-trap ?to))
                            (not (has-monster ?to))
                            (not (is-destroyed ?to))
        )
        :effect (and
                            (not (at-hero ?from))
                            (at-hero ?to)
                            (is-destroyed ?from)
                )
    )

    (:action move-to-trap
        :parameters (?from ?to - cells)
        :precondition (and
                            (at-hero ?from)
                            (connected ?from ?to)
                            (not(has-trap ?from))
                            (has-trap ?to)
                            (arm-free)
                            (not (is-destroyed ?to))
        )
        :effect (and
                            (not (at-hero ?from))
                            (at-hero ?to)
                            (is-destroyed ?from)

                )
    )

    (:action move-to-monster
        :parameters (?from ?to - cells  ?s - swords)
        :precondition (and
                            (at-hero ?from)
                            (connected ?from ?to)
                            (holding ?s)
                            (has-monster ?to)
                            (not (is-destroyed ?to))
        )
        :effect (and
                            (not (at-hero ?from))
                            (at-hero ?to)
                            (is-destroyed ?from)
                )
    )

    (:action pick-sword
        :parameters (?loc - cells ?s - swords)
        :precondition (and
                            (at-hero ?loc)
                            (at-sword ?s ?loc)
                            (arm-free)
                      )
        :effect (and
                            (not (at-sword ?s ?loc))
                            (holding ?s)
                            (not (arm-free))
                )
    )


    (:action destroy-sword
        :parameters (?loc - cells ?s - swords)
        :precondition (and
                            (at-hero ?loc)
                            (holding ?s)
                            (not (has-monster ?loc))
                            (not (has-trap ?loc))
                            (not(arm-free))
                      )
        :effect (and
                            (not (holding ?s))
                            (arm-free)
                )
    )

    (:action disarm-trap
        :parameters (?loc - cells)
        :precondition (and
                            (at-hero ?loc)
                            (has-trap ?loc)
                            (arm-free)
                      )
        :effect (and
                            (not (has-trap ?loc))
                            (trap-disarmed ?loc)
                )
    )
)
