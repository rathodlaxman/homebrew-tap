class Tidyline < Formula
  include Language::Python::Virtualenv

  desc "Offline, read-only audit of a Things 3 database"
  homepage "https://github.com/rathodlaxman/tidyline"
  url "https://files.pythonhosted.org/packages/48/a7/38ab4ce6ba1de577bb9f844963f79ba162779d9d277a761ed43187f97c5c/tidyline-0.3.1.tar.gz"
  sha256 "5d00539f822566d63f46d38853d0d28829c83df662b72d90ce0ce9a72c9491e5"
  license "MIT"

  depends_on :macos
  depends_on "python@3.14"

  resource "things-py" do
    url "https://files.pythonhosted.org/packages/8a/f7/7ca01abf3927ed680688e2ce4c608f0c252dc224134ca2b1f04940db0efd/things_py-1.0.1.tar.gz"
    sha256 "6d760727e57c0cfb85f18a63b36459287573f7d7c0442874a76d4ef38b92089d"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    # Only --version and --help: they never open the Things database.
    assert_equal "tidyline #{version}", shell_output("#{bin}/tidyline --version").strip
    help = shell_output("#{bin}/tidyline --help")
    assert_match "usage: tidyline", help
    assert_match "report", help
  end
end
