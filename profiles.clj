{
  ;; inf-clojure support
  :jvm-opts ["-Dclojure.server.repl={:port 5555 :accept clojure.core.server/repl}"]
 ;; for all that repl goodness
 :user { :dependencies [[org.clojure/tools.namespace "0.3.0-alpha4"]]
        :plugins [[lein-cljfmt "0.4.1" :exclusions [org.clojure/clojure]]
                  [lein-cloverage "1.0.6" :exclusions [org.clojure/clojure]]
                  [lein-ancient "0.6.10", :exclusions [org.clojure/clojure]]]}
}
