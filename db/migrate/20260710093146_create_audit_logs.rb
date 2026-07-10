class CreateAuditLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :audit_logs do |t|
      t.string :action
      t.references :user, null: false, foreign_key: true
      t.string :target_type
      t.integer :target_id
      t.string :ip_address
      t.text :details

      t.timestamps
    end
  end
end
