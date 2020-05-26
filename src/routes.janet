(import joy :prefix "")
(import joy/html :as html)
(import ./routes/home :as home)
(import ./routes/comments :as comments)
(import ./util :as util)

# TODO remove
(import ./mailer :as mailer)

(defn handler [req]
  @{:status 200 :body (mailer/create-body @{:name "Joe" :message "hello world" :token "zxcv"}) :headers {"Content-Type" "text/html"}}
  )

(defroutes app
  [:get "/" handler]
  [:get "/mail" home/send-mail-handler]

  [:get "/comments" comments/index]
  [:post "/comments" comments/create]

  [:get "/actions/comments/:token/approve" comments/approve]

  [:options "/comments" comments/options]
  )
