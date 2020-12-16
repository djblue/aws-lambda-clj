(ns example.core
  (:require [jsonista.core :as json])
  (:gen-class
   :implements [com.amazonaws.services.lambda.runtime.RequestHandler]))

(defn -handleRequest [_this event _context]
  (json/write-value-as-string event))

(defn -main []
  (println (json/write-value-as-string {:hello :world})))
