class AddInvitedUserIdToApplicants < ActiveRecord::Migration[5.2]
  def change
    add_column :applicants, :invited_user_id, :bigint
  end
end
