class Autoraise < Formula
  desc "Focus-follows-mouse for MacOS"
  homepage "https://github.com/sbmpost/AutoRaise"
  url "https://github.com/sbmpost/AutoRaise/archive/refs/tags/v5.7.tar.gz"
  sha256 "42476a8e84815d42539fd51a5a051254ac18f289b26f00ae14fafcc956080c13"
  license "GPL-3.0-only"
  head "https://github.com/sbmpost/AutoRaise.git", branch: "master"

  def install
    system "make", "AutoRaise", "CXXFLAGS=-DOLD_ACTIVATION_METHOD -DEXPERIMENTAL_FOCUS_FIRST"
    bin.install "AutoRaise"
  end

  service do
    run [opt_bin/"AutoRaise", "-delay", "0", "-focusDelay", "1"]
    log_path "#{Dir.home}/Library/Logs/AutoRaise.log"
    error_log_path "#{Dir.home}/Library/Logs/AutoRaise.log"
  end

  test do
    assert_path_exists bin/"AutoRaise"
    assert_predicate bin/"AutoRaise", :executable?
  end
end
