class Goimapnotify < Formula
  desc "Execute scripts on IMAP mailbox changes using IDLE"
  homepage "https://gitlab.com/shackra/goimapnotify"
  url "https://gitlab.com/shackra/goimapnotify/-/archive/2.5.8/goimapnotify-2.5.8.tar.gz"
  sha256 "616aae1f48fbe4e2afffd968e7c393d32075365a0a94aa7654ab7abe4b4ac1c6"
  license "GPL-3.0-or-later"

  depends_on "go" => :build

  service do
    run [opt_bin/"goimapnotify"]
    keep_alive true
    log_path "/tmp/homebrew.goimapnotify.stdout.log"
    error_log_path "/tmp/homebrew.goimapnotify.stderr.log"
    working_dir Dir.home
    run_type :immediate
    process_type :background
    environment_variables PATH: std_service_path_env
  end

  def install
    system "go", "build", *std_go_args(ldflags: "-X main.gittag=#{version}"), "./cmd/goimapnotify"
  end

  test do
    (testpath/"config.yml").write <<~YAML
      configurations:
        - username: test@example.com
    YAML

    output = shell_output("#{bin}/goimapnotify -conf #{testpath}/config.yml 2>&1", 1)
    assert_match "tag #{version}", output
  end
end
