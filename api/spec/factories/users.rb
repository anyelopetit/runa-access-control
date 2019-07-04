# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'admin@runahr.com' }
    password { '12345678' }
    role { 0 }
  end
end
