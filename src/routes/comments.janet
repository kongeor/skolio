(import joy :prefix "")

(defn select-keys [tbl ks]
  (reduce (fn [acc k] (merge acc (table k (get tbl k)))) {} ks))

(defn index [request]
  (let [q (get request :query-string)
        comments (db/from :comments :where {:thread (q :thread)})]
    (application/json comments)))


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
