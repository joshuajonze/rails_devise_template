# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User::Policy, type: :policy do
  subject { described_class }

  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  permissions :index? do
    it "allows admin to see all users" do
      expect(subject).to permit(admin, User)
    end

    it "restricts regular users to only see themselves" do
      expect(subject).to permit(user, User)
    end
  end

  permissions :show? do
    it "allows users to view their own profile" do
      expect(subject).to permit(user, user)
    end

    it "allows admins to view any profile" do
      expect(subject).to permit(admin, user)
    end

    it "prevents users from viewing other profiles" do
      expect(subject).not_to permit(user, other_user)
    end
  end

  permissions :update? do
    it "allows users to update their own profile" do
      expect(subject).to permit(user, user)
    end

    it "allows admins to update any profile" do
      expect(subject).to permit(admin, user)
    end

    it "prevents users from updating other profiles" do
      expect(subject).not_to permit(user, other_user)
    end
  end

  permissions :destroy? do
    it "allows admins to delete users" do
      expect(subject).to permit(admin, user)
    end

    it "prevents users from deleting their own account" do
      expect(subject).not_to permit(user, user)
    end

    it "prevents users from deleting other accounts" do
      expect(subject).not_to permit(user, other_user)
    end
  end

  permissions :update_password? do
    it "allows users to update their own password" do
      expect(subject).to permit(user, user)
    end

    it "prevents users from updating other users' passwords" do
      expect(subject).not_to permit(user, other_user)
    end

    it "prevents admins from updating user passwords" do
      expect(subject).not_to permit(admin, user)
    end
  end

  permissions :update_email? do
    it "allows users to update their own email" do
      expect(subject).to permit(user, user)
    end

    it "prevents users from updating other users' emails" do
      expect(subject).not_to permit(user, other_user)
    end

    it "prevents admins from updating user emails" do
      expect(subject).not_to permit(admin, user)
    end
  end

  permissions :confirm?, :resend_confirmation? do
    it "allows users to manage their own confirmation" do
      expect(subject).to permit(user, user)
    end

    it "prevents users from managing other users' confirmation" do
      expect(subject).not_to permit(user, other_user)
    end

    it "prevents admins from managing user confirmation" do
      expect(subject).not_to permit(admin, user)
    end
  end
end 