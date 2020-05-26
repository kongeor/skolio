(import joy :prefix "")

(defn send-mail-handler [request]
  # (:send mt "yo")
  # (send-mail-impl)
  # (thread/new send-mail-impl 10)
  (let [q (get request :query-string)
        subject (get q :subject)]
    # (send-mail subject)
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
