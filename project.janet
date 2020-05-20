(declare-project
  :name "skolio"
  :description ""
  :dependencies [{:repo "https://github.com/joy-framework/joy" :tag "0.7.4"}
                 "https://github.com/joy-framework/tester"
                 "https://github.com/kongeor/jurl"]
  :author ""
  :license ""
  :url ""
  :repo "")

(declare-executable
  :name "skolio"
  :entry "main.janet")

(phony "server" []
  (do
    (os/shell "pkill -xf 'janet main.janet'")
    (os/shell "janet main.janet")))

(phony "watch" []
  (do
    (os/shell "pkill -xf 'janet main.janet'")
    (os/shell "janet main.janet &")
    (os/shell "fswatch -m poll_monitor -r -o src | xargs -n1 -I{} ./watch")))

