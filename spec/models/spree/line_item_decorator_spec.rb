require 'spec_helper'

describe Spree::LineItem do
  describe 'validations' do
    context 'when point of sale is true for order' do
      before { subject.order = FactoryGirl.build(:spree_order, :with_pos) }

      it 'validates through Spree::Stock::PosAvailabilityValidator' do
        subject._validators[nil].detect do |validator|
          validator.class == Spree::Stock::PosAvailabilityValidator
        end.should_not nil
      end

      it 'doesn\'t validate through Spree::Stock::AvailabilityValidator' do
        expect_any_instance_of(Spree::Stock::AvailabilityValidator).to_not receive(:validate)
        subject.valid?
      end
    end

    context 'when point of sale is false for order' do
      before { subject.order = FactoryGirl.build(:spree_order, :without_pos) }

      it 'validates through Spree::Stock::AvailabilityValidator' do
        expect_any_instance_of(Spree::Stock::AvailabilityValidator).to receive(:validate)
        subject.valid?
      end

      it 'doesn\'t validate through Spree::Stock::PosAvailabilityValidator' do
        expect_any_instance_of(Spree::Stock::PosAvailabilityValidator).to_not receive(:validate)
        subject.valid?
      end
    end
  end
end
