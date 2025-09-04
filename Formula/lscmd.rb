class Lscmd < Formula
  desc "Shell command visualization tool - scan and display shell aliases and functions"
  homepage "https://github.com/monshakeys/lscmd"
  url "https://github.com/monshakeys/lscmd/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "dafc46814bfe6f7d974e57d6e3ed44540468db72844b51189b8c6f4b055e7de5"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "crates/cli"
  end

  test do
    assert_match "lscmd", shell_output("#{bin}/lscmd --version")
  end
end
