class Fael < Formula
  desc "fael CLI — a repo's memory that agents can't skip writing"
  homepage "https://github.com/zecalis/fael"
  version "0.41.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zecalis/fael/releases/download/v0.41.0/fael-aarch64-apple-darwin.tar.xz"
      sha256 "6162d7d40a8e69953b24d861c69f8e1d98d6dd1bf051e65a79e0f9bca2c3a22d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zecalis/fael/releases/download/v0.41.0/fael-x86_64-apple-darwin.tar.xz"
      sha256 "f2a170ff05a0120b38d5e1a5c6af9b87be1eeadd31a25b1d7fe1e3e6873d1148"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/zecalis/fael/releases/download/v0.41.0/fael-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "69f4fb61f478a45aceafef0b09b73a5f3e33c89e406d2772a2ee850d0bfc2ba3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zecalis/fael/releases/download/v0.41.0/fael-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d6cbddb20408341993cbbfb786729001a24a0471c3355e6b757c714cd35c8a5e"
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
