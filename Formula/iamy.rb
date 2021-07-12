class Iamy < Formula
  desc "Envato fork of 99Designs IAMy IAM Object and S3 Bucket Policy Management tool"
  homepage "https://github.com/envato/iamy"
  url "https://github.com/envato/iamy/archive/refs/tags/v3.1.0.tar.gz"
  version "3.1.0+envato"
  sha256 "6d96b99460f4390ceb3ab3193400f5b86d955d34fbbc3b19b513fa237f28b229"
  license "MIT"

  bottle do
    root_url "https://github.com/envato/homebrew-envato-iamy/releases/download/iamy-3.1.0+envato"
    sha256 cellar: :any_skip_relocation, catalina:      "7912b4342315de4ea452ba4a7e34750505bf0720c2eb43c889862e9c867ee494"
    sha256 cellar: :any_skip_relocation, big_sur:       "4e57908264f3253f21cbbc7dcb48c9a08b9121d250267ec9027e07c501f0c03a"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "2e53a81f4b234f3a2c4c6b94c55c223e8df715e28621a482d1e548db3f56e62c"
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
