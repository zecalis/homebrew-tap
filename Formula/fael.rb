class Fael < Formula
  desc "fael CLI — the repo's work ledger, handed to each agent at the file or chunk it works on"
  homepage "https://github.com/zecalis/fael"
  version "0.90.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zecalis/fael/releases/download/v0.90.1/fael-aarch64-apple-darwin.tar.xz"
      sha256 "a2ecaccd1b27d59dc11ed6dc143e0aa75a61b8e599454d3d336112dd348cb1e7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zecalis/fael/releases/download/v0.90.1/fael-x86_64-apple-darwin.tar.xz"
      sha256 "4088011856ee165557c6ef5ce829664aca77ceaf0293576f16bbd938c9de935f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/zecalis/fael/releases/download/v0.90.1/fael-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bde53bda53a913957ddb15d889fa222cdd395f47ffc2228da1076480c3e03d62"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zecalis/fael/releases/download/v0.90.1/fael-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "813dd35e15e09aa72c2bf7ced6de3f5a18d6e20166875b513d087b21b43bcc8c"
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
