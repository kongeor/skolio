(import joy :prefix "")
(import curl :as curl)

(def TO_MAIL (env :smtp_to))
(def FROM_MAIL (env :smtp_from))

(defn create-mail [subject]
  (let [m ["Date: Thu, 14 May 2020 10:54:29 +0300\r\n"
            "To: " TO_MAIL "\r\n"
            "From: " FROM_MAIL "\r\n"
            # "Message-ID: <dcd7cb36-11db-487a-9f3a-e652a9458efd@rfcpedant.example.org>\r\n"
            "Content-Type: text/html\r\n"
            (string "Subject: SMTP example message " subject "\r\n")
            "\r\n"
            "<p><a href=\"example.com\">yas</a></p><h2>boom</h2>\r\n"
            ""]]
    (string/join m)))

            # "Content-Type: text/html; charset=\"UTF-8\"\r\n"
            # "\r\n"
            # "<p><a href=\"example.com>yas</a></p><h2>boom</h2>\r\n"

# (def mail-str (string/join mail))

(defn send-mail [subject]
  (var idx 0)
  (let [c (curl/easy/init)
        mail-str (create-mail subject)]
    (:setopt c
             :username (env :smtp_username)
             :password (env :smtp_password)
             :url (env :smtp_url)
             :read-function (fn [len] 
                              #(when (> (length mail) idx)
                              #  (let [line (get mail idx)]
                              #    (print line)
                              #    (set idx (inc idx))
                              #    (buffer line)))
                              (if (> (length mail-str) (inc idx))
                                (let [s (string/slice mail-str idx (inc idx))]
                                  (set idx (inc idx))
                                  s
                                  )
                                ""
                                ))
             :mail-from FROM_MAIL
             :mail-rcpt [TO_MAIL]
             :verbose? false
             :upload? true
             :use-ssl 1
             )
    (pp (:perform c))
    ))

# (send-mail)

(defn mail-thread [parent]
  (print "new thread!")
  (def msg (thread/receive))
  (print (string "msg!! " msg))
  # (send-mail)
  )

(defn worker
  [parent]
  (print "New thread started!")
  (def msg (thread/receive))
  (print (string "msg!! " msg))
 #  (send-mail)
  )

# (def mt (thread/new worker 32))

(defn send-mail-handler [request]
  # (:send mt "yo")
  # (send-mail-impl)
  # (thread/new send-mail-impl 10)
  (let [q (get request :query-string)
        subject (get q :subject)]
    (send-mail subject)
    # (pp subject)
    (application/json {:ok "ok"}))
  )

(defn index2 [request]
  [:div {:class "tc"}
   [:h1 "You found joy!!!!"]
   [:p {:class "code"}
    [:b "Joy Version:"]
    [:span (string " " (os/cwd))]
    [:span (string " " version)]]
   [:p {:class "code"}
    [:b "Janet Version:"]
    [:span janet/version]]])
