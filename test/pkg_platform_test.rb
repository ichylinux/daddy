require 'minitest/autorun'

# The platform detection lives in a recipe so that it works under mitamae,
# which cannot require files from lib/. The recipe only relies on node[],
# so it can be evaluated with a small stand-in for itamae's node object.
class PkgPlatformTest < Minitest::Test
  RECIPE = ::File.expand_path('../itamae/environments/lib/pkg_platform.rb', __dir__)

  class Node
    def initialize(attributes = {})
      @attributes = attributes
    end

    def [](key)
      @attributes[key]
    end

    def []=(key, value)
      @attributes[key] = value
    end
  end

  def resolve(attributes = {})
    node = Node.new(attributes)
    eval(::File.read(RECIPE), binding, RECIPE, 1)
    node[:pkg_platform]
  end

  def test_redhat_from_platform_family
    assert_equal :redhat, resolve(platform_family: 'rhel')
  end

  def test_debian_from_platform
    assert_equal :debian, resolve(platform: 'ubuntu')
  end

  # mitamae local sets platform but leaves platform_family empty.
  def test_mitamae_style_platform_without_family
    assert_equal :redhat, resolve(platform: 'redhat', platform_family: '')
  end

  def test_unknown_platform_falls_back_to_marker_files
    expected = ::File.exist?('/etc/debian_version') ? :debian : :redhat
    assert_equal expected, resolve(platform: 'unknown-os')
  end

  def test_conflicting_families_are_rejected
    error = assert_raises(RuntimeError) do
      resolve(platform: 'debian', platform_family: 'rhel')
    end
    assert_match(/混在/, error.message)
  end
end
