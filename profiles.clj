;; make this work with latest cider
{:repl {:plugins [[org.clojure/tools.nrepl "0.2.12"]
                  [refactor-nrepl "2.2.0"]
                  [cider/cider-nrepl "0.14.0-SNAPSHOT"]]
        :repl-options {:host "0.0.0.0"
                       :timeout 120000 }}
 :user {:plugins [
                  [lein-checkall "0.1.1" :exclusions [org.clojure/clojure
                                                      org.clojure/tools.namespace]]
                  [lein-cljfmt "0.4.1" :exclusions [org.clojure/clojure]]
                  ;; this!
                  [lein-cloverage "1.0.6" :exclusions [org.clojure/clojure]]

                  ;; find outdated
                  [lein-ancient "0.6.10", :exclusions [org.clojure/clojure]]]}}
