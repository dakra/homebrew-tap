class Imapgoose < Formula
  desc "Keep local Maildir directories synchronised with an IMAP server"
  homepage "https://git.sr.ht/~whynothugo/ImapGoose"
  url "https://git.sr.ht/~whynothugo/ImapGoose/archive/v0.2.4.tar.gz"
  version "0.2.4"
  sha256 "7e93ae30a1c4d30fd84c18687b384e8491c5714dcd7defe45db3e0493d0f83bf"
  license "ISC"

  depends_on "go" => :build

  service do
    run [opt_bin/"imapgoose"]
    keep_alive true
    log_path "/tmp/homebrew.imapgoose.stdout.log"
    error_log_path "/tmp/homebrew.imapgoose.stderr.log"
    working_dir ENV["HOME"]
    run_type :immediate
    process_type :background
    environment_variables PATH: std_service_path_env
  end

  def install
    system "make", "build"
    bin.install "imapgoose"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/imapgoose --version")
  end
end
