class Iamy < Formula
  desc "Envato fork of 99Designs IAMy IAM Object and S3 Bucket Policy Management tool"
  homepage "https://github.com/envato/iamy"
  url "https://github.com/envato/iamy/archive/refs/tags/v2.4.4.tar.gz"
  version "2.4.4+envato"
  sha256 "c8d859a7b34e743cc135b3c6fe7903a725faa71e01f23cb060b39f7f361c44cd"
  license "MIT"

  bottle do
    root_url "https://github.com/envato/iamy/releases/download/v2.4.4"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "9b02c1343266fa06c8cf93c03aefd429483b57a982445423d30c0fb120f2ad9c"
    sha256 cellar: :any_skip_relocation, big_sur:       "f89bd6b002969645e1c4b37e5b9994d7add10b1bf946a43a079257dd63ff83df"
    sha256 cellar: :any_skip_relocation, catalina:      "ea7e387dcfe89c8736f5dfeb2e746363672be513183b0197e971805d438fa4be"
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
