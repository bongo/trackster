caerus_form_for property, :html => {:multipart => true} do |property|
  fieldset property.object.new_record? ? t('.new_property') : t('.edit_property', :name => property.object.name) do
    if current_user.has_role?(Role::ADMIN_ROLE)
      property.collection_select :account_id, Account.all, :id, :name
    end
    property.text_field     :name,              :validate => :validations
    property.text_field     :url,               :validate => :validations
    property.text_field     :search_parameter,  :validate => :validations
    property.text_area      :description
    store(image_tag(property.object.thumb(:thumb))) if property.object.thumb?
    property.file_field     :thumb
    unless property.object.new_record?
      property.text_field   :tracker, :disabled => 'disabled' 
    end
  end
  submit_combo
end