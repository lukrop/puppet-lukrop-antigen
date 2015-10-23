require 'spec_helper'
describe 'antigen' do

  context 'with defaults for all parameters' do
    it { should contain_class('antigen') }
  end
end
