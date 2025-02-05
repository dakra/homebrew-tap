class Autoraise < Formula
  desc "Focus-follows-mouse for MacOS"
  homepage "https://github.com/sbmpost/AutoRaise"
  head "https://github.com/sbmpost/AutoRaise.git"
  sha256 "641f1a3be0898222dd0e2455767fcd43b9731e8b"
  license "GPL-3.0"

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
