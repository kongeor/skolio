(import joy :prefix "")
(import ../mailer :as mailer)
(import ../util :as util)

(def public-fields [:id :name :thread :created-at :message])

(defn index [request]
  # todo validate q
  (let [q (get request :query-string)
        comments (db/from :comments :where {:thread (q :thread) :status 1} :order "id desc")]
    (application/json (map (fn [c] (util/select-keys c public-fields)) comments))))

(defn add-extra-data [comment]
  # other keys will also be strings
  (merge comment {"token" (util/gen-token) "status" 0}))


(defn create [request]
  # TODO validate
  (let [body (get request :body)
        comment (add-extra-data body)]
    # TODO when mail is configured
    # TODO different thread
    (mailer/send-mail comment)
    (let [result (->> comment
                   (db/insert :comments)
                   (rescue))
          [errors comment] result]
      (if (nil? errors)
        (application/json (util/select-keys comment public-fields)) 
        (put request :errors errors)))))

(defn approve [request]
  (let [token (-> request (get :params) (get :token))
        comment (db/find-by :comments :where {:token token})
        updated (db/update :comments (get comment :id) {:status 1})]
    # TODO check fields
    (application/json updated)))

(defn options [request]
  (print "yas")
  (pp request)
  (application/json {}))
