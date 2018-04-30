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

(defn in [list item]
  (prn (contains? list item))
)

(def person {
  :first-name "Max"
  :last-name "Bussiere"
  :age 28
  :occupation "Sr. Test Engineer"
  :address {
    :street "123 Main St"
    :city "Milwaukee"
    :state "WI"
    :zipcode "53203"
  }
})

(defn -main []
  (do (messenger))
  (do (messenger "What up"))
  (do (runfn #(prn (+ 6 6))))
  (do (prnmulti '("First" "Second" "Third")))
  (do (prnLastItem [1 2 3 4 5]))
  (do (prnList '(10 :ace :jack false "Thing")))
  (do (in #{1,2,3} 4))
  (do (in #{1,2,3} 2))
  (do (prn (person :occupation)))
  (do (assoc person :spouse "Lyra Christianson"))
  (do (prn (person :spouse)))
  (do (prn (get person :address)))
  (dotimes [i 3] (prn i))
  (doseq [thing '(:max :lyra :josh)] (prn thing))
  ; Nested looping
  (doseq [letter [:a :b :c] number (range 3)] (prn [letter number]))
  ; list comprehension!
  (prn (for [letter [:a :b :c] number (range 3)] [letter number]))
)
