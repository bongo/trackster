module Analytics
  module ColumnFormats
    def self.included(base)
      base.class_eval do
        table_format :count,          :total => :sum, :order => 99
        table_format :event_count,    :order => 20
        table_format :impressions,    :total => :sum, :order => 1, :class => 'right', :formatter => :number_with_delimiter
        table_format :clicks_through, :total => :sum, :order => 2, :class => 'right', :formatter => :number_with_delimiter
        table_format :distribution,   :total => :sum, :class => 'right', :formatter => :integer_with_delimiter
        table_format :bounces,        :total => :sum, :class => 'right', :formatter => :integer_with_delimiter
        table_format :unsubscribes,   :total => :sum, :class => 'right', :formatter => :integer_with_delimiter
        table_format :page_views,     :total => :sum, :order => 99, :class => 'page_views right'
        table_format :visits,         :total => :sum, :order => 50, :class => 'right'
        table_format :page_views,     :total => :sum, :order => 50, :class => 'right'
        table_format :duration,       :total => :avg, :order => 90, :class => 'right', :formatter => :seconds_to_time
        table_format :hour,           :total => :avg, :order => 90, :class => 'right', :formatter => :hours_to_time

        table_format :campaign_name,  :order => -1
        table_format :deliveries,     :total => :sum, :order => 10, :class => 'right', :formatter => :integer_with_delimiter
        table_format :impressions,    :total => :sum, :order => 20, :class => 'right', :formatter => :integer_with_delimiter 
        table_format :cost,           :total => :sum, :order => 30, :class => 'right', :formatter => :integer_with_delimiter 
        table_format :cost_per_impression,  :total => :avg, :order => 40, :class => 'right', :formatter => :currency_no_sign

        table_format :clicks_through,  :total => :sum, :order => 22, :class => 'right', :formatter => :integer_with_delimiter
        table_format :click_through_rate, :total => :avg, :order => 25, :formatter => :bar_and_percentage
        table_format :cost_per_click, :total => :avg, :order => 50, :class => 'right', :formatter => :currency_no_sign

        table_format :label,          :order => -1, :formatter => :not_set_on_blank 
        table_format :value,          :class => 'right', :formatter => :integer_with_delimiter
        table_format :events,         :class => 'right', :formatter => :integer_with_delimiter
        
        table_format :referrer_host,  :order => -1, :formatter => :not_set_on_blank   
        table_format :page_title,     :order => -1, :formatter => :not_set_on_blank   
        table_format :language,       :order => -1, :formatter => :not_set_on_blank
        table_format :country,        :order => 0,  :formatter => :not_set_on_blank
        table_format :region,         :order => 1 #, :formatter => :not_set_on_blank
        table_format :locality,       :order => 2 #, :formatter => :not_set_on_blank
        table_format :os_name,        :order => -1, :formatter => :not_set_on_blank 
        table_format :device,         :class => 'left', :formatter => :not_set_on_blank             
        table_format :flash_version,  :class => 'left', :formatter => :not_set_on_blank               
        table_format :browser,        :order => -1, :formatter => :unknown_on_blank
        table_format :visitors,       :total => :sum, :order => 99, :class => 'visitors right'

        table_format :percent_of_visits,      :total => :sum, :order => 98, :formatter => :bar_and_percentage
        table_format :percent_of_page_views,  :total => :sum, :order => 98, :class => 'page_views', :formatter => :bar_and_percentage 
        table_format :open_rate,              :total => :sum, :order => 22, :class => 'page_views', :formatter => :bar_and_percentage 
        table_format :percent_of_impressions, :total => :sum, :order => 23, :class => 'page_views', :formatter => :bar_and_percentage 
        table_format :bounce_rate,            :total => :avg, :order => 101, :class => 'right', :formatter => :percentage
        table_format :exit_rate,              :total => :avg, :order => 97, :class => 'right', :formatter => :percentage  
        table_format :entry_rate,             :total => :avg, :order => 96, :class => 'right', :formatter => :percentage
        table_format :new_visit_rate,         :total => :avg, :order => 100, :class => 'right', :formatter => :percentage
        table_format :page_views_per_visit,   :total => :avg, :order => 99, :class => 'right', :formatter => :float_with_precision  

        table_format :length_of_visit,        :order => -1, 
                     :formatter => lambda{|val, options| "#{val} #{I18n.t('datetime.prompts.second').downcase}" }  
        table_format :visit_type,  :order => -1,
                     :formatter => lambda {|val, options| options[:cell_type] == :th ? val : I18n.t("properties.site_summary.#{val}") }
    
        table_format :color_depth, :class => 'left',
                     :formatter => lambda{ |val, options| 
                        if options[:cell_type] == :th
                          val
                        else
                          val.blank? ? I18n.t('unknown') : "#{val} #{I18n.t('bits')}"
                        end
                      }

        table_format :traffic_source,   :order => 0,
                     :formatter => lambda {|val, options| 
                       if options[:cell_type] == :th
                         val
                       else
                         val.blank? ? I18n.t('not_set') : I18n.t("properties.site_summary.#{val}", :default => val)
                       end
                      }
      end
    end
  end
end                