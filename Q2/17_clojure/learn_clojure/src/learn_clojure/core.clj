(ns learn-clojure.core)

(defn messenger
  ([] (messenger "Hello world!"))
  ([msg] (prn msg))
)

(defn runfn [foo]
  (foo)
)

(defn prnthree [first second third] (prn "First" "Second" "Third"))

(defn prnmulti [multi] (apply prnthree multi))

(defn prnLastItem [vec] (prn (get vec (- (count vec) 1))))

(defn prnList [list]
  (do (prn (peek list)))
  (if (not (empty? list))
    (do (prnList (pop list)))
    (do (prn "done"))
  )
)

(defn -main []
  (do (messenger))
  (do (messenger "What up"))
  (do (runfn #(prn (+ 6 6))))
  (do (prnmulti '("First" "Second" "Third")))
  (do (prnLastItem [1 2 3 4 5]))
  (do (prnList '(10 :ace :jack false "Thing")))
)
