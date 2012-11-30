Demo::Application.routes.draw do


  get "preview/show"

    namespace :mercury do
      resources :images
    end

  mount Mercury::Engine => '/'

  root :to => "say#index"

  namespace :appendix do
    resources :preview do
      member { put :mercury_update}
    end
  end

  get "say/index"
  get "say/login"

  get "say/uploadfile"
  get "say/listfiles"
  get "say/listconvertedfiles"
  get "say/listbookcontents"

  
  get "appendix/YHTop"
  get "appendix/YHMenu"
  get "appendix/YHChannelApply"
  get "appendix/YHPreview"

  get "appendix/YHUpload"
  get "appendix/YHList"  
  get "appendix/YHConvertedList"
  get "appendix/YHChapterList"
  get "appendix/YHListContents"

  post "appendix/save"
  post "appendix/mercurysave"
  post "appendix/list"

  get "appendix/delete"
  get "appendix/deletefolder"
  get "appendix/deletepage"
  get "appendix/deletechapter"
  get "appendix/convert"
  get "appendix/download"

  get "appendix/listconverted"

  get "appendix/preview/prevpage"
  get "appendix/preview/nextpage"



  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
