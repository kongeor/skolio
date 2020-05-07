(import joy :prefix "")
(import ./routes/home :as home)
(import ./routes/comments :as comments)

(defroutes app
  [:get "/" home/index]

  [:get "/comments" comments/index]
  [:post "/comments" comments/create]
  [:options "/comments" comments/options]
  )
