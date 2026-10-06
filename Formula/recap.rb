class Recap < Formula
  desc "Summarise articles, web pages, YouTube videos and PDFs with a local AI model"
  homepage "https://github.com/rathodlaxman/recap"
  url "https://github.com/rathodlaxman/recap/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "e7eae0eac599325069196c1aa6ec9ffb7f1fb8fb103a8af455db692532600cf2"
  license "MIT"

  depends_on :macos

  def install
    pkgshare.install "recap.zsh", "samples", "Modelfile.g4", "Modelfile.sum"
    doc.install "README.md", "GETTING-STARTED.md", "CHANGELOG.md", "MANUAL.pdf"
  end

  def caveats
    <<~EOS
      Recap is a set of zsh commands. To switch it on, add this line to your ~/.zshrc,
      then open a new Terminal window:

        source #{opt_pkgshare}/recap.zsh

      Then run the one-time setup, which installs the Python packages and downloads
      the summarising model (about 4.6 GB):

        recapsetup

      Recap needs Ollama, which runs the model on your Mac. Install it from
      https://ollama.com and open it once before running recapsetup.

      Try it on a short sample (no internet needed):

        recap < #{opt_pkgshare}/samples/sample-article.txt

      New to Terminal? Read #{opt_share}/doc/recap/GETTING-STARTED.md
    EOS
  end

  test do
    assert_match "Recap #{version}",
                 shell_output("zsh -c 'source #{pkgshare}/recap.zsh; recap version'")
    assert_path_exists pkgshare/"samples/sample-article.txt"
    system "zsh", "-n", "#{pkgshare}/recap.zsh"
  end
end
