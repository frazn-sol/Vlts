class RemoveCompanyNameAndCompanyAddressAndCompanyTypeAndCompanyPhoneAndCompanyWebsiteAndCompanyEmailFromCustomer < ActiveRecord::Migration
  def up
    remove_column :customers, :company_name
        remove_column :customers, :company_address
        remove_column :customers, :company_type
        remove_column :customers, :company_phone
        remove_column :customers, :company_website
        remove_column :customers, :company_email
      end

  def down
    add_column :customers, :company_email, :string
    add_column :customers, :company_website, :string
    add_column :customers, :company_phone, :string
    add_column :customers, :company_type, :string
    add_column :customers, :company_address, :string
    add_column :customers, :company_name, :string
  end
end
