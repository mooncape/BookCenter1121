Mercury::Engine.routes.draw do
  match '/editor(/*requested_uri)' => "mercury#edit", :as => :mercury_editor


  get "mercury/modals/realupload"
  get "mercury/modals/upload"
  post "mercury/modals/mercurysave"

  scope '/mercury' do
    match ':type/:resource' => "mercury#resource"
    match 'snippets/:name/options' => "mercury#snippet_options"
    match 'snippets/:name/preview' => "mercury#snippet_preview"
  end
end
