(import joy :prefix "")
(import ./routes/home :as home)
(import ./routes/comments :as comments)

(defroutes app
  # [:get "/" home/index]
  [:get "/mail" home/send-mail-handler]

  [:get "/comments" comments/index]
  [:post "/comments" comments/create]
  [:options "/comments" comments/options]
  )
