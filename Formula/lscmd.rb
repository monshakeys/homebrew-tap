class Lscmd < Formula
  desc "Shell command visualization tool - scan and display shell aliases and functions"
  homepage "https://github.com/monshakeys/lscmd"
  url "https://github.com/monshakeys/lscmd/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "598e0e47946ed72278c8b165db3ea60282d1980f7a83de4cb6b876dec644ae6d"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "crates/cli"
  end

  test do
    assert_match "lscmd", shell_output("#{bin}/lscmd --version")
  end
end
