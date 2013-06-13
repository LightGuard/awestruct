require 'spec_helper'

require 'awestruct/page'

describe 'Awestruct::Page' do
  before(:each) do
    @site = double()
    @site.stub_chain(:config, :dir).and_return('spec')
  end
  context 'a basic page' do
    subject(:page) { ::Awestruct::Page.new '', @site }
    it { should respond_to :front_matter }
    it { should respond_to :layout }
    it { should respond_to :render }
    it { should respond_to :dependencies }
    it { should respond_to :relative_source_path }
    it { should respond_to :output_path }
    it { should respond_to :output_filename }
    it { should respond_to :source_path }
    it { should respond_to :raw_content }
    it { should respond_to :rendered_content }
    it { should respond_to :content }
    it { should respond_to :== }
  end
  context 'a page with front-matter' do
    subject(:page) { Awestruct::Page.new 'test-data/front-matter-file-no-content.txt', @site }
    it { page.front_matter.should eql 'foo' => 'bar' }
    it { page.source_path.should eql 'test-data/front-matter-file-no-content.txt' }
  end
  context 'a page with content' do
    subject(:page) { Awestruct::Page.new 'test-data/simple-file.txt', @site }
    it { page.raw_content.should_not be_nil }
    it { page.raw_content.should eql "howdy\n" }
    it { page.source_path.should eql 'test-data/simple-file.txt' }
  end
  context 'should accept a string as content' do
    subject(:page) { Awestruct::Page.new 'testing', @site }
    it { page.raw_content.should eql 'testing' }
    it { page.source_path.should be_nil }
  end
end

