#!/bin/env -S fennel
;;

(local lgi (require :lgi))
(local Gtk (lgi.require "Gtk" "3.0" ))
(local Pango (lgi.require "Pango"))
; (local GtkSource (lgi.require "GtkSource" "3.0"))

(local app (Gtk.Application {:application_id :com.sfesenko.calc3 }))
(local hhh "🤦")

(fn eval [s]
  (let [f (load (.. "return " s))]
   (and f (f))))


(fn app.on_startup [self]
  (Gtk.ApplicationWindow {
    :default_height 200
    :default_width 512
    :application self}
  ))

(fn build_ui [win]
  (let [
    label (Gtk.Label { :label "." :halign Gtk.Align.END })
    edit (Gtk.Entry)
    font (Pango.FontDescription.from_string "Terminus 24")
    box (Gtk.Box {
         :visible true
         :spacing 10
         :valign Gtk.Align.END
         :halign Gtk.Align.FILL
         :orientation Gtk.Orientation.VERTICAL
         1 label}
       )]

    (fn edit.on_activate [self]
      (let [res (eval (edit:get_text))]
        (if res
          ; (edit:set_text res)
          ; (edit:set_text res)
          ; (set edit.text res)
          (edit:set_position -1)
          ; (edit:select_region -1 -1)
        )
        (label:set_text (or res hhh))
    ))

    (label:modify_font font)
    (edit:modify_font font)
    (edit:set_size_request 40 20)

    (box:pack_end edit false false 0)
    (win:add box)
  )
  (win:set_titlebar
    (Gtk.HeaderBar {
      :title "Calculator"
      :subtitle "Simple Numeric Evaluator"
      :show_close_button true
      }))
)

(fn app.on_activate [self]
  (build_ui self.active_window)
  (self.active_window:show_all)
  (self.active_window:present)
)

(app:run arg)

