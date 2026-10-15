class Fael < Formula
  desc "fael CLI — the repo's work ledger, handed to each agent at the file or chunk it works on"
  homepage "https://github.com/zecalis/fael"
  version "0.61.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zecalis/fael/releases/download/v0.61.0/fael-aarch64-apple-darwin.tar.xz"
      sha256 "e6fbae67a005588624099e84a72cb52e6175c2ea5a55c7c8d93c24c60b01f1be"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zecalis/fael/releases/download/v0.61.0/fael-x86_64-apple-darwin.tar.xz"
      sha256 "f069a9a461104fb7e35af0b68a02608011b69ca21adfc3d0f5ae7df014738175"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/zecalis/fael/releases/download/v0.61.0/fael-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b4aaa2aa32a8759206393b749faf1a1cbef1591f79c19c1ef8a11de73fb01802"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zecalis/fael/releases/download/v0.61.0/fael-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b1c181bbfc0d95c59d3eb7b6a60ef18837621556bf30818cd8fd6e1cca36c738"
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
