class Contact < ActiveRecord::Base
  include Vcard::Import
  acts_as_taggable_on :permissions, :categories, :tags
  
  belongs_to    :account
  belongs_to    :created_by,          :class_name => "User", :foreign_key => :created_by
  belongs_to    :updated_by,          :class_name => "User", :foreign_key => :updated_by
  has_many      :actions,             :as => :actionable, :class_name => "History", :order => "created_at DESC"
  has_many      :updates,             :as => :historical, :class_name => "History"
  has_many      :notes,               :as => :notable
  has_many      :affiliates  
  has_many      :websites,            :autosave => true, :validate => true, :dependent => :destroy
  has_many      :emails,              :autosave => true, :validate => true, :dependent => :destroy
  has_many      :instant_messengers,  :autosave => true, :validate => true, :dependent => :destroy
  has_many      :phones,              :autosave => true, :validate => true, :dependent => :destroy
  has_many      :addresses,           :autosave => true, :validate => true, :dependent => :destroy do
    # How to decide if an address exists?
    # Street address is almost useless since its format
    # varies widely.  We'll use city, region, country
    # and kind as the "close enough" test.
    def find_by_vcard(card_address)
      conditions = {}
      ["locality", "region", "country", "postalcode"].each do |a|
        conditions[a] = card_address.send(a) unless card_address.send(a).blank?
      end
      conditions["kind"] = card_address.location.first
      find(:first, :conditions => sanitize_sql_for_conditions(conditions))
    end
  end
  
  has_attached_file :photo, :styles => { :thumbnail=> "200x200#", :small  => "150x150>", :avatar => "50x50#" },
                    :convert_options => { :all => "-unsharp 0.3x0.3+3+0" }
   
  accepts_nested_attributes_for :websites,            
                                :allow_destroy => true, 
                                :reject_if => proc { |attributes| attributes['url'].blank? }
  accepts_nested_attributes_for :emails,              
                                :allow_destroy => true, 
                                :reject_if => proc { |attributes| attributes['address'].blank? }
  accepts_nested_attributes_for :instant_messengers,  
                                :allow_destroy => true, 
                                :reject_if => proc { |attributes| attributes['name'].blank? }
  accepts_nested_attributes_for :phones,              
                                :allow_destroy => true, 
                                :reject_if => proc { |attributes| attributes['number'].blank? }
  accepts_nested_attributes_for :addresses,           
                                :allow_destroy => true, 
                                :reject_if => proc { |attributes| self.all_blank?(attributes) }
  accepts_nested_attributes_for :affiliates,          
                                :allow_destroy => true, 
                                :reject_if => proc { |attributes| attributes['address'].blank? }


  
  # Used by History#record which decides who the parent object is.  By default it
  # will look for a relevant belongs_to, but sometimes defining it directly is
  # appropriate.
  def refers_to
    self
  end
     
private      
  def self.all_blank?(attributes)
    attributes.each do |a|
      return false unless a.blank?
    end
    return true
  end
end
