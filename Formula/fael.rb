class Fael < Formula
  desc "fael CLI — a repo's memory that agents can't skip writing"
  homepage "https://github.com/zecalis/fael"
  version "0.43.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zecalis/fael/releases/download/v0.43.0/fael-aarch64-apple-darwin.tar.xz"
      sha256 "eb89eb4c65577608347b6e6e2ed7b85e75405654fd5ff0d570d225fe7fc0a4ee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zecalis/fael/releases/download/v0.43.0/fael-x86_64-apple-darwin.tar.xz"
      sha256 "3a67eaf6518b421daee3473868f95d4e95a9616b5e710a3c35cd6a62c9c4ea1f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/zecalis/fael/releases/download/v0.43.0/fael-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a75c5491bf0a3fa778cb9a7bb2dca0ea163c3d348eb8d4b4d2bb1d23edcd1626"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zecalis/fael/releases/download/v0.43.0/fael-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "54d58c1a09ee0b743ef1681538d5ecf1253043d71fd3efd5e71739b32b8ef17f"
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
