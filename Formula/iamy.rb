class Iamy < Formula
  desc "Envato fork of 99Designs IAMy IAM Object and S3 Bucket Policy Management tool"
  homepage "https://github.com/envato/iamy"
  url "https://github.com/envato/iamy/archive/refs/tags/v5.0.0.tar.gz"
  version "5.0.0+envato"
  sha256 "51e7c053336612ad318dc2b80713377c67f4bd05c2d88482cbd157d5012789ca"
  license "MIT"

  bottle do
    root_url "https://github.com/envato/homebrew-envato-iamy/releases/download/iamy-5.0.0+envato"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "9ed87e8cfbe30b222c7db90ce376fb28251764ac0e3135b51aff0dfcdda5b581"
    sha256 cellar: :any_skip_relocation, big_sur:       "ffe76126786921edc0482eb9c5e8d8e556ac60c80171e4d6585e43822b41a185"
  end

  depends_on "go" => :build
  depends_on "awscli"

  def install
    ENV["CGO_CFLAGS"] = "-mmacosx-version-min=10.15"
    ENV["CGO_LDFLAGS"] = "-mmacosx-version-min=10.15"
    system "go", "build", *std_go_args, "-ldflags",
            "-s -w -X main.Version=v#{version}"
  end

  test do
    ENV.delete "AWS_ACCESS_KEY"
    ENV.delete "AWS_SECRET_KEY"
    output = shell_output("#{bin}/iamy pull 2>&1", 1)
    assert_match "Can't determine the AWS account", output
  end
end
