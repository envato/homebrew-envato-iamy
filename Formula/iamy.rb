class Iamy < Formula
  desc "Envato fork of 99Designs IAMy IAM Object and S3 Bucket Policy Management tool"
  homepage "https://github.com/envato/iamy"
  url "https://github.com/envato/iamy/archive/refs/tags/v2.5.0.tar.gz"
  version "2.5.0+envato"
  sha256 "68dc6a9aa9c5635c7005e203f2dd3f81ef14dce597a39305c390012b1f973ac7"
  license "MIT"

  bottle do
    root_url "https://github.com/envato/homebrew-envato-iamy/releases/download/iamy-2.5.0+envato"
    sha256 cellar: :any_skip_relocation, catalina:       "22ee5111191b2ad1951c5624e306e52ec455fe221d7024f310a3813dfd5b9241"
    sha256 cellar: :any_skip_relocation, big_sur:        "07f196ec85f28f15e8e471dcbe6809f5c3f6987f4494ad35c9843e5c3e64dce8"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "5a4e090d42fe76ae51af47c27dad17fee581d3cb974f0fcd11c8796d7045b371"
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
