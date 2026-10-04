class Fael < Formula
  desc "fael CLI — a repo's memory that agents can't skip writing"
  homepage "https://github.com/zecalis/fael"
  version "0.25.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zecalis/fael/releases/download/v0.25.1/fael-aarch64-apple-darwin.tar.xz"
      sha256 "b1c7713719b5a5980a817d61095f342b015b6113c78754bced2db078eca03de4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zecalis/fael/releases/download/v0.25.1/fael-x86_64-apple-darwin.tar.xz"
      sha256 "bb8c99844d1edbb57f53a6a1232f7585a1d3b859dd71b5f48d07e814d041dd51"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/zecalis/fael/releases/download/v0.25.1/fael-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7ab0132e5107a68a89212a1c15448ccdef6a9d98c41086543fdcbd2aa1a6c87c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zecalis/fael/releases/download/v0.25.1/fael-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7441c714ec2c97c6de8e9c4b819bc946d8fc37f8cfcca55a680d161e8efe0bd7"
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
