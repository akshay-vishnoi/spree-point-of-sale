FactoryGirl.define do
  factory :spree_order, class: Spree::Order do
    trait :with_pos do
      is_pos true
    end

    trait :without_pos do
      is_pos false
    end

    trait :paid do
      payment_state 'paid'
    end

    trait :unpaid do
      payment_state 'checkout'
    end
  end
end
