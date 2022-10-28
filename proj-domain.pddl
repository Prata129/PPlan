(define (domain jobFlowScheduling)

    (:requirements :adl :action-costs)

    (:types machine task)

    (:predicates (machineForTask ?m - machine ?t - task)
                 (taskAfter ?t1 ?t2 - task)
                 (dependsOn ?t1 ?t2 - task)
                 (done ?t - task)
                 (previous ?t - task ?m - machine)
                 (next ?m - machine)
                 (after ?m1 ?m2 - machine))
    
    (:functions (total-cost) - number)
    
    (:action schedule
        :parameters (?t - task ?m ?m2 - machine)
        :precondition (and (next ?m)
                           (after ?m ?m2)
                           (machineForTask ?m ?t)
                           (or (not (done ?t)) (= ?t none))
                           (forall (?ta2 - task) (imply (taskAfter ?ta2 ?t) (previous ?ta2 ?m)))
                           (forall (?ta1 - task) (imply (dependsOn ?ta1 ?t) (and (done ?ta1)
                                                                                 (forall (?mu - machine) (not (previous ?ta1 ?mu)))))))
        :effect (and (forall (?ta - task) (not (previous ?ta ?m)))
                     (previous ?t ?m)
                     (increase (total-cost) 1)
                     (done ?t)
                     (not (next ?m))
                     (next ?m2)))
    
)