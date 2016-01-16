Spree::LineItem.class_eval do
  validates_with Spree::Stock::PosAvailabilityValidator, if: -> { order.is_pos? }

  # remove the validation of Spree::Stock::Availability and then re assign it to be for only non-pos orders
  _validators[nil].reject! { |v| v.class == Spree::Stock::AvailabilityValidator }
  availability_validator_callbacks = _validate_callbacks.select { |vc| vc.raw_filter.class == Spree::Stock::AvailabilityValidator }
  availability_validator_callbacks.each { |vc| _validate_callbacks.delete(vc) }

  validates_with Spree::Stock::AvailabilityValidator, unless: -> { order.is_pos? }
end
