# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::UserPolicy, type: :policy do
  subject { described_class }

  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  permissions :index? do
    it "allows admin to see all users" do
      expect(subject).to permit(admin, User)
    end

    it "prevents regular users from seeing any users" do
      expect(subject).not_to permit(user, User)
    end
  end

  permissions :show? do
    it "allows admin to view any user" do
      expect(subject).to permit(admin, user)
    end

    it "prevents regular users from viewing any user" do
      expect(subject).not_to permit(user, other_user)
    end
  end

  permissions :create? do
    it "allows admin to create users" do
      expect(subject).to permit(admin, User)
    end

    it "prevents regular users from creating users" do
      expect(subject).not_to permit(user, User)
    end
  end

  permissions :update? do
    it "allows admin to update any user" do
      expect(subject).to permit(admin, user)
    end

    it "prevents admin from updating themselves" do
      expect(subject).not_to permit(admin, admin)
    end

    it "prevents regular users from updating any user" do
      expect(subject).not_to permit(user, other_user)
    end
  end

  permissions :destroy? do
    it "allows admin to delete any user" do
      expect(subject).to permit(admin, user)
    end

    it "prevents admin from deleting themselves" do
      expect(subject).not_to permit(admin, admin)
    end

    it "prevents regular users from deleting any user" do
      expect(subject).not_to permit(user, other_user)
    end
  end

  permissions :toggle_admin? do
    it "allows admin to toggle admin status" do
      expect(subject).to permit(admin, user)
    end

    it "prevents admin from toggling their own admin status" do
      expect(subject).not_to permit(admin, admin)
    end

    it "prevents regular users from toggling admin status" do
      expect(subject).not_to permit(user, other_user)
    end
  end

  permissions :reset_password? do
    it "allows admin to reset any user's password" do
      expect(subject).to permit(admin, user)
    end

    it "prevents admin from resetting their own password" do
      expect(subject).not_to permit(admin, admin)
    end

    it "prevents regular users from resetting passwords" do
      expect(subject).not_to permit(user, other_user)
    end
  end

  permissions :lock?, :unlock? do
    it "allows admin to lock/unlock any user" do
      expect(subject).to permit(admin, user)
    end

    it "prevents admin from locking/unlocking themselves" do
      expect(subject).not_to permit(admin, admin)
    end

    it "prevents regular users from locking/unlocking users" do
      expect(subject).not_to permit(user, other_user)
    end
  end
end 