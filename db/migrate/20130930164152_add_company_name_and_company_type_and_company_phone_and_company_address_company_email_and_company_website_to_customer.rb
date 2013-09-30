class AddCompanyNameAndCompanyTypeAndCompanyPhoneAndCompanyAddressCompanyEmailAndCompanyWebsiteToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :company_name, :string
    add_column :customers, :company_address, :string
    add_column :customers, :company_type, :string
    add_column :customers, :company_phone, :string
    add_column :customers, :company_email, :string
    add_column :customers, :company_website, :string
  end
end
