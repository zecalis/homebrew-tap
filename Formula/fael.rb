class Fael < Formula
  desc "fael CLI — a repo's memory that agents can't skip writing"
  homepage "https://github.com/zecalis/fael"
  version "0.50.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zecalis/fael/releases/download/v0.50.0/fael-aarch64-apple-darwin.tar.xz"
      sha256 "6a437b9d1670988b5ae95a4c88d899d28e9acd08a107a5eb61dd9a9d2667f737"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zecalis/fael/releases/download/v0.50.0/fael-x86_64-apple-darwin.tar.xz"
      sha256 "e4da922a82ebe660943c7337fb303a333b105a5d02a8a1d2b539e3f242e99caa"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/zecalis/fael/releases/download/v0.50.0/fael-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "81d798f9a1ab7bfa6abf588e3a428a262820e14b23398e2c8c453d6a30ce64e6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zecalis/fael/releases/download/v0.50.0/fael-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b8f57e48f21e41012328f6693a64725d82157d029b5c68963c12e259f8718878"
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
