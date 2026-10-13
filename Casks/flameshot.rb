cask "flameshot" do
  arch arm: "arm64", intel: "intel"

  version "14.0.0,14.0"
  sha256 arm:   "bb0cccb2223ce0f4bfea00d90658e85fb5dc17aa7773bf2b22c70ffdb23d7221",
         intel: "871653260d9298db2e2a85e121c514f753dfdca94dccabbd74c142a2438f3d78"

  url "https://github.com/flameshot-org/flameshot/releases/download/v#{version.csv.first}/Flameshot-#{version.csv.second}-macos-#{arch}.dmg"
  name "Flameshot"
  desc "Screenshot software with built-in annotation tools"
  homepage "https://flameshot.org/"

  livecheck do
    url :url
    regex(%r{/v?(\d+(?:\.\d+)+)/Flameshot-(\d+(?:\.\d+)+)-macos-arm64\.dmg}i)
    strategy :github_latest do |json, regex|
      json["assets"]&.map do |asset|
        match = asset["browser_download_url"]&.match(regex)
        next if match.blank?

        "#{match[1]},#{match[2]}"
      end
    end
  end

  depends_on macos: :sequoia

  app "Flameshot.app"

  # The app is not notarized, so Gatekeeper blocks it unless the quarantine flag is removed.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Flameshot.app"],
        writable_paths: ["Flameshot.app"],
        writable_base:  :appdir
  end

  uninstall quit: "org.flameshot.flameshot"

  zap trash: [
    "~/.config/flameshot",
    "~/Library/Caches/flameshot",
  ]
end
