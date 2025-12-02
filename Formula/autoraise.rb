class Autoraise < Formula
  desc "Focus-follows-mouse for MacOS"
  homepage "https://github.com/sbmpost/AutoRaise"
  url "https://github.com/sbmpost/AutoRaise/archive/refs/tags/v5.5.tar.gz"
  sha256 "6fc3625db0ffba3f49c494bf11bcccbaa8468beab3a9bcf8a542b2b51dbf81cf"
  license "GPL-3.0"
  version "5.5"
  head "https://github.com/sbmpost/AutoRaise.git"

  def install
    system "make", "clean"
    system "make CXXFLAGS='-DOLD_ACTIVATION_METHOD -DEXPERIMENTAL_FOCUS_FIRST'"
    bin.install "AutoRaise"
  end

  service do
    run [opt_bin/"AutoRaise", "delay=0", "focusDelay=1"]
    log_path "#{Dir.home}/Library/Logs/AutoRaise.log"
    error_log_path "#{Dir.home}/Library/Logs/AutoRaise.log"
  end

  test do
    assert_predicate bin/"AutoRaise", :exist?
    assert_predicate bin/"AutoRaise", :executable?
  end
end
