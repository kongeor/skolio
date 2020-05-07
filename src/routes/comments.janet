(import joy :prefix "")


(defn index [request]
  (application/json (db/fetch-all [:comments])))


(defn create [request]
  (pp request)
  (let [result (->> (get request :body)
                    (db/insert :comments)
                    (rescue))
        [errors comment] result]
    (if (nil? errors)
      (application/json comment) 
      (put request :errors errors))))

(defn options [request]
  (print "yas")
  (pp request)
  (application/json {}))
