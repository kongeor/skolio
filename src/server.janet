(import joy :prefix "")
(import ./layout :as layout)
(import ./routes :as routes)

(defn cors-headers [handler &opt options]
  (default options @{"Access-Control-Allow-Origin" "*"})
  (fn [request]
    (let [response (handler request)]
      (when response
        (update response :headers merge options)))))

(def app (as-> routes/app ?
               (handler ?)
               # (layout ? layout/app)
               (logger ?)
               #(csrf-token ?)
               #(session ?)
               (extra-methods ?)
               (query-string ?)
               (json-body-parser ?)
               (server-error ?)
               (x-headers ? @{"Access-Control-Allow-Origin" "*"
                              "Access-Control-Allow-Methods" "POST, GET, OPTIONS"
                              "Access-Control-Allow-Headers" "X-PINGOTHER, Content-Type"})
               (static-files ?)))


(defn start [port]
  (let [port (scan-number
              (or port
                  (env :port)
                  "8000"))]
    (db/connect (env :database_url))
    # (print (os/cwd))
    # (db/migrate (env :database_url))
    (server app port) # stops listening on SIGINT
    (db/disconnect)))
