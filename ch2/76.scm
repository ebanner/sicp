;;; Exercise 2.76

;;; ** New types **
;;;
;;; Explicit dispatch - In the generic operation for explicit
;;; dispatch, you would need to manually add another case to the cond, which
;;; has a case for every different type.
;;;
;;; Data-directed style - You would need to add another row in the
;;; table of procedures that operate on the new type.
;;;
;;; Message-Passing style - No additional work needs to be done
;;; assuming you've already wrapped the data object in a procedure and
;;; implemented the dispatch.
;;;
;;; ** New operations **
;;; 
;;; Explicit dipatch - You'll have to create a top-level procedure
;;; call which is implemented by dispatching on the type to the
;;; correct data type's implementing procedure
;;;
;;; Data-directed style - You would need to add a new column into the
;;; table and tell everyone everyone to insert their implementation
;;; into their appropriate slot in that column
;;;
;;; Message-Passing style - You would only need to have each data
;;; object implement the new operation and have it dispatch on that
;;; operation.
;;; 
;;; Message passing seems like a winner!
;;;
;;; For a system in which new types need to be added often, the clear
;;; loser is explicit dispatch. Explicit dispatch is going to be a
;;; loser in every category becuase there will always need to be a
;;; manager that has to make stupid manual changes to the generic
;;; `operate' method. The winner is message passing because all that
;;; needs to happen is for the implementor of the new type to
;;; implement that new type. The type absolutely takes care of
;;; itself. In second place we have data-directed programming because
;;; we only have to have the implementor of the new type to add its
;;; entries into the master table. No work for anyone else needs to be
;;; done.
;;;
;;; For a system that needs new operations added often, once again the
;;; clear loser is explicit dispatch. This is because the manager has
;;; to implement a new generic method, along with keeping up with
;;; everyone that implements the method by manually adding their type
;;; in the colossal cond expression. I would say data-directed
;;; programming and message-passikng tie for first place here. In both
;;; instances the manager is automated and the implementors don't have
;;; to do much additional work. It really comes down to how much
;;; wrapping your data object in a procedure and coding a dispatch
;;; bothers you. If it doesn't then pick message-passing. If it does,
;;; then choose data-directed programming and just stick your new
;;; operation in the master table.
