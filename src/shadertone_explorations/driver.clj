;;
;; ~/Applications/SuperCollider.app/Contents/Resources/scsynth -u 57110 -H "BoomDevice"
;;
;; why does the following have to be executed in the extenal repl?
;; (use 'overtone.core)
;; (connect-external-server)

(ns shadertone-explorations.driver
  (:use [overtone.core])
  (:require [shadertone.tone :as t]))

(defn start-shader [file]
  (defsynth vol []
    (tap "system-vol" 30 (lag (* 5 (abs (sound-in 0))) 0.1)))

  (def voltap-synth
    (vol [:after (foundation-monitor-group)]))

  (t/start file
  ;; (t/start-fullscreen file
           :width 837 :height 837
           :user-data {"iOvertoneVolume"
                       (atom {:synth voltap-synth
                              :tap   "system-vol"})}))

(t/stop)
(start-shader "resources/shader-exploration-01.glsl")
(start-shader "resources/shader-exploration-02.glsl")
(start-shader "resources/shader-exploration-03.glsl")
(start-shader "resources/shader-exploration-04.glsl")
(start-shader "resources/shader-exploration-05.glsl")
(start-shader "resources/shader-exploration-06.glsl")
(start-shader "resources/shader-exploration-07.glsl")
(start-shader "resources/shader-exploration-08.glsl")
(start-shader "resources/shader-exploration-09.glsl")
(start-shader "resources/shader-exploration-10.glsl")
(start-shader "resources/shader-exploration-11.glsl")
(start-shader "resources/shader-exploration-12.glsl")
(start-shader "resources/shader-exploration-13.glsl")
(start-shader "resources/shader-exploration-14.glsl")
(start-shader "resources/shader-exploration-15.glsl")
(start-shader "resources/shader-exploration-16.glsl")
(start-shader "resources/shader-exploration-17.glsl")
(start-shader "resources/shader-exploration-18.glsl")
(start-shader "resources/shader-exploration-19.glsl")
(start-shader "resources/shader-exploration-20.glsl")
(start-shader "resources/shader-exploration-21.glsl")
(t/stop)
(start-shader "resources/shadertoy-flames.glsl")
(start-shader "resources/shadertoy-plasma-globe.glsl")
(start-shader "resources/shadertoy-relentless.glsl")
(start-shader "resources/shadertoy-voxel-edges.glsl")
