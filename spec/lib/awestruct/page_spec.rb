require 'spec_helper'
require 'awestruct/page'

describe Awestruct::Page do
  context 'a basic page' do
    let(:page) { Awestruct::Page.new }
    it { should respond_to(:front_matter) }
    it { should respond_to(:layout) }
    it { should respond_to(:render) }
    it { should respond_to(:dependencies) }
  end
end
