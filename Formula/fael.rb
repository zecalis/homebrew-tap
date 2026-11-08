class Fael < Formula
  desc "fael CLI — the repo's work ledger, handed to each agent at the file or chunk it works on"
  homepage "https://github.com/zecalis/fael"
  version "0.111.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zecalis/fael/releases/download/v0.111.0/fael-aarch64-apple-darwin.tar.xz"
      sha256 "a36a9855969013c69b0f1d67d0bd76e007fc938d293c1f8da3a0b3812decf2cc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zecalis/fael/releases/download/v0.111.0/fael-x86_64-apple-darwin.tar.xz"
      sha256 "bed8df61853e28bdbab0bb34f4f741ddff47c3cfa4f8254e962f1d9ed5ee0b28"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/zecalis/fael/releases/download/v0.111.0/fael-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8fc3b74c9f51f1de9878f8a5862504364b2eef23892b56cb539cb2026ee636b0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zecalis/fael/releases/download/v0.111.0/fael-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7736d3b145fcff1e504ce1a75b6999455b472e6fb4e23f20bbfdc95e5a199ae5"
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
