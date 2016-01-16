require 'spec_helper'

describe Spree::PaymentMethod::PointOfSale do
  let(:point_of_sale) { FactoryGirl.build(:spree_payment_method_point_of_sale) }
  let(:pending_payment) { FactoryGirl.build(:spree_payment, :with_pending_state) }
  let(:checkout_payment) { FactoryGirl.build(:spree_payment, :with_checkout_state) }
  let(:void_payment) { FactoryGirl.build(:spree_payment, :with_void_state) }

  describe '#actions' do
    it 'returns actions available' do
      expect(point_of_sale.actions).to eq([:capture, :void])
    end
  end

  describe '#can_capture?' do
    context 'when payment is checkout' do
      it 'returns true' do
        expect(point_of_sale.can_capture?(checkout_payment)).to be true
      end
    end

    context 'when payment is pending' do
      it 'returns true' do
        expect(point_of_sale.can_capture?(pending_payment)).to be true
      end
    end
    context 'when payment is neither checkout nor pending' do
      it 'returns false' do
        expect(point_of_sale.can_capture?(void_payment)).to be false
      end
    end
  end

  describe '#can_void?' do
    context 'when payment is void' do
      it 'returns false' do
        expect(point_of_sale.can_void?(void_payment)).to be false
      end
    end

    context 'when payment is not void' do
      it 'returns true' do
        expect(point_of_sale.can_void?(checkout_payment)).to be true
      end
    end
  end

  describe '#source_required?' do
    it 'returns false' do
      expect(point_of_sale.source_required?).to be false
    end
  end

  describe '#capture' do
    it 'initialize billing response with success' do
      expect(ActiveMerchant::Billing::Response).to receive(:new).with(true, "", {}, {}).and_return(true)
      point_of_sale.capture
    end
  end

  describe '#void' do
    it 'is an alias of #capture' do
      expect(subject.method(:void)).to eq(subject.method(:capture))
    end
  end
end
