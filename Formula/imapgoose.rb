class Imapgoose < Formula
  desc "Keep local Maildir directories synchronised with an IMAP server"
  homepage "https://git.sr.ht/~whynothugo/ImapGoose"
  url "https://git.sr.ht/~whynothugo/ImapGoose/archive/v0.5.5.tar.gz"
  sha256 "9f87ecdde549a64b10eedfa8e37fb939edf69d67b14acc889a70f5432568557e"
  license "ISC"

  depends_on "go" => :build

  uses_from_macos "sqlite"

  service do
    run [opt_bin/"imapgoose"]
    keep_alive true
    log_path "/tmp/homebrew.imapgoose.stdout.log"
    error_log_path "/tmp/homebrew.imapgoose.stderr.log"
    working_dir Dir.home
    run_type :immediate
    process_type :background
    environment_variables PATH: std_service_path_env
  end

  def install
    system "go", "build", *std_go_args(tags: "libsqlite3"), "./cmd/imapgoose"
    man1.install "imapgoose.1"
    man5.install "imapgoose.conf.5"
    zsh_completion.install "contrib/_imapgoose"
  end

  def caveats
    <<~EOS
      Upgrading from 0.3.x or older requires migrating the status database once:
        imapgoose -m
    EOS
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/imapgoose -h 2>&1")
  end
end
