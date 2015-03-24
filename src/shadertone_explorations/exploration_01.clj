(ns shadertone-explorations.exploration-01
  ;; (:use [overtone.live])
  (:use [overtone.core])
  (:require [shadertone.tone :as t]))

(defn start-shader [file] (t/start file :width 837 :height 1006))

(do
  ;; snare
  (def s1 (sample (freesound-path 26903)))
  ;; kick
  (def k1 (sample (freesound-path 2086)))
  ;; close-hihat
  (def x (sample (freesound-path 802)))
  ;; open-hihat
  (def o (sample (freesound-path 26657)))

  (def k2 (sample (freesound-path 132582)))
  (def k3 (sample (freesound-path 131336)))
  (def s2 (sample (freesound-path 34828)))
  (def s3 (sample (freesound-path 188116)))

  (def k k3)
  (def s s3)
  (def _ nil)

  ;; there has to be something better than cond
  (defn beat [t sep i]
    (if-let [[x & xs] (seq i)]
      (do
        (if-not (nil? x) (at t (x)))
        (let [next-t (+ t sep)]
          (apply-by next-t #'beat [next-t sep (conj (vec xs) x)])))))
  )

(do (stop) (beat (now) 180 [k o x o k k s _]))
(do (stop) (beat (now) 110 [k _ _ k _ _ s _ _ _ _ o _ x x]))
(do (stop) (beat (now) 400 [k3 x s2 o]))
(do (stop) (beat (now) 140
                 [k _ k _ s _ _ k _ k k _ s _ _ _
                  k _ k _ s _ _ k _ k k _ s _ s s
                  k _ _ k s _ _ k _ k k _ s _ _ s
                  s _ _ k s k _ k s k _ k s _ _ _]))
(stop)

(do
  (definst external
    []
    (* 10 (abs (sound-in 0))))
  (external))

;; investigation into tapping system volume for visualizations, it appears there might be several obstacles
;;(overtone.sc.server/boot-internal-server)

(ns shadertone-explorations.exploration-01
  ;; (:use [overtone.live])
  (:use [overtone.core])
  (:require [shadertone.tone :as t]))

(defn start-shader [file]
;; (do
  (defsynth vol []
    ;; (tap "system-vol" 60 (lag (abs (in:ar 0)) 0.1)))
    ;; look into why sound-in works instead of in:ar, how are they different,
    ;; also further observe the "system-volume" tab connection
    (tap "system-vol" 30 (lag (* 5 (abs (sound-in 0))) 0.1)))

  (def voltap-synth
    (vol [:after (foundation-monitor-group)]))

  ;; (definst external []
    ;; (* 10 (abs (sound-in 0))))

  ;; (t/start file
  (t/start-fullscreen file
           ;; :width 837 :height 837
           :width 837 :height 1006
           :user-data {"iOvertoneVolume"
                       (atom {:synth voltap-synth
                       ;; (atom {:synth external
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
(t/stop)
(start-shader "resources/shadertoy-flames.glsl")
(start-shader "resources/shadertoy-plasma-globe.glsl")
(start-shader "resources/shadertoy-relentless.glsl")
(start-shader "resources/shadertoy-voxel-edges.glsl")
