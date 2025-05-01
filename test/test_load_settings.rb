gem 'minitest'
require 'minitest/autorun'
require 'choices_settings'
require 'pathname'

describe ChoicesSettings do
  before do
    path = Pathname.new(__FILE__)
    @without_local = path + '../settings/without_local.yml'
    @with_local = path + '../settings/with_local.yml'
  end

  describe 'when loading a settings file' do
    it 'should return a mash for the specified environment' do
      ChoicesSettings.load_settings(@without_local, 'defaults').name.must_equal 'Defaults'
      ChoicesSettings.load_settings(@without_local, 'production').name.must_equal 'Production'
    end

    it 'should load the local settings' do
      ChoicesSettings.load_settings(@with_local, 'defaults').name.must_equal 'Defaults'
      ChoicesSettings.load_settings(@with_local, 'development').name.must_equal 'Development'
      ChoicesSettings.load_settings(@with_local, 'production').name.must_equal 'Production local'
    end

    it 'should raise an exception if the environment does not exist' do
      error = lambda {
        ChoicesSettings.load_settings(@with_local, 'nonexistent')
      }.must_raise(IndexError)
      error.message.must_equal %(Missing key for "nonexistent" in `#{@with_local}')
    end
  end
end
