class Fael < Formula
  desc "fael CLI — the repo's work ledger, handed to each agent at the file or chunk it works on"
  homepage "https://github.com/zecalis/fael"
  version "0.64.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zecalis/fael/releases/download/v0.64.1/fael-aarch64-apple-darwin.tar.xz"
      sha256 "5a3da676dfeb21ed5ecb74577cf684c6aaead1b6a3d2f5571748d272f537e8b5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zecalis/fael/releases/download/v0.64.1/fael-x86_64-apple-darwin.tar.xz"
      sha256 "1b959e99e9f9bdd8ccafa2e48a75ef23b8575c3695201dfc228d7dc692713127"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/zecalis/fael/releases/download/v0.64.1/fael-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "774f419499d3c6802a36453e8867aaf292546d7a35c5c3f540b09bc5e8f7c3b0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zecalis/fael/releases/download/v0.64.1/fael-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "df0948d157bcc917ab333f0c5036964f4b14186b253f9cd7af68109560132229"
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
