{:repl {:plugins [[org.clojure/tools.nrepl "0.2.12"]
                  [cider/cider-nrepl "0.9.1"] ]}
 :user {:plugins [[debug-repl "0.3.2"]
                  [jonase/eastwood "0.2.1" :exclusions [org.clojure/clojure]]

                  [lein-bikeshed "0.2.0" :exclusions [org.clojure/clojure]]

                  [lein-cljfmt "0.4.1" :exclusions [org.clojure/clojure]]

                  [lein-cloverage "1.0.6" :exclusions [org.clojure/clojure]]

                  [lein-kibit "0.1.2" :exclusions [org.clojure/clojure]]

                  [lein-pprint "1.1.1"]
                  [venantius/ultra "0.3.4" :exclusions [org.clojure/clojure]]]
        :ultra {:color-scheme :solarized_dark}}}
