(import joy :prefix "")
(import joy/html :as html)
(import curl :as curl)

(def TO_MAIL (env :smtp_to))
(def FROM_MAIL (env :smtp_from))
(def app-host (env :app_host))

(defn create-body [comment]
  (pp "-------")
  (pp comment)
  (pp "-------")
  (html [:div
         [:p "Message:"]
         [:p (get comment "message")]
         [:p
          [:a {:href (string app-host "/actions/comments/" (get comment "token") "/approve")} "approve"]
          [:a {:href (string app-host "/actions/comments/" (get comment "token") "/reject")
               :style "margin-left: 5px"} "reject"]]]))

(defn create-mail [comment]
  (let [m ["Date: Thu, 14 May 2020 10:54:29 +0300\r\n" # TODO format
            "To: " TO_MAIL "\r\n"
            "From: " FROM_MAIL "\r\n"
            "Content-Type: text/html\r\n" # TODO encoding?
            (string "Subject: New comment from " (get comment "name") "\r\n")
            "\r\n"
            (create-body comment)
            ""]] # trailing slash is needed
    (string/join m)))

(defn send-mail [comment]
  (var idx 0)
  (let [c (curl/easy/init)
        mail-str (create-mail comment)]
    (:setopt c
             :username (env :smtp_username)
             :password (env :smtp_password)
             :url (env :smtp_url)
             :read-function (fn [len] 
                              (if (> (length mail-str) (inc idx))
                                (let [s (string/slice mail-str idx (inc idx))]
                                  (set idx (inc idx))
                                  s)
                                ""
                                ))
             :mail-from FROM_MAIL
             :mail-rcpt [TO_MAIL]
             :verbose? false
             :upload? true
             :use-ssl 1
             )
    (pp (:perform c))))
