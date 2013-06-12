require 'spec_helper'
require 'awestruct/page'

describe 'Awestruct::Page' do
  context 'a basic page' do
    subject(:page) { ::Awestruct::Page.new '', [] }
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
    subject(:page) { Awestruct::Page.new 'test-data/front-matter-file-no-content.txt', [] }
    it { page.front_matter.should eql [:foo => 'bar']}
  end
end
