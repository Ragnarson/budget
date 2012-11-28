class UpdateDataForProductionUsers < ActiveRecord::Migration
  def up
    User.all.each do |user|
      if user.families.empty?
        if user.invited_by
          @family = FamiliesUsers.where(:user_id => user.invited_by).first
          @family_id = @family.family_id
          @user_family = FamiliesUsers.create(:family_id => @family_id, :user_id => user.id)
          @user_family.save
        else
          @family = Family.create()
          @family.save
          @family_id = @family.id
          @user_family = FamiliesUsers.create(:family_id => @family_id, :user_id => user.id)
          @user_family.save
        end
      else
        @family_id = user.families.first.id
      end

      @wallets = Wallet.where(:user_id => user.id)
      if !@wallets.empty?
        @wallets.each do |w|
          w.update_attribute :family_id, @family_id
        end
      end

      @incomes = Income.where(:user_id => user.id)
      if !@incomes.empty?
        @incomes.each do |i|
          i.update_attribute :family_id, @family_id
        end
      end
    end
  end
end
