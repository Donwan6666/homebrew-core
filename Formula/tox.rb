class Tox < Formula
  include Language::Python::Virtualenv

  desc "Generic Python virtualenv management and test command-line tool"
  homepage "https://tox.wiki/en/latest/"
  url "https://files.pythonhosted.org/packages/3d/86/fd0205bac6aea42a9ad0f52208d6a4c40fb0e4037566f4437a7c00744761/tox-4.4.9.tar.gz"
  sha256 "1883bda00dba70c0358ee4646188db0739e7057c9f6507cd0cf123c1a618443a"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "c6a6f9bdb29ab3e34434b8e947b1ea712fe04c6f58e9d027000c00799b518e76"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f61a1ee330f7904054ab3ebecad63e8e1a0f17fe7a8846433a83e812e1fa1ab7"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "8303342d5ef93c8ed08d73c954dce2631e5ff167bbb8dc6f508f3d8f1e9c4ef8"
    sha256 cellar: :any_skip_relocation, ventura:        "da7bf685b7f3884f536922039b52c6778827912d4294d734b6b9cdce5c6d77ee"
    sha256 cellar: :any_skip_relocation, monterey:       "8e3f3108c20d2d1482bbd7d4600fac0955fdeb1d3a846219fa54a4884fbdfd9a"
    sha256 cellar: :any_skip_relocation, big_sur:        "2f2d10e7f6192da58713bbff6b4af1f9dd78bd1df54ed005143a3b3408bd0e4a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fd39b9cb7993a1938be9b3125aaacd54a109d796a822b15b8e279b299ecaa87e"
  end

  depends_on "python@3.11"

  resource "cachetools" do
    url "https://files.pythonhosted.org/packages/4d/91/5837e9f9e77342bb4f3ffac19ba216eef2cd9b77d67456af420e7bafe51d/cachetools-5.3.0.tar.gz"
    sha256 "13dfddc7b8df938c21a940dfa6557ce6e94a2f1cdfa58eb90c805721d58f2c14"
  end

  resource "chardet" do
    url "https://files.pythonhosted.org/packages/41/32/cdc91dcf83849c7385bf8e2a5693d87376536ed000807fa07f5eab33430d/chardet-5.1.0.tar.gz"
    sha256 "0d62712b956bc154f85fb0a266e2a3c5913c2967e00348701b32411d6def31e5"
  end

  resource "colorama" do
    url "https://files.pythonhosted.org/packages/d8/53/6f443c9a4a8358a93a6792e2acffb9d9d5cb0a5cfd8802644b7b1c9a02e4/colorama-0.4.6.tar.gz"
    sha256 "08695f5cb7ed6e0531a20572697297273c47b8cae5a63ffc6d6ed5c201be6e44"
  end

  resource "distlib" do
    url "https://files.pythonhosted.org/packages/58/07/815476ae605bcc5f95c87a62b95e74a1bce0878bc7a3119bc2bf4178f175/distlib-0.3.6.tar.gz"
    sha256 "14bad2d9b04d3a36127ac97f30b12a19268f211063d8f8ee4f47108896e11b46"
  end

  resource "filelock" do
    url "https://files.pythonhosted.org/packages/5b/65/5dfde43d5e4d7d31a2392bf4aa20e464b8aa0601f34fd9b050781291f666/filelock-3.10.7.tar.gz"
    sha256 "892be14aa8efc01673b5ed6589dbccb95f9a8596f0507e232626155495c18105"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/47/d5/aca8ff6f49aa5565df1c826e7bf5e85a6df852ee063600c1efa5b932968c/packaging-23.0.tar.gz"
    sha256 "b6ad297f8907de0fa2fe1ccbd26fdaf387f5f47c7275fedf8cce89f99446cf97"
  end

  resource "platformdirs" do
    url "https://files.pythonhosted.org/packages/15/04/3f882b46b454ab374ea75425c6f931e499150ec1385a73e55b3f45af615a/platformdirs-3.2.0.tar.gz"
    sha256 "d5b638ca397f25f979350ff789db335903d7ea010ab28903f57b27e1b16c2b08"
  end

  resource "pluggy" do
    url "https://files.pythonhosted.org/packages/a1/16/db2d7de3474b6e37cbb9c008965ee63835bba517e22cdb8c35b5116b5ce1/pluggy-1.0.0.tar.gz"
    sha256 "4224373bacce55f955a878bf9cfa763c1e360858e330072059e10bad68531159"
  end

  resource "pyproject-api" do
    url "https://files.pythonhosted.org/packages/23/6f/d02d1cab4a30998806687036e03ffecbf66e35df6bfab5a29f22ec61a075/pyproject_api-1.5.1.tar.gz"
    sha256 "435f46547a9ff22cf4208ee274fca3e2869aeb062a4834adfc99a4dd64af3cf9"
  end

  resource "virtualenv" do
    url "https://files.pythonhosted.org/packages/87/14/ca9890d58cd33d9122eb87ffec2f3c6be0714785f992a0fd3b56a3b6c993/virtualenv-20.21.0.tar.gz"
    sha256 "f50e3e60f990a0757c9b68333c9fdaa72d7188caa417f96af9e52407831a3b68"
  end

  def install
    virtualenv_install_with_resources
  end

  # Avoid relative paths
  def post_install
    lib_python_path = Pathname.glob(libexec/"lib/python*").first
    lib_python_path.each_child do |f|
      next unless f.symlink?

      realpath = f.realpath
      rm f
      ln_s realpath, f
    end
  end

  test do
    assert_match "usage", shell_output("#{bin}/tox --help")
    system bin/"tox"
    pyver = Language::Python.major_minor_version(Formula["python@3.11"].opt_bin/"python3.11").to_s.delete(".")

    system bin/"tox", "quickstart", "src"
    (testpath/"src/test_trivial.py").write <<~EOS
      def test_trivial():
          assert True
    EOS
    chdir "src" do
      system bin/"tox", "run"
    end
    assert_predicate testpath/"src/.tox/py#{pyver}", :exist?
  end
end
