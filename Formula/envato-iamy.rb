class EnvatoIamy < Formula
  desc "Envato fork of 99Designs IAMy IAM Object and S3 Bucket Policy Management tool"
  homepage "https://github.com/envato/iamy"
  url "https://github.com/envato/iamy/archive/refs/tags/v3.0.0.tar.gz"
  version "3.0.0"
  sha256 "b8ceb153b3a92eb8e9382c360d9a91e9cfb975090d3ed83b0ba9af9746fea12b"
  license "MIT"

  depends_on "go" => :build
  depends_on "awscli"

  conflicts_with "iamy", because: "envato-iamy also ships an iamy binary"

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
