class Iamy < Formula
  desc "Envato fork of 99Designs IAMy IAM Object and S3 Bucket Policy Management tool"
  homepage "https://github.com/envato/iamy"
  url "https://github.com/envato/iamy/archive/refs/tags/v5.1.0.tar.gz"
  version "5.1.0+envato"
  sha256 "5a1c29f2e0d6568e46fcf12affb8df4fd42cde599cb45571106ca489b186615c"
  license "MIT"

  bottle do
    root_url "https://github.com/envato/homebrew-envato-iamy/releases/download/iamy-5.0.1+envato"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "083874449cef41cb569fbf1abf955cdb3960bc0c2afaa69d252c97791c6dcb61"
    sha256 cellar: :any_skip_relocation, big_sur:       "cfc1c5bc2590b2639b31fcc5b89e410264c1398072c1b75a85fbd7106575e33c"
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
