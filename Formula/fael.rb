class Fael < Formula
  desc "fael CLI — a repo's memory that agents can't skip writing"
  homepage "https://github.com/zecalis/fael"
  version "0.42.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zecalis/fael/releases/download/v0.42.0/fael-aarch64-apple-darwin.tar.xz"
      sha256 "251c13f0bd0917a41425ee1f35b4760e653e06c8c1de57b1f75d16f3ce6781cb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zecalis/fael/releases/download/v0.42.0/fael-x86_64-apple-darwin.tar.xz"
      sha256 "2c7026d0171de06ff78d004f97ca8f8c7e079cabad8b8eae698f796eba060681"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/zecalis/fael/releases/download/v0.42.0/fael-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cac7fe3b88b6b67f51f1af279cd57594ef3ef35a959e8baf99fccf2ac50edfd0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zecalis/fael/releases/download/v0.42.0/fael-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "66d1dcdc66325be82073f2446979cc7ccb447bda7596cf67a901dae152a27fa3"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "fael"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "fael"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "fael"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "fael"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
