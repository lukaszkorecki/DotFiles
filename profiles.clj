;; make this work with latest cider
{:repl {:plugins [[org.clojure/tools.nrepl "0.2.12"]
                  [cider/cider-nrepl "0.12.0-SNAPSHOT"]]

        :repl-options {:host "0.0.0.0"
                       :timeout 120000 }}
 :user {:plugins [
                  ;; lint them things
                  [jonase/eastwood "0.2.1" :exclusions [org.clojure/clojure]]
                  [lein-kibit "0.1.2" :exclusions [org.clojure/clojure]]
                  ;; more linting
                  [lein-bikeshed "0.2.0" :exclusions [org.clojure/clojure]]
                  ;; can't live without it
                  [lein-cljfmt "0.4.1" :exclusions [org.clojure/clojure]]
                  ;; this!
                  [lein-cloverage "1.0.6" :exclusions [org.clojure/clojure]]

                  ;; find outdated
                  [lein-ancient "0.6.10", :exclusions [org.clojure/clojure]]]}}
