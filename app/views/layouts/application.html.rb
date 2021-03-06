html do
  head do
    meta :"http-equiv" => "content-type", :content => "text/html;charset=utf-8"
  	header_link :rel => "icon", :type => "image/vnd.microsoft.icon", :href => "/vie.ico"
    title "#{Trackster::Config.banner}: #{controller._page_title}"
    stylesheet_merged (internet_explorer? ? :ie : :base), :media => "screen, print"
    stylesheet_merged "themes/#{current_account.theme}.css" if current_account && current_account.theme
    javascript_merged :base
    javascripts 'swfobject.js'
    javascript yield(:jstemplates)
  end
  body do
    include "widgets/branding"
    include "widgets/main_menu" 
    include "widgets/page_heading"
    
    store (yield(:page) || yield)
   
    clear do
      column :width => 12, :id => 'site_info' do
        include 'widgets/footer'
      end
    end
    case Rails.env 
      when "development"
        store "<script src='http://trackster.local/javascripts/tracker_debug.js' type='text/javascript' ></script>"
      when "staging"
        store "<script src='http://vietools.com:8080/_tks.js' type='text/javascript' ></script>"
      else
        store "<script src='http://vietools.com/_tks.js' type='text/javascript' ></script>"
    end
    javascript yield(:javascript)
    javascript tracker_script
  end
end