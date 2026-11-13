class Fael < Formula
  desc "fael CLI — the repo's work ledger, handed to each agent at the file or chunk it works on"
  homepage "https://github.com/zecalis/fael"
  version "0.116.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zecalis/fael/releases/download/v0.116.0/fael-aarch64-apple-darwin.tar.xz"
      sha256 "d4d6311eb14fda3a0a0807d15d85de41f39afcbebfa2288078e50974caf4e0dc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zecalis/fael/releases/download/v0.116.0/fael-x86_64-apple-darwin.tar.xz"
      sha256 "731870e0b09af4dd0944c6a15531a8c3065d572b9550a741c8ef99d31b82c850"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/zecalis/fael/releases/download/v0.116.0/fael-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b0b555a371238c1175c25734d06d084d5cbaaa5e572cc2bf57ede08941024fd8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zecalis/fael/releases/download/v0.116.0/fael-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8579540935aba387429122a0f72823233f7de9ed31f37f5294c55da093f0976e"
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
