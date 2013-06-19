require 'spec_helper'

require 'awestruct/page'

describe 'Awestruct::Page' do
  before(:each) do
    @site = double()
    @site.stub_chain(:config, :dir).and_return('spec')
    @site.stub(:output_dir).and_return('_site')
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
    it { page.foo.should eql 'bar' }
    it { page.relative_source_path.should eql 'test-data/front-matter-file-no-content.txt' }
  end
  context 'a page with content' do
    subject(:page) { Awestruct::Page.new 'test-data/simple-file.txt', @site }
    it { page.raw_content.should_not be_nil }
    it { page.raw_content.should eql "howdy\n" }
    it { page.relative_source_path.should eql 'test-data/simple-file.txt' }
  end
  context 'should accept a string as content' do
    subject(:page) { Awestruct::Page.new 'testing', @site }
    it { page.raw_content.should eql 'testing' }
    it { page.relative_source_path.should be_nil }
  end
  # The next three should be shared examples so I can refactor them a bit more, and be DRY
  context 'should give a correct output path and filename' do
    subject(:page) { Awestruct::Page.new 'test-data/page-loader/page-one.md', @site }
    it { page.output_path.should eql '_site/test-data/page-loader/page-one.html' }
    it { page.output_filename.should eql 'page-one.html' }
  end
  context 'should give a correct output path and filename if it is a regular file' do
    subject(:page) { Awestruct::Page.new 'test-data/simple-file.txt', @site }
    it { page.output_path.should eql '_site/test-data/simple-file.txt' }
    it { page.output_filename.should eql 'simple-file.txt' }
  end
  context 'should give a correct output path and filename with double extensions' do
    subject(:page) { Awestruct::Page.new 'test-data/page-loader/page-two.html.haml', @site }
    it { page.output_path.should eql '_site/test-data/page-loader/page-two.html' }
    it { page.output_filename.should eql 'page-two.html' }
  end
end

