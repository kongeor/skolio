(def token-chars "abcdefghijklmnopqrstuvwxyz0123456789")
(def token-chars-length (length token-chars))

(defn gen-token []
  (apply string/from-bytes
    (seq [x :in (os/cryptorand 32)]
      (let [i (mod x token-chars-length)]
        (get token-chars i)))))

# (let [i (math/round (* (math/random) token-chars-length))]
#        (get token-chars i))

(defn select-keys [tbl ks] (reduce (fn [acc k] (merge acc (table k (get tbl k)))) {} ks))

