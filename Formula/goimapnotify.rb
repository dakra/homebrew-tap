class Goimapnotify < Formula
  desc "Execute scripts on IMAP mailbox changes using IDLE"
  homepage "https://gitlab.com/shackra/goimapnotify"
  url "https://gitlab.com/shackra/goimapnotify/-/archive/2.4/goimapnotify-2.4.tar.gz"
  version "2.4"
  sha256 "9eb05ed81a508555e607d56c5ba6c5bb2212d527de82e6a3cf27dd99dd0cf2cd"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end
end
